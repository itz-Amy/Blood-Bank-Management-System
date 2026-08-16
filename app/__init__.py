from flask import Flask, abort, render_template
from app.extensions import db, login_manager
from app.config import Config
from flask_login import current_user
from sqlalchemy import text
from sqlalchemy.exc import OperationalError
from app.auth.db_roles import ROLE_MAP, HOSPITAL_ROLE
from app.auth.db_roles import ROLE_MAP

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)
    login_manager.init_app(app)
    app.jinja_env.globals['ROLE_MAP'] = ROLE_MAP

    @app.errorhandler(403)
    def forbidden(error):
        return render_template('errors/403.html'), 403

    @app.errorhandler(OperationalError)
    def handle_database_permission_error(error):
        message = str(error.orig)

        if "command denied" in message:
            db.session.rollback()
            return render_template('errors/403.html'), 403

        db.session.rollback()
        return render_template('errors/500.html'), 500


    from app import models

    @app.before_request
    def set_db_role():
        if current_user.is_authenticated:
            if current_user.user_type == 'staff' and current_user.staff:
                role_name = ROLE_MAP.get(current_user.staff.role_id)

                if not role_name:
                    abort(403)

                db.session.execute(text(f"SET ROLE {role_name}"))

            elif current_user.user_type == 'hospital':
                db.session.execute(text(f"SET ROLE {HOSPITAL_ROLE}"))

            result = db.session.execute(
                text("SELECT CURRENT_USER(), CURRENT_ROLE()")
            ).fetchone()

            print("DB USER:", result[0])
            print("DB ROLE:", result[1])
        
    # import and register blueprints
    from app.main import main_bp
    from app.auth import auth_bp
    from app.donors import donors_bp
    from app.donations import donations_bp
    from app.screening import screening_bp
    from app.inventory import inventory_bp
    from app.hospital_requests import hospital_requests_bp
    from app.blood_units import blood_units_bp
    from app.test_results import test_results_bp
    from app.reports import reports_bp
    from app.distribution import distribution_bp

    

    app.register_blueprint(main_bp)
    app.register_blueprint(auth_bp)
    app.register_blueprint(donors_bp)
    app.register_blueprint(donations_bp)
    app.register_blueprint(screening_bp)
    app.register_blueprint(inventory_bp)
    app.register_blueprint(hospital_requests_bp)
    app.register_blueprint(blood_units_bp)
    app.register_blueprint(test_results_bp)
    app.register_blueprint(reports_bp)
    app.register_blueprint(distribution_bp)

    return app