from flask_wtf import FlaskForm
from wtforms import DateField, SelectField, IntegerField, SubmitField
from wtforms.validators import DataRequired, NumberRange, ValidationError
from app.models.request import Request


class IssuanceForm(FlaskForm):

    Request_id = SelectField(
        "Request",
        validators=[DataRequired()]
    )

    BloodTypeID = SelectField(
        "Compatible Blood Type",
        validators=[DataRequired()],
        coerce=str
    )

    Quantity = IntegerField(
        "Quantity",
        validators=[
            DataRequired(),
            NumberRange(min=1)
        ]
    )

    IssueDate = DateField(
        "Issue Date",
        validators=[DataRequired()]
    )

    submit = SubmitField("Issue Blood")

    def validate_Request_id(self, field):
        req = Request.query.get(field.data)

        if not req:
            raise ValidationError("Request does not exist.")
        
        if req.Status != "Approved":
            raise ValidationError(
                "Only approved requests can be issued."
            )