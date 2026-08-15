from flask import flash, redirect, render_template, url_for
from flask_login import current_user, login_required, login_user, logout_user
from sqlalchemy.exc import IntegrityError, OperationalError

from app.auth import auth_bp
from app.auth.decorators import staff_required
from app.auth.forms import LoginForm
from app.extensions import db
from app.models.hospital import Hospital
from app.models.staff import Staff
from app.models.user import User
from app.auth.db_roles import ROLE_MAP


@auth_bp.route("/login", methods=["GET", "POST"])
def login():
    if current_user.is_authenticated:
        return redirect(url_for("main.home"))

    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.get(form.user_id.data)
        if user and user.check_password(form.password.data):
            login_user(user)
            flash("Logged in successfully.", "success")
            return redirect(url_for("main.home"))
        flash("Invalid ID or password.", "danger")

    return render_template("auth/login.html", form=form)


@auth_bp.route("/logout")
@login_required
def logout():
    logout_user()
    flash("Logged out.", "info")
    return redirect(url_for("auth.login"))


