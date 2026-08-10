from app.extensions import db


class BloodUnit(db.Model):
    __tablename__ = "BloodUnit"

    bloodUnit_id = db.Column(db.String(5), primary_key=True)
    donation_id = db.Column(db.String(5), db.ForeignKey("Donation.donation_id"), nullable=False)
    blood_type_id = db.Column(db.String(5), db.ForeignKey("BloodType.blood_type_id"))
    procurement_date = db.Column(db.Date, nullable=False)
    expiry_date = db.Column(db.Date, nullable=False)
    blood_vol = db.Column(db.Numeric(5, 2), nullable=False)

    donation = db.relationship("Donation", back_populates="blood_units")
    blood_type = db.relationship("BloodType", back_populates="blood_units")
    screenings = db.relationship("Screening", back_populates="blood_unit")
    inventories = db.relationship("Inventory", back_populates="blood_unit")
    issued_blood_units = db.relationship("IssuedBloodUnit", back_populates="blood_unit")
    issuances = db.relationship("Issuance", secondary="IssuedBloodUnit", back_populates="blood_units")
