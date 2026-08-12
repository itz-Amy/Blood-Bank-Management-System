from flask_wtf import FlaskForm
from wtforms import StringField, DecimalField, SelectField, DateField, SubmitField
from wtforms.validators import DataRequired, NumberRange, ValidationError
from app.models.donor import Donor

class DonationForm(FlaskForm):
    donation_id = StringField('Donation ID', validators=[DataRequired()])
    donor_id = StringField('Donor ID', validators=[DataRequired()])
    volume = DecimalField('Volume (ml)', validators=[DataRequired(), NumberRange(min=1)])
    branch_id = SelectField('Branch', validators=[DataRequired()])
    DonationDate = DateField('Donation Date', validators=[DataRequired()])
    submit = SubmitField('Save')

    def validate_donor_id(self, field):
        donor = Donor.query.get(field.data)
        if not donor:
            raise ValidationError('Donor does not exist in the system. Please register the donor first.')