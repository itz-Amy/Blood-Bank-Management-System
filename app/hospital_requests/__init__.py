from flask import Blueprint

hospital_requests_bp = Blueprint('hospital_requests', __name__)

from app.hospital_requests import routes