from app.extensions import db


class Request(db.Model):
    __tablename__ = "Request"

    Request_id = db.Column(db.String(5), primary_key=True)
    BloodType = db.Column(
        db.String(5), db.ForeignKey("BloodType.blood_type_id"), nullable=False
    )
    Priority = db.Column(db.String(10), nullable=False)
    Status = db.Column(db.String(20), nullable=False)
    RequestDate = db.Column(db.Date, nullable=False)
    Quantity = db.Column(db.Integer, nullable=False)
    Hospital_id = db.Column(
        db.String(5), db.ForeignKey("Hospital.Hospital_id"), nullable=False
    )

    blood_type = db.relationship("BloodType", back_populates="requests")
    hospital = db.relationship("Hospital", back_populates="requests")
    issuances = db.relationship("Issuance", back_populates="request")

    __table_args__ = (
        db.CheckConstraint(
            "Priority IN ('High','Medium','Low')", name="ck_request_priority"
        ),
        db.CheckConstraint(
            "Status IN ('Pending','Approved','Rejected')", name="ck_request_status"
        ),
    )
