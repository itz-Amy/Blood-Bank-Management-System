from flask import render_template, redirect, url_for, flash
from flask_login import login_required
from sqlalchemy.exc import IntegrityError, OperationalError
from app.distribution import distribution_bp
from app.distribution.forms import IssuanceForm
from app.extensions import db
from app.models.issuance import Issuance
from app.auth.decorators import staff_required

@distribution_bp.route('/distribution')
@login_required
@staff_required
def list_distributions():
    issuances = Issuance.query.all()
    return render_template('distribution/list.html', issuances=issuances)


@distribution_bp.route('/distribution/new', methods=['GET', 'POST'])
@login_required
@staff_required
def create_distribution():
    form = IssuanceForm()

    if form.validate_on_submit():
        issuance = Issuance(
            Issuance_id=form.Issuance_id.data,
            Request_id=form.Request_id.data,
            StaffID=form.StaffID.data,
            IssuedUnits=form.IssuedUnits.data,
            IssueDate=form.IssueDate.data
        )
        try:
            db.session.add(issuance)
            db.session.commit()
            flash('Blood issued successfully.', 'success')
            return redirect(url_for('distribution.list_distributions'))
        except (IntegrityError, OperationalError) as e:
            db.session.rollback()
            flash(f'Could not issue: {str(e.orig)}', 'danger')

    return render_template('distribution/form.html', form=form, title='New Issuance')