from flask import flash, redirect, render_template, url_for
from flask_login import current_user, login_required, login_user, logout_user
from sqlalchemy.exc import IntegrityError, OperationalError

from app.auth import auth_bp
from app.auth.decorators import staff_required
from app.auth.forms import CreateUserForm, LoginForm
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


@auth_bp.route("/create-account", methods=["GET", "POST"])
@login_required
@staff_required
def create_account():
    form = CreateUserForm()

    if form.validate_on_submit():
        user_id = form.user_id.data.strip()
        user_type = form.user_type.data

        if User.query.get(user_id):
            flash("A user with this ID already exists.", "danger")
            return render_template("auth/create_account.html", form=form)

        if user_type == "staff":
            staff = Staff.query.get(user_id)
            if not staff:
                flash("No staff record exists with that staff ID.", "danger")
                return render_template("auth/create_account.html", form=form)

            if User.query.filter_by(staff_id=user_id).first():
                flash("This staff ID already has an application account.", "danger")
                return render_template("auth/create_account.html", form=form)

            if User.query.filter_by(hospital_id=user_id).first():
                flash("This ID is already mapped to a hospital account.", "danger")
                return render_template("auth/create_account.html", form=form)

            new_user = User(
                user_id=user_id,
                user_type="staff",
                staff_id=user_id,
                hospital_id=None,
            )

        elif user_type == "hospital":
            hospital = Hospital.query.get(user_id)
            if not hospital:
                flash("No hospital record exists with that hospital ID.", "danger")
                return render_template("auth/create_account.html", form=form)

            if User.query.filter_by(hospital_id=user_id).first():
                flash("This hospital ID already has an application account.", "danger")
                return render_template("auth/create_account.html", form=form)

            if User.query.filter_by(staff_id=user_id).first():
                flash("This ID is already mapped to a staff account.", "danger")
                return render_template("auth/create_account.html", form=form)

            new_user = User(
                user_id=user_id,
                user_type="hospital",
                staff_id=None,
                hospital_id=user_id,
            )
        else:
            flash("Invalid user type selected.", "danger")
            return render_template("auth/create_account.html", form=form)

        new_user.set_password(form.password.data)

        try:
            db.session.add(new_user)
            db.session.commit()
            flash("Account created.", "success")
            return redirect(url_for("auth.create_account"))
        except (IntegrityError, OperationalError) as exc:
            db.session.rollback()
            flash(f"Could not create account: {exc.orig!s}", "danger")

    return render_template("auth/create_account.html", form=form)
