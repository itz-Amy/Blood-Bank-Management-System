from flask import Blueprint

test_results_bp = Blueprint('test_results', __name__)

from app.test_results import routes