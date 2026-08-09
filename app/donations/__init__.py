from flask import Blueprint

donations_bp = Blueprint('donation', __name__)

from app.donations import routes