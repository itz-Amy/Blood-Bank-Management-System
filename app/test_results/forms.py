from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired, Length


class TestResultForm(FlaskForm):
    Screening_id = StringField(
        'Screening ID',
        validators=[DataRequired(), Length(max=5)]
    )

    Test_id = StringField(
        'Test ID',
        validators=[DataRequired(), Length(max=5)]
    )

    Result = StringField(
        'Result',
        validators=[DataRequired(), Length(max=10)]
    )

    submit = SubmitField('Record Test Result')
    