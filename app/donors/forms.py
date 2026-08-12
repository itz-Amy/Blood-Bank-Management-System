from flask_wtf import FlaskForm
from wtforms import StringField, DateField, SelectField, DecimalField, SubmitField
from wtforms.validators import DataRequired, Email, Optional, NumberRange, Length


class DonorForm(FlaskForm):
    donor_id = StringField('Donor ID', validators=[DataRequired(), Length(max=5)])
    donorFName = StringField('First Name', validators=[DataRequired(), Length(max=30)])
    donorLName = StringField('Last Name', validators=[DataRequired(), Length(max=30)])
    DOB = DateField('Date of Birth', validators=[DataRequired()])
    gender = SelectField(
        'Gender',
        choices=[('M', 'Male'), ('F', 'Female')],
        validators=[DataRequired()]
    )
    contact = StringField('Contact', validators=[Optional(), Length(max=15)])
    email = StringField('Email', validators=[Optional(), Email(), Length(max=50)])
    address = StringField('Address', validators=[Optional(), Length(max=50)])
    weight = DecimalField(
        'Weight (kg)',
        validators=[DataRequired(), NumberRange(min=1)]
    )
    blood_type_id = SelectField('Blood Type', validators=[DataRequired()])
    submit = SubmitField('Save')