from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField, SubmitField
from wtforms.validators import DataRequired, NumberRange, ValidationError
from app.models.request import Request

class IssuanceForm(FlaskForm):
    Issuance_id = StringField('Issuance ID', validators=[DataRequired()])
    Request_id = StringField('Request ID', validators=[DataRequired()])
    StaffID = StringField('Staff ID', validators=[DataRequired()])
    IssuedUnits = IntegerField('Issued Units', validators=[DataRequired(), NumberRange(min=1)])
    IssueDate = DateField('Issue Date', validators=[DataRequired()])
    submit = SubmitField('Issue Blood')

    def validate_Request_id(self, field):
        req = Request.query.get(field.data)
        if not req:
            raise ValidationError('Request does not exist.')
        if req.Status != 'Approved':
            raise ValidationError('Only approved requests can be issued.')