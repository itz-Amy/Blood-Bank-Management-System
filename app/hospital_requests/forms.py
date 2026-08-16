from flask_wtf import FlaskForm
from wtforms import SelectField, IntegerField, SubmitField
from wtforms.validators import DataRequired, NumberRange


class RequestForm(FlaskForm):

    BloodType = SelectField(
        'Blood Type',
        validators=[DataRequired()]
    )

    Priority = SelectField(
        'Priority',
        choices=[
            ('High', 'High'),
            ('Medium', 'Medium'),
            ('Low', 'Low')
        ],
        validators=[DataRequired()]
    )

    Quantity = IntegerField(
        'Quantity',
        validators=[
            DataRequired(),
            NumberRange(min=1)
        ]
    )

    submit = SubmitField('Submit Request')


class UpdateStatusForm(FlaskForm):

    Status = SelectField(
        'Status',
        choices=[
            ('Pending', 'Pending'),
            ('Approved', 'Approved'),
            ('Rejected', 'Rejected')
        ],
        validators=[DataRequired()]
    )

    submit = SubmitField('Update Status')