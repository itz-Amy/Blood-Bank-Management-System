from functools import wraps
from flask import abort
from flask_login import current_user

def staff_required(f):
    """Restrict a route to staff users (any role). Assumes login_required already applied."""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if current_user.user_type != 'staff':
            abort(403)
        return f(*args, **kwargs)
    return decorated_function


def hospital_required(f):
    """Restrict a route to hospital users. Assumes login_required already applied."""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if current_user.user_type != 'hospital':
            abort(403)
        return f(*args, **kwargs)
    return decorated_function