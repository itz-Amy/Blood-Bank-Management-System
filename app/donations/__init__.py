from flask import Blueprint

donations_bp = Blueprint('donations', __name__)

from app.donations import routes