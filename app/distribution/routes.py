from flask import render_template, redirect, url_for, flash, request
from flask_login import login_required, current_user
from sqlalchemy import text, func
from sqlalchemy.exc import IntegrityError, OperationalError
from app.distribution import distribution_bp
from app.distribution.forms import IssuanceForm
from app.extensions import db
from app.models.issuance import Issuance, IssuedBloodUnit
from app.models.request import Request
from app.models.inventory import Inventory
from app.auth.decorators import staff_required


@distribution_bp.route("/distribution")
@login_required
@staff_required
def list_distributions():
    issuances = Issuance.query.all()
    return render_template("distribution/list.html", issuances=issuances)


@distribution_bp.route("/distribution/new", methods=["GET", "POST"])
@login_required
@staff_required
def create_distribution():
    form = IssuanceForm()

    approved_requests = (
        Request.query.filter_by(Status="Approved")
        .order_by(Request.RequestDate.asc())
        .all()
    )
    form.Request_id.choices = [
        (
            req.Request_id,
            f"{req.Request_id} - {req.hospital.HospitalName} ({req.Quantity} units)",
        )
        for req in approved_requests
    ]

    selected_request_id = request.args.get("Request_id") or request.form.get(
        "Request_id"
    )

    if not selected_request_id and form.Request_id.choices:
        selected_request_id = form.Request_id.choices[0][0]

    form.Request_id.data = selected_request_id

    print("SELECTED REQUEST:", selected_request_id)
    compatible_units = []
    if selected_request_id:
        compatible_units = db.session.execute(
            text(
                """
                SELECT bloodUnit_id, abo_group, rh_factor, expiry_date, blood_vol, branchName
                FROM vw_CompatibleAvailableUnits
                WHERE Request_id = :request_id
                ORDER BY expiry_date ASC
                """
            ),
            {"request_id": selected_request_id},
        ).fetchall()

        print("COMPATIBLE UNITS:", compatible_units)

    form.BloodUnitID.choices = [
        (
            row.bloodUnit_id,
            f"{row.bloodUnit_id} - {row.abo_group}{'+' if row.rh_factor == 'Positive' else '-'} - {row.blood_vol}ml - {row.branchName} - exp {row.expiry_date}",
        )
        for row in compatible_units
    ]

    if form.validate_on_submit():
        if not current_user.staff_id:
            flash("Current staff account is not linked to a staff record.", "danger")
            return render_template(
                "distribution/form.html", form=form, title="New Issuance"
            )

        req = Request.query.get(form.Request_id.data)
        if req is None or req.Status != "Approved":
            flash("Only approved requests can be issued.", "danger")
            return render_template(
                "distribution/form.html", form=form, title="New Issuance"
            )

        request_unit_ids = {row.bloodUnit_id for row in compatible_units}
        if form.BloodUnitID.data not in request_unit_ids:
            flash(
                "Selected blood unit is not currently compatible and available for this request.",
                "danger",
            )
            return render_template(
                "distribution/form.html", form=form, title="New Issuance"
            )

        issued_total = (
            db.session.query(func.coalesce(func.sum(Issuance.IssuedUnits), 0))
            .filter(Issuance.Request_id == req.Request_id)
            .scalar()
        )
        if float(issued_total) >= req.Quantity:
            flash("This request is already fully fulfilled.", "danger")
            return render_template(
                "distribution/form.html", form=form, title="New Issuance"
            )

        issuance = Issuance(
            Issuance_id=1,
            Request_id=req.Request_id,
            StaffID=current_user.staff_id,
            IssuedUnits=form.IssuedUnits.data,
            IssueDate=form.IssueDate.data,
        )
        issued_link = IssuedBloodUnit(
            Issuance_id=form.Issuance_id.data,
            bloodUnit_id=form.BloodUnitID.data,
        )

        try:
            db.session.add(issuance)
            db.session.flush()

            db.session.add(issued_link)
            db.session.flush()

            updated_rows = (
                db.session.query(Inventory)
                .filter(
                    Inventory.bloodUnit_id == form.BloodUnitID.data,
                    Inventory.status == "Available",
                )
                .update({"status": "Issued"}, synchronize_session=False)
            )
            if updated_rows == 0:
                raise IntegrityError(
                    "Inventory status update failed", params=None, orig=None
                )


            db.session.commit()
            flash("Blood issued successfully.", "success")
            return redirect(url_for("distribution.list_distributions"))
        except (IntegrityError, OperationalError) as e:
            db.session.rollback()
            flash(
                f"Could not issue: {str(e.orig) if getattr(e, 'orig', None) else str(e)}",
                "danger",
            )

    return render_template("distribution/form.html", form=form, title="New Issuance")
