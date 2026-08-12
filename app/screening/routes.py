from flask import render_template, redirect, url_for, flash
from flask_login import login_required
from sqlalchemy.exc import IntegrityError, OperationalError
from app.screening import screening_bp
from app.screening.forms import ScreeningForm
from app.extensions import db
from app.models.screening import Screening

@screening_bp.route('/screening')
@login_required
def list_screenings():
    screenings = Screening.query.all()
    return render_template('screening/list.html', screenings=screenings)


@screening_bp.route('/screening/new', methods=['GET', 'POST'])
@login_required
def create_screening():
    form = ScreeningForm()

    if form.validate_on_submit():
        screening = Screening(
            Screening_id=form.Screening_id.data,
            BloodUnitID=form.BloodUnitID.data,
            StaffID=form.StaffID.data,
            ScreeningDate=form.ScreeningDate.data,
            OverallStatus=form.OverallStatus.data
        )
        try:
            db.session.add(screening)
            db.session.commit()
            flash('Screening recorded.', 'success')
            return redirect(url_for('screening.list_screenings'))
        except (IntegrityError, OperationalError) as e:
            db.session.rollback()
            flash(f'Could not save screening: {str(e.orig)}', 'danger')

    return render_template('screening/form.html', form=form, title='New Screening')


@screening_bp.route('/screening/<screening_id>/delete', methods=['POST'])
@login_required
def delete_screening(screening_id):
    screening = Screening.query.get_or_404(screening_id)
    db.session.delete(screening)
    db.session.commit()
    flash('Screening record deleted.', 'info')
    return redirect(url_for('screening.list_screenings'))