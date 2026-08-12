from app.extensions import db


class Issuance(db.Model):
    __tablename__ = "Issuance"

    Issuance_id = db.Column(db.String(5), primary_key=True)
    IssuedUnits = db.Column(db.Numeric(5, 2), nullable=False)
    Request_id = db.Column(
        db.String(5), db.ForeignKey("Request.Request_id"), nullable=False
    )
    IssueDate = db.Column(db.Date, nullable=False)
    StaffID = db.Column(db.String(5), db.ForeignKey("Staff.staff_id"), nullable=False)

    request = db.relationship("Request", back_populates="issuances")
    staff = db.relationship("Staff", back_populates="issuances")
    issued_blood_units = db.relationship("IssuedBloodUnit", back_populates="issuance")
    blood_units = db.relationship(
        "BloodUnit", secondary="IssuedBloodUnit", back_populates="issuances"
    )


class IssuedBloodUnit(db.Model):
    __tablename__ = "IssuedBloodUnit"

    Issuance_id = db.Column(
        db.String(5), db.ForeignKey("Issuance.Issuance_id"), primary_key=True
    )
    bloodUnit_id = db.Column(
        db.String(5), db.ForeignKey("BloodUnit.bloodUnit_id"), primary_key=True
    )

    issuance = db.relationship("Issuance", back_populates="issued_blood_units")
    blood_unit = db.relationship("BloodUnit", back_populates="issued_blood_units")
