from flask import render_template, redirect, url_for, flash, request
from flask_login import login_required
from sqlalchemy.exc import IntegrityError, OperationalError
from app.donations import donations_bp
from app.donations.forms import DonationForm
from app.extensions import db
from app.models.donation import Donation
from app.models.inventory import Branch

@donations_bp.route('/donations')
@login_required
def list_donations():
    donations = Donation.query.all()
    return render_template('donations/list.html', donations=donations)


@donations_bp.route('/donations/new', methods=['GET', 'POST'])
@login_required
def create_donation():
    form = DonationForm()
    form.branch_id.choices = [(b.branch_id, b.branchName) for b in Branch.query.all()]

    if form.validate_on_submit():
        donation = Donation(
            donation_id=form.donation_id.data,
            donor_id=form.donor_id.data,
            volume=form.volume.data,
            branch_id=form.branch_id.data,
            DonationDate=form.DonationDate.data
        )
        try:
            db.session.add(donation)
            db.session.commit()
            flash('Donation recorded successfully.', 'success')
            return redirect(url_for('donations.list_donations'))
        except (IntegrityError, OperationalError) as e:
            db.session.rollback()
            flash(f'Could not save donation: {str(e.orig)}', 'danger')

    return render_template('donations/form.html', form=form, title='New Donation')


@donations_bp.route('/donations/<donation_id>/delete', methods=['POST'])
@login_required
def delete_donation(donation_id):
    donation = Donation.query.get_or_404(donation_id)
    db.session.delete(donation)
    db.session.commit()
    flash('Donation deleted.', 'info')
    return redirect(url_for('donations.list_donations'))