from app.extensions import db


class StaffRole(db.Model):
    __tablename__ = "StaffRole"

    role_id = db.Column(db.String(5), primary_key=True)
    roleName = db.Column(db.String(30), unique=True, nullable=False)

    staff = db.relationship("Staff", back_populates="role")


class Staff(db.Model):
    __tablename__ = "Staff"

    staff_id = db.Column(db.String(5), primary_key=True)
    staffFName = db.Column(db.String(30))
    staffLName = db.Column(db.String(30))
    staffType = db.Column(db.String(20), nullable=False)
    branchID = db.Column(
        db.String(5), db.ForeignKey("Branch.branch_id"), nullable=False
    )
    role_id = db.Column(
        db.String(5), db.ForeignKey("StaffRole.role_id"), nullable=False
    )

    branch = db.relationship("Branch", back_populates="staff")
    role = db.relationship("StaffRole", back_populates="staff")
    screenings = db.relationship("Screening", back_populates="staff")
    issuances = db.relationship("Issuance", back_populates="staff")
    users = db.relationship("User", back_populates="staff")
