from flask import render_template, redirect, url_for, flash
from flask_login import login_required, current_user
from sqlalchemy.exc import IntegrityError, OperationalError
from app.hospital_requests import hospital_requests_bp
from app.hospital_requests.forms import RequestForm, UpdateStatusForm
from app.extensions import db
from app.models.request import Request
from app.models.donor import BloodType
from app.auth.decorators import staff_required, hospital_required

@hospital_requests_bp.route('/requests')
@login_required
def list_requests():
    if current_user.user_type == 'hospital':
        requests = Request.query.filter_by(Hospital_id=current_user.hospital_id).all()
    else:
        requests = Request.query.all()
    return render_template('hospital_requests/list.html', requests=requests)


@hospital_requests_bp.route('/requests/new', methods=['GET', 'POST'])
@login_required
@hospital_required
def create_request():
    form = RequestForm()
    form.BloodType.choices = [(bt.blood_type_id, f'{bt.abo_group}{"+" if bt.rh_factor=="Positive" else "-"}') for bt in BloodType.query.all()]

    if form.validate_on_submit():
        req = Request(
            Request_id=form.Request_id.data,
            BloodType=form.BloodType.data,
            Priority=form.Priority.data,
            Status='Pending',
            RequestDate=form.RequestDate.data,
            Quantity=form.Quantity.data,
            Hospital_id=current_user.hospital_id
        )
        try:
            db.session.add(req)
            db.session.commit()
            flash('Request submitted.', 'success')
            return redirect(url_for('hospital_requests.list_requests'))
        except (IntegrityError, OperationalError) as e:
            db.session.rollback()
            flash(f'Could not submit request: {str(e.orig)}', 'danger')

    return render_template('hospital_requests/form.html', form=form, title='New Request')


@hospital_requests_bp.route('/requests/<request_id>/status', methods=['GET', 'POST'])
@login_required
@staff_required
def update_status(request_id):
    req = Request.query.get_or_404(request_id)
    form = UpdateStatusForm(obj=req)

    if form.validate_on_submit():
        req.Status = form.Status.data
        db.session.commit()
        flash('Status updated.', 'success')
        return redirect(url_for('hospital_requests.list_requests'))

    return render_template('hospital_requests/status_form.html', form=form, req=req)