from flask import Flask, jsonify
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

    # Register error handlers
    @app.errorhandler(400)
    def bad_request(error):
        """Handle 400 Bad Request errors."""
        return jsonify({"error": "Bad request. Please check your input."}), 400

    @app.errorhandler(403)
    def forbidden(error):
        """Handle 403 Forbidden errors (unauthorized access)."""
        return jsonify(
            {
                "error": "Access denied. You do not have permission to access this resource."
            }
        ), 403

    @app.errorhandler(404)
    def not_found(error):
        """Handle 404 Not Found errors."""
        return jsonify({"error": "The requested resource was not found."}), 404

    @app.errorhandler(405)
    def method_not_allowed(error):
        """Handle 405 Method Not Allowed errors."""
        return jsonify(
            {"error": "The request method is not allowed for this resource."}
        ), 405

    @app.errorhandler(500)
    def internal_error(error):
        """Handle 500 Internal Server errors."""
        return jsonify(
            {"error": "An internal server error occurred. Please try again later."}
        ), 500

    return app
