from app.extensions import db


class Branch(db.Model):
    __tablename__ = "Branch"

    branch_id = db.Column(db.String(5), primary_key=True)
    branchName = db.Column(db.String(30))
    branchAddress = db.Column(db.String(50))
    branchContact = db.Column(db.String(15))

    staff = db.relationship("Staff", back_populates="branch")
    donations = db.relationship("Donation", back_populates="branch")
    inventories = db.relationship("Inventory", back_populates="branch")


class Inventory(db.Model):
    __tablename__ = "Inventory"

    inventory_id = db.Column(db.String(5), primary_key=True)
    bloodUnit_id = db.Column(db.String(5), db.ForeignKey("BloodUnit.bloodUnit_id"), nullable=False)
    branch_id = db.Column(db.String(5), db.ForeignKey("Branch.branch_id"), nullable=False)
    status = db.Column(db.String(20), nullable=False)

    blood_unit = db.relationship("BloodUnit", back_populates="inventories")
    branch = db.relationship("Branch", back_populates="inventories")

    __table_args__ = (
        db.CheckConstraint("status IN ('Available','Reserved','Issued','Expired')", name="ck_inventory_status"),
    )
