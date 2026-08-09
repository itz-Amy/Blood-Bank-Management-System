from flask import Blueprint

distribution_bp = Blueprint('distribution', __name__)

from app.distribution import routes