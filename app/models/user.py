from app.extensions import db
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin

class User(UserMixin, db.Model):
    user_id = db.Column(db.String(5), primary_key=True)
    password_hash = db.Column(db.String(255), nullable=False)
    user_type = db.Column(db.String(10), nullable=False)  # 'staff' or 'hospital'
    staff_id = db.Column(db.String(5), db.ForeignKey('staff.staff_id'), nullable=True)
    hospital_id = db.Column(db.String(5), db.ForeignKey('hospital.Hospital_id'), nullable=True)

    staff = db.relationship('Staff', backref='user', uselist=False)
    hospital = db.relationship('Hospital', backref='user', uselist=False)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def get_id(self):
        return self.user_id