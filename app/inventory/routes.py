from flask import render_template, redirect, url_for, flash, request
from flask_login import login_required
from sqlalchemy.exc import IntegrityError, OperationalError

from app.inventory import inventory_bp
from app.inventory.forms import InventoryForm
from app.extensions import db
from app.models.inventory import Inventory, Branch
from app.utils.db_errors import get_db_error_message


@inventory_bp.route('/inventory')
@login_required
def list_inventory():

    branch_filter = request.args.get('branch', '')

    query = Inventory.query

    if branch_filter:
        query = query.filter_by(
            branch_id=branch_filter
        )

    items = query.all()

    branches = Branch.query.all()

    return render_template(
        'inventory/list.html',
        items=items,
        branches=branches
    )


@inventory_bp.route('/inventory/new', methods=['GET', 'POST'])
@login_required
def create_inventory():

    form = InventoryForm()

    form.branch_id.choices = [
        (b.branch_id, b.branchName)
        for b in Branch.query.all()
    ]

    if form.validate_on_submit():

        item = Inventory(
            inventory_id=form.inventory_id.data,
            bloodUnit_id=form.bloodUnit_id.data,
            branch_id=form.branch_id.data,
            status=form.status.data
        )

        try:

            db.session.add(item)

            db.session.commit()

            flash(
                'Inventory record added.',
                'success'
            )

            return redirect(
                url_for('inventory.list_inventory')
            )

        except (IntegrityError, OperationalError) as e:

            db.session.rollback()

            flash(
                get_db_error_message(e),
                'danger'
            )

    return render_template(
        'inventory/form.html',
        form=form,
        title='New Inventory Record'
    )


@inventory_bp.route(
    '/inventory/<inventory_id>/delete',
    methods=['POST']
)
@login_required
def delete_inventory(inventory_id):

    item = Inventory.query.get_or_404(inventory_id)

    try:

        db.session.delete(item)

        db.session.commit()

        flash(
            'Inventory record deleted.',
            'info'
        )

    except (IntegrityError, OperationalError) as e:

        db.session.rollback()

        flash(
            get_db_error_message(e),
            'danger'
        )

    return redirect(
        url_for('inventory.list_inventory')
    )