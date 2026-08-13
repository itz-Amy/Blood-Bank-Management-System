from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField, SelectField, SubmitField
from wtforms.validators import DataRequired, NumberRange, ValidationError, Length
from app.models.request import Request


class IssuanceForm(FlaskForm):
    Issuance_id = StringField("Issuance ID", validators=[DataRequired(), Length(max=5)])
    Request_id = SelectField("Request", validators=[DataRequired()])
    BloodUnitID = SelectField("Blood Unit", validators=[DataRequired()])
    IssuedUnits = IntegerField(
        "Issued Units", validators=[DataRequired(), NumberRange(min=1)]
    )
    IssueDate = DateField("Issue Date", validators=[DataRequired()])
    submit = SubmitField("Issue Blood")

    def validate_Request_id(self, field):
        req = Request.query.get(field.data)
        if not req:
            raise ValidationError("Request does not exist.")
        if req.Status != "Approved":
            raise ValidationError("Only approved requests can be issued.")

    def validate_IssuedUnits(self, field):
        # Current workflow issues one specific blood unit per operation.
        if field.data != 1:
            raise ValidationError(
                "Issued Units must be 1 for a single selected blood unit."
            )
