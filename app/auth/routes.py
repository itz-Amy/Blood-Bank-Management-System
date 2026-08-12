from flask import render_template, redirect, url_for, flash
from flask_login import login_user, logout_user, login_required, current_user
from app.auth import auth_bp
from app.auth.forms import LoginForm
from app.models.user import User
from app.auth.forms import CreateUserForm
from app.auth.decorators import staff_required


@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))  # adjust to wherever makes sense as "home"

    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.get(form.user_id.data)
        if user and user.check_password(form.password.data):
            login_user(user)
            flash('Logged in successfully.', 'success')
            return redirect(url_for('main.home'))
        flash('Invalid ID or password.', 'danger')

    return render_template('auth/login.html', form=form)


@auth_bp.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Logged out.', 'info')
    return redirect(url_for('auth.login'))

@auth_bp.route('/create-account', methods=['GET', 'POST'])
@login_required
@staff_required
def create_account():
    form = CreateUserForm()

    if form.validate_on_submit():
        existing = User.query.get(form.user_id.data)
        if existing:
            flash('A user with this ID already exists.', 'danger')
        else:
            new_user = User(user_id=form.user_id.data, user_type=form.user_type.data)
            if form.user_type.data == 'staff':
                new_user.staff_id = form.user_id.data
            else:
                new_user.hospital_id = form.user_id.data
            new_user.set_password(form.password.data)

            try:
                db.session.add(new_user)
                db.session.commit()
                flash('Account created.', 'success')
                return redirect(url_for('auth.create_account'))
            except Exception as e:
                db.session.rollback()
                flash(f'Could not create account: {str(e)}', 'danger')

    return render_template('auth/create_account.html', form=form)