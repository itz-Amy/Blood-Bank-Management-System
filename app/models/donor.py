from app.extensions import db


class BloodType(db.Model):
    __tablename__ = "BloodType"

    blood_type_id = db.Column(db.String(5), primary_key=True)
    abo_group = db.Column(db.String(3), nullable=False)
    rh_factor = db.Column(db.String(10), nullable=False)

    donors = db.relationship("Donor", back_populates="blood_type")
    blood_units = db.relationship("BloodUnit", back_populates="blood_type")
    requests = db.relationship("Request", back_populates="blood_type")

    __table_args__ = (
        db.UniqueConstraint("abo_group", "rh_factor", name="uix_bloodtype_abo_rh"),
        db.CheckConstraint("abo_group IN ('A','B','AB','O')", name="ck_bloodtype_abo_group"),
        db.CheckConstraint("rh_factor IN ('Positive','Negative')", name="ck_bloodtype_rh_factor"),
    )


class Donor(db.Model):
    __tablename__ = "Donor"

    donor_id = db.Column(db.String(5), primary_key=True)
    donorFName = db.Column(db.String(30))
    donorLName = db.Column(db.String(30))
    DOB = db.Column(db.Date, nullable=False)
    gender = db.Column(db.String(1), nullable=False)
    contact = db.Column(db.String(15))
    email = db.Column(db.String(50))
    address = db.Column(db.String(50))
    weight = db.Column(db.Numeric(5, 2))
    blood_type_id = db.Column(db.String(5), db.ForeignKey("BloodType.blood_type_id"))

    blood_type = db.relationship("BloodType", back_populates="donors")
    donations = db.relationship("Donation", back_populates="donor")
    deferrals = db.relationship("Deferral", back_populates="donor")

    __table_args__ = (
        db.CheckConstraint("gender IN ('M','F')", name="ck_donor_gender"),
    )


class Deferral(db.Model):
    __tablename__ = "Deferral"

    deferralID = db.Column(db.String(5), primary_key=True)
    donorID = db.Column(db.String(5), db.ForeignKey("Donor.donor_id"), nullable=False)
    deferral_date = db.Column(db.Date, nullable=False)
    reason = db.Column(db.String(100))

    donor = db.relationship("Donor", back_populates="deferrals")
    temporary_deferral = db.relationship("TemporaryDeferral", back_populates="deferral", uselist=False)


class TemporaryDeferral(db.Model):
    __tablename__ = "TemporaryDeferral"

    tempDeferral_id = db.Column(db.String(5), primary_key=True)
    deferralID = db.Column(db.String(5), db.ForeignKey("Deferral.deferralID"), nullable=False)
    endDate = db.Column(db.Date, nullable=False)

    deferral = db.relationship("Deferral", back_populates="temporary_deferral", uselist=False)

