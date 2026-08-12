from app.extensions import db


class Hospital(db.Model):
    __tablename__ = "Hospital"

    Hospital_id = db.Column(db.String(5), primary_key=True)
    HospitalName = db.Column(db.String(50), nullable=False)
    Contact = db.Column(db.String(15))
    address = db.Column(db.String(100), nullable=False)

    requests = db.relationship("Request", back_populates="hospital")
    users = db.relationship("User", back_populates="hospital")


class Compatibility(db.Model):
    __tablename__ = "Compatibility"

    donor_type_id = db.Column(db.String(5), db.ForeignKey("BloodType.blood_type_id"), primary_key=True, nullable=False)
    recipient_type_id = db.Column(db.String(5), db.ForeignKey("BloodType.blood_type_id"), primary_key=True, nullable=False)

    donor_type = db.relationship("BloodType", foreign_keys=[donor_type_id])
    recipient_type = db.relationship("BloodType", foreign_keys=[recipient_type_id])
