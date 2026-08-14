from flask_wtf import FlaskForm
from wtforms import StringField, SelectField, DateField, SubmitField
from wtforms.validators import DataRequired, ValidationError
from app.models.blood_unit import BloodUnit


class ScreeningForm(FlaskForm):
    Screening_id = StringField("Screening ID", validators=[DataRequired()])
    BloodUnitID = StringField("Blood Unit ID", validators=[DataRequired()])
    StaffID = StringField("Staff ID", validators=[DataRequired()])
    ScreeningDate = DateField("Screening Date", validators=[DataRequired()])
    OverallStatus = SelectField(
        "Overall Status",
        choices=[("Pending", "Pending"), ("Passed", "Passed"), ("Failed", "Failed")],
        validators=[DataRequired()],
    )
    submit = SubmitField("Save")

    def validate_BloodUnitID(self, field):
        unit = BloodUnit.query.get(field.data)
        if not unit:
            raise ValidationError(
                "Blood unit does not exist. Check the ID and try again."
            )
        if unit.blood_type_id is None:
            raise ValidationError(
                "The blood type is not assigned yet. Record the donation before screening."
            )
