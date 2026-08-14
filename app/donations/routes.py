from datetime import date, timedelta

from flask import render_template, redirect, url_for, flash, request
from flask_login import login_required
from sqlalchemy.exc import IntegrityError, OperationalError
from app.donations import donations_bp
from app.donations.forms import DonationForm
from app.extensions import db
from app.models.donation import Donation
from app.models.blood_unit import BloodUnit
from app.models.donor import Donor, Deferral, TemporaryDeferral
from app.models.inventory import Branch


def _is_donor_eligible(donor_id):
    donor = Donor.query.get(donor_id)
    if donor is None:
        return (
            False,
            "Donor does not exist in the system. Please register the donor first.",
        )

    active_deferral = (
        Deferral.query.filter_by(donorID=donor_id)
        .outerjoin(
            TemporaryDeferral, Deferral.deferralID == TemporaryDeferral.deferralID
        )
        .filter(
            (TemporaryDeferral.tempDeferral_id.is_(None))
            | (TemporaryDeferral.endDate > date.today())
        )
        .first()
    )
    if active_deferral is not None:
        return False, "Donor currently has an active deferral and cannot donate."

    last_donation = (
        Donation.query.filter_by(donor_id=donor_id)
        .order_by(Donation.DonationDate.desc())
        .first()
    )
    if (
        last_donation is not None
        and (date.today() - last_donation.DonationDate).days < 56
    ):
        return False, "Donor has not waited long enough since the previous donation."

    return True, ""


def _next_blood_unit_id():
    last_unit = BloodUnit.query.order_by(BloodUnit.bloodUnit_id.desc()).first()
    if last_unit is None:
        return "BU001"
    try:
        next_number = int(last_unit.bloodUnit_id[2:]) + 1
    except (TypeError, ValueError):
        next_number = 1
    return f"BU{next_number:03d}"


@donations_bp.route("/donations")
@login_required
def list_donations():
    donations = Donation.query.all()
    return render_template("donations/list.html", donations=donations)


@donations_bp.route("/donations/new", methods=["GET", "POST"])
@login_required
def create_donation():
    form = DonationForm()
    form.branch_id.choices = [(b.branch_id, b.branchName) for b in Branch.query.all()]

    if form.validate_on_submit():
        eligible, message = _is_donor_eligible(form.donor_id.data)
        if not eligible:
            flash(message, "danger")
            return render_template(
                "donations/form.html", form=form, title="New Donation"
            )

        donation = Donation(
            donation_id=form.donation_id.data,
            donor_id=form.donor_id.data,
            volume=form.volume.data,
            branch_id=form.branch_id.data,
            DonationDate=form.DonationDate.data,
        )

        try:
            db.session.add(donation)
            db.session.flush()

            blood_unit = BloodUnit(
                bloodUnit_id=_next_blood_unit_id(),
                donation_id=donation.donation_id,
                procurement_date=donation.DonationDate,
                expiry_date=donation.DonationDate + timedelta(days=42),
                blood_vol=donation.volume,
            )
            db.session.add(blood_unit)
            db.session.commit()
            flash("Donation and blood unit recorded successfully.", "success")
            return redirect(url_for("donations.list_donations"))
        except (IntegrityError, OperationalError) as e:
            db.session.rollback()
            flash(f"Could not save donation: {str(e.orig)}", "danger")

    return render_template("donations/form.html", form=form, title="New Donation")


@donations_bp.route("/donations/<donation_id>/delete", methods=["POST"])
@login_required
def delete_donation(donation_id):
    donation = Donation.query.get_or_404(donation_id)
    db.session.delete(donation)
    db.session.commit()
    flash("Donation deleted.", "info")
    return redirect(url_for("donations.list_donations"))
