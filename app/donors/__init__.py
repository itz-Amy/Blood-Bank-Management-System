from flask import Blueprint

donors_bp = Blueprint('donors', __name__)

from app.donors import routes