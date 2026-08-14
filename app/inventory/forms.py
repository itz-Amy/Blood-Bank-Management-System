from flask_wtf import FlaskForm
from wtforms import StringField, SelectField, SubmitField
from wtforms.validators import DataRequired, ValidationError
from app.models.blood_unit import BloodUnit


class InventoryForm(FlaskForm):
    inventory_id = StringField("Inventory ID", validators=[DataRequired()])
    bloodUnit_id = StringField("Blood Unit ID", validators=[DataRequired()])
    branch_id = SelectField("Branch", validators=[DataRequired()])
    status = SelectField(
        "Status",
        choices=[
            ("Available", "Available"),
            ("Reserved", "Reserved"),
            ("Issued", "Issued"),
            ("Expired", "Expired"),
        ],
        validators=[DataRequired()],
    )
    submit = SubmitField("Save")

    def validate_bloodUnit_id(self, field):
        unit = BloodUnit.query.get(field.data)
        if not unit:
            raise ValidationError("Blood unit does not exist.")
        if unit.blood_type_id is None:
            raise ValidationError(
                "Blood unit must have a blood type assigned before entry into inventory."
            )

        latest_screening = (
            max(unit.screenings, key=lambda screening: screening.ScreeningDate)
            if unit.screenings
            else None
        )
        if latest_screening is None or latest_screening.OverallStatus != "Passed":
            raise ValidationError(
                "Only blood units with a passed screening result can be added to inventory."
            )
