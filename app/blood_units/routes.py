from flask import render_template
from flask_login import login_required
from app.blood_units import blood_units_bp
from app.models.blood_unit import BloodUnit

@blood_units_bp.route('/blood-units')
@login_required
def list_blood_units():
    units = BloodUnit.query.all()
    return render_template('blood_units/list.html', units=units)
