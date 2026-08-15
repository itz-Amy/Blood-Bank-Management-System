from flask_wtf import FlaskForm
from wtforms import SelectField, StringField, SubmitField
from wtforms.validators import DataRequired, Length


class TestResultForm(FlaskForm):

    Screening_id = StringField(
        'Screening ID',
        validators=[
            DataRequired(),
            Length(max=5)
        ]
    )

    Test_id = SelectField(
        'Test',
        choices=[],
        validators=[
            DataRequired()
        ]
    )

    Result = SelectField(
        'Result',
        choices=[
            ('Positive', 'Positive'),
            ('Negative', 'Negative')
        ],
        validators=[
            DataRequired()
        ]
    )

    submit = SubmitField('Record Test Result')