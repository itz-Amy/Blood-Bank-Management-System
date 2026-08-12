from flask_wtf import FlaskForm
from wtforms import StringField, SelectField, SubmitField
from wtforms.validators import DataRequired, ValidationError
from app.models.blood_unit import BloodUnit

class InventoryForm(FlaskForm):
    inventory_id = StringField('Inventory ID', validators=[DataRequired()])
    bloodUnit_id = StringField('Blood Unit ID', validators=[DataRequired()])
    branch_id = SelectField('Branch', validators=[DataRequired()])
    status = SelectField('Status', choices=[('Available', 'Available'), ('Issued', 'Issued'), ('Expired', 'Expired')], validators=[DataRequired()])
    submit = SubmitField('Save')

    def validate_bloodUnit_id(self, field):
        unit = BloodUnit.query.get(field.data)
        if not unit:
            raise ValidationError('Blood unit does not exist.')