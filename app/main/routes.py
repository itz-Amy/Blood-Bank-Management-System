from flask import render_template
from flask_login import login_required, current_user
from sqlalchemy import text

from app.main import main_bp
from app.extensions import db
from app.auth.db_roles import ROLE_MAP


@main_bp.route('/')
@login_required
def home():

    role_name = None
    stats = {}

    # =========================
    # STAFF USERS
    # =========================

    if current_user.user_type == 'staff' and current_user.staff:

        role_name = ROLE_MAP.get(current_user.staff.role_id)

        # -------------------------
        # PHLEBOTOMIST
        # -------------------------
        if role_name == 'phlebotomist':

            stats = {
                'donors': db.session.execute(
                    text("SELECT COUNT(*) FROM Donor")
                ).scalar(),

                'donations': db.session.execute(
                    text("SELECT COUNT(*) FROM Donation")
                ).scalar(),

                'eligible_donors': db.session.execute(
                    text("SELECT COUNT(*) FROM vw_eligibledonors")
                ).scalar(),

                'deferrals': db.session.execute(
                    text("SELECT COUNT(*) FROM Deferral")
                ).scalar()
            }

        # -------------------------
        # LAB TECHNICIAN
        # -------------------------
        elif role_name == 'lab_tech':

            stats = {
                'pending_screenings': db.session.execute(
                    text("""
                        SELECT COUNT(*)
                        FROM vw_screeningstatus
                        WHERE OverallStatus = 'Pending'
                    """)
                ).scalar(),

                'test_results': db.session.execute(
                    text("SELECT COUNT(*) FROM TestResult")
                ).scalar(),

                'blood_units': db.session.execute(
                    text("SELECT COUNT(*) FROM BloodUnit")
                ).scalar()
            }

        # -------------------------
        # BLOOD BANK MANAGER
        # -------------------------
        elif role_name == 'blood_bank_manager':

            stats = {
                'donors': db.session.execute(
                    text("SELECT COUNT(*) FROM Donor")
                ).scalar(),

                'available_units': db.session.execute(
                    text("""
                        SELECT COALESCE(SUM(total_available), 0)
                        FROM vw_availableinventory
                    """)
                ).scalar(),

                'pending_requests': db.session.execute(
                    text("""
                        SELECT COUNT(*)
                        FROM pendingrequests
                    """)
                ).scalar(),

                'hospitals': db.session.execute(
                    text("SELECT COUNT(*) FROM Hospital")
                ).scalar()
            }

    # =========================
    # HOSPITAL USERS
    # =========================

    elif current_user.user_type == 'hospital':

        role_name = 'hospital_rep'

        stats = {
            'pending_requests': db.session.execute(
                text("""
                    SELECT COUNT(*)
                    FROM Request
                    WHERE Hospital_id = :hospital_id
                    AND Status = 'Pending'
                """),
                {'hospital_id': current_user.hospital_id}
            ).scalar()
        }

    return render_template(
        'main/home.html',
        user=current_user,
        role_name=role_name,
        stats=stats
    )