from app.extensions import db


class Donation(db.Model):
    __tablename__ = "Donation"

    donation_id = db.Column(db.String(5), primary_key=True)
    donor_id = db.Column(db.String(5), db.ForeignKey("Donor.donor_id"), nullable=False)
    volume = db.Column(db.Numeric(5, 2), nullable=False)
    branch_id = db.Column(db.String(5), db.ForeignKey("Branch.branch_id"), nullable=False)
    DonationDate = db.Column(db.Date, nullable=False)

    donor = db.relationship("Donor", back_populates="donations")
    branch = db.relationship("Branch", back_populates="donations")
    blood_units = db.relationship("BloodUnit", back_populates="donation")
