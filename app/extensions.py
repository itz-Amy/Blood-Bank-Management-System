from flask_login import LoginManager
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
login_manager = LoginManager()
login_manager.login_view = "auth.login"


@login_manager.user_loader
def load_user(user_id):
    from app.models.user import User

    return User.query.get(user_id)


@login_manager.unauthorized_handler
def unauthorized():
    """Handle unauthorized access when @login_required check fails."""
    from flask import jsonify

    return jsonify({"error": "You must be logged in to access this resource."}), 401
