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

    return render_template(
        "distribution/list.html",
        issuances=issuances
    )


@distribution_bp.route("/distribution/new", methods=["GET", "POST"])
@login_required
@staff_required
def create_distribution():
    form = IssuanceForm()

    approved_requests = (
        Request.query
        .filter_by(Status="Approved")
        .order_by(Request.RequestDate.asc())
        .all()
    )

    available_requests = []

    for req in approved_requests:
        issued_total = (
            db.session.query(
                func.coalesce(func.sum(Issuance.IssuedUnits), 0)
            )
            .filter(Issuance.Request_id == req.Request_id)
            .scalar()
        )

        if issued_total < req.Quantity:
            available_requests.append(req)

    form.Request_id.choices = [
        (
            req.Request_id,
            f"{req.Request_id} - {req.hospital.HospitalName} "
            f"({req.Quantity} units)"
        )
        for req in available_requests
    ]

    # Determine which request was selected
    selected_request_id = (
        request.args.get("Request_id")
        or request.form.get("Request_id")
    )

    if not selected_request_id and form.Request_id.choices:
        selected_request_id = form.Request_id.choices[0][0]

    form.Request_id.data = selected_request_id

    # Get compatible blood types and available quantities
    compatible_types = []

    if selected_request_id:
        compatible_types = db.session.execute(
            text("""
                SELECT
                    blood_type_id,
                    abo_group,
                    rh_factor,
                    SUM(available_units) AS available_units
                FROM vw_compatibleavailableunits
                WHERE Request_id = :request_id
                GROUP BY
                    blood_type_id,
                    abo_group,
                    rh_factor
                ORDER BY abo_group, rh_factor
            """),
            {"request_id": selected_request_id}
        ).fetchall()

    form.BloodTypeID.choices = [
        (
            row.blood_type_id,
            f"{row.abo_group}"
            f"{'+' if row.rh_factor == 'Positive' else '-'}"
            f" - {row.available_units} available"
        )
        for row in compatible_types
    ]

    # Process issuance
    if form.validate_on_submit():

        if not current_user.staff_id:
            flash(
                "Current staff account is not linked to a staff record.",
                "danger"
            )
            return render_template(
                "distribution/form.html",
                form=form,
                title="New Issuance"
            )

        try:
            db.session.execute(
                text("""
                    CALL sp_IssueBloodUnit(
                        :request_id,
                        :blood_type_id,
                        :quantity,
                        :staff_id
                    )
                """),
                {
                    "request_id": form.Request_id.data,
                    "blood_type_id": form.BloodTypeID.data,
                    "quantity": form.Quantity.data,
                    "staff_id": current_user.staff_id
                }
            )

            db.session.commit()

            flash(
                "Blood issued successfully.",
                "success"
            )

            return redirect(
                url_for("distribution.list_distributions")
            )

        except (IntegrityError, OperationalError) as e:
            db.session.rollback()

            flash(
                f"Could not issue: "
                f"{str(e.orig) if getattr(e, 'orig', None) else str(e)}",
                "danger"
            )

    return render_template(
        "distribution/form.html",
        form=form,
        title="New Issuance"
    )