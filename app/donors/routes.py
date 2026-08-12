from flask import render_template, redirect, url_for, flash, request
from flask_login import login_required
from app.donors import donors_bp
from app.donors.forms import DonorForm
from app.extensions import db
from app.models.donor import Donor, BloodType  # adjust import based on where BloodType actually lives

@donors_bp.route('/donors')
@login_required
def list_donors():
    search = request.args.get('search', '')
    blood_type_filter = request.args.get('blood_type', '')

    query = Donor.query
    if search:
        query = query.filter(
            (Donor.donorFName.ilike(f'%{search}%')) |
            (Donor.donorLName.ilike(f'%{search}%'))
        )
    if blood_type_filter:
        query = query.filter_by(blood_type_id=blood_type_filter)

    donors = query.all()
    blood_types = BloodType.query.all()
    return render_template('donors/list.html', donors=donors, blood_types=blood_types)


@donors_bp.route('/donors/new', methods=['GET', 'POST'])
@login_required
def create_donor():
    form = DonorForm()
    form.blood_type_id.choices = [(bt.blood_type_id, f'{bt.abo_group}{bt.rh_factor[0]}') for bt in BloodType.query.all()]

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
        db.session.add(donor)
        db.session.commit()
        flash('Donor registered successfully.', 'success')
        return redirect(url_for('donors.list_donors'))

    return render_template('donors/form.html', form=form, title='New Donor')


@donors_bp.route('/donors/<donor_id>/edit', methods=['GET', 'POST'])
@login_required
def edit_donor(donor_id):
    donor = Donor.query.get_or_404(donor_id)
    form = DonorForm(obj=donor)
    form.blood_type_id.choices = [(bt.blood_type_id, f'{bt.abo_group}{bt.rh_factor[0]}') for bt in BloodType.query.all()]

    if form.validate_on_submit():
        form.populate_obj(donor)
        db.session.commit()
        flash('Donor updated.', 'success')
        return redirect(url_for('donors.list_donors'))

    return render_template('donors/form.html', form=form, title='Edit Donor')


@donors_bp.route('/donors/<donor_id>/delete', methods=['POST'])
@login_required
def delete_donor(donor_id):
    donor = Donor.query.get_or_404(donor_id)
    db.session.delete(donor)
    db.session.commit()
    flash('Donor deleted.', 'info')
    return redirect(url_for('donors.list_donors'))