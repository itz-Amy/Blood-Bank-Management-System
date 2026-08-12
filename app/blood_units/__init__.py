from flask import Blueprint

blood_units_bp = Blueprint('blood_units', __name__)

from app.blood_units import routes