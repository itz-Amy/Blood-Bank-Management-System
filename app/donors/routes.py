from flask import render_template, redirect, url_for, flash, request
from flask_login import login_required
from sqlalchemy import text
from sqlalchemy.exc import IntegrityError, OperationalError

from app.donors import donors_bp
from app.donors.forms import DonorForm
from app.models.donor import Donor, BloodType
from app.extensions import db
from app.utils.db_errors import get_db_error_message


@donors_bp.route('/donors')
@login_required
def list_donors():

    search = request.args.get('search', '')
    blood_type_filter = request.args.get('blood_type', '')
    eligibility_filter = request.args.get('eligibility', '')

    query = Donor.query

    if search:
        query = query.filter(
            (Donor.donor_id.ilike(f'%{search}%')) |
            (Donor.donorFName.ilike(f'%{search}%')) |
            (Donor.donorLName.ilike(f'%{search}%'))
        )

    if blood_type_filter:
        query = query.filter(
            Donor.blood_type_id == blood_type_filter
        )

    if eligibility_filter == 'eligible':

        eligible_ids = db.session.execute(
            text("""
                SELECT donor_id
                FROM vw_eligibledonors
            """)
        ).scalars().all()

        query = query.filter(
            Donor.donor_id.in_(eligible_ids)
        )

    donors = query.all()

    blood_types = BloodType.query.all()

    return render_template(
        'donors/list.html',
        donors=donors,
        blood_types=blood_types,
        eligibility_filter=eligibility_filter
    )


@donors_bp.route('/donors/new', methods=['GET', 'POST'])
@login_required
def create_donor():

    form = DonorForm()

    form.blood_type_id.choices = [
        (
            bt.blood_type_id,
            f'{bt.abo_group}{bt.rh_factor[0]}'
        )
        for bt in BloodType.query.all()
    ]

    if form.validate_on_submit():

        donor = Donor(
            donor_id=form.donor_id.data,
            donorFName=form.donorFName.data,
            donorLName=form.donorLName.data,
            DOB=form.DOB.data,
            gender=form.gender.data,
            contact=form.contact.data,
            email=form.email.data,
            address=form.address.data,
            weight=form.weight.data,
            blood_type_id=form.blood_type_id.data
        )

        try:
            db.session.add(donor)
            db.session.commit()

            flash(
                'Donor registered successfully.',
                'success'
            )

            return redirect(
                url_for('donors.list_donors')
            )

        except (IntegrityError, OperationalError) as e:

            db.session.rollback()

            flash(
                get_db_error_message(e),
                'danger'
            )

    return render_template(
        'donors/form.html',
        form=form,
        title='New Donor'
    )


@donors_bp.route('/donors/<donor_id>/edit', methods=['GET', 'POST'])
@login_required
def edit_donor(donor_id):

    donor = Donor.query.get_or_404(donor_id)

    form = DonorForm(obj=donor)

    form.blood_type_id.choices = [
        (
            bt.blood_type_id,
            f'{bt.abo_group}{bt.rh_factor[0]}'
        )
        for bt in BloodType.query.all()
    ]

    if form.validate_on_submit():

        try:
            form.populate_obj(donor)

            db.session.commit()

            flash(
                'Donor updated.',
                'success'
            )

            return redirect(
                url_for('donors.list_donors')
            )

        except (IntegrityError, OperationalError) as e:

            db.session.rollback()

            flash(
                get_db_error_message(e),
                'danger'
            )

    return render_template(
        'donors/form.html',
        form=form,
        title='Edit Donor'
    )


@donors_bp.route('/donors/<donor_id>/delete', methods=['POST'])
@login_required
def delete_donor(donor_id):

    donor = Donor.query.get_or_404(donor_id)

    try:
        db.session.delete(donor)
        db.session.commit()

        flash(
            'Donor deleted.',
            'info'
        )

    except (IntegrityError, OperationalError) as e:

        db.session.rollback()

        flash(
            get_db_error_message(e),
            'danger'
        )

    return redirect(
        url_for('donors.list_donors')
    )