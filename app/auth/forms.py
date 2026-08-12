from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired
from wtforms import SelectField

class LoginForm(FlaskForm):
    user_id = StringField('User ID', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Log In')


class CreateUserForm(FlaskForm):
    user_id = StringField('User ID (must match existing Staff or Hospital ID)', validators=[DataRequired()])
    user_type = SelectField('User Type', choices=[('staff', 'Staff'), ('hospital', 'Hospital')], validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Create Account')