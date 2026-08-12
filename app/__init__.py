from flask import Flask
from app.extensions import db, login_manager
from app.config import Config

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # attach extensions to this app instance
    db.init_app(app)
    login_manager.init_app(app)

    from app import models

    # import and register blueprints
    from app.main import main_bp
    from app.auth import auth_bp
    from app.donors import donors_bp
    from app.donations import donations_bp
    from app.screening import screening_bp
    from app.inventory import inventory_bp
    from app.hospital_requests import hospital_requests_bp
    from app.distribution import distribution_bp
    from app.blood_units import blood_units_bp
    

    app.register_blueprint(main_bp)
    app.register_blueprint(auth_bp)
    app.register_blueprint(donors_bp)
    app.register_blueprint(donations_bp)
    app.register_blueprint(screening_bp)
    app.register_blueprint(inventory_bp)
    app.register_blueprint(hospital_requests_bp)
    app.register_blueprint(distribution_bp)
    app.register_blueprint(blood_units_bp)

    return app