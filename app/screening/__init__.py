from flask import Blueprint

screening_bp = Blueprint('screening', __name__)

from app.screening import routes