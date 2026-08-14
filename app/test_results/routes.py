from flask import render_template, redirect, url_for, flash, abort
from flask_login import login_required, current_user
from sqlalchemy import text
from sqlalchemy.exc import OperationalError, IntegrityError

from app.test_results import test_results_bp
from app.test_results.forms import TestResultForm
from app.extensions import db


@test_results_bp.route('/test-results')
@login_required
def list_test_results():

    if current_user.user_type != 'staff':
        abort(403)

    if not current_user.staff or current_user.staff.role_id != 'R002':
        abort(403)

    result = db.session.execute(
        text("""
            SELECT
                tr.TestResultID,
                tr.Screening_id,
                tr.Test_id,
                tr.Result
            FROM TestResult tr
            ORDER BY tr.TestResultID
        """)
    )

    test_results = result.fetchall()

    return render_template(
        'test_results/list.html',
        test_results=test_results
    )


@test_results_bp.route('/test-results/new', methods=['GET', 'POST'])
@login_required
def create_test_result():

    if current_user.user_type != 'staff':
        abort(403)

    if not current_user.staff or current_user.staff.role_id != 'R002':
        abort(403)

    form = TestResultForm()

    if form.validate_on_submit():

        try:
            db.session.execute(
                text("""
                    CALL sp_RecordTestResult(
                        :screening_id,
                        :test_id,
                        :result
                    )
                """),
                {
                    'screening_id': form.Screening_id.data,
                    'test_id': form.Test_id.data,
                    'result': form.Result.data
                }
            )

            db.session.commit()

            flash('Test result recorded successfully.', 'success')

            return redirect(
                url_for('test_results.list_test_results')
            )

        except (IntegrityError, OperationalError) as e:

            db.session.rollback()

            flash(
                f'Could not save test result: {str(e.orig)}',
                'danger'
            )

    return render_template(
        'test_results/form.html',
        form=form,
        title='Record Test Result'
    )
