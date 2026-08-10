from app.extensions import db


class Test(db.Model):
    __tablename__ = "Test"

    Test_id = db.Column(db.String(5), primary_key=True)
    TestName = db.Column(db.String(30), unique=True, nullable=False)

    test_results = db.relationship("TestResult", back_populates="test")


class Screening(db.Model):
    __tablename__ = "Screening"

    Screening_id = db.Column(db.String(5), primary_key=True)
    ScreeningDate = db.Column(db.Date, nullable=False)
    StaffID = db.Column(db.String(5), db.ForeignKey("Staff.staff_id"), nullable=False)
    BloodUnitID = db.Column(db.String(5), db.ForeignKey("BloodUnit.bloodUnit_id"), nullable=False)
    OverallStatus = db.Column(db.String(20), nullable=False)

    staff = db.relationship("Staff", back_populates="screenings")
    blood_unit = db.relationship("BloodUnit", back_populates="screenings")
    test_results = db.relationship("TestResult", back_populates="screening")

    __table_args__ = (
        db.CheckConstraint("OverallStatus IN ('Pending','Passed','Failed')", name="ck_screening_overall_status"),
    )


class TestResult(db.Model):
    __tablename__ = "TestResult"

    TestResultID = db.Column(db.String(5), primary_key=True)
    Screening_id = db.Column(db.String(5), db.ForeignKey("Screening.Screening_id"), nullable=False)
    Test_id = db.Column(db.String(5), db.ForeignKey("Test.Test_id"), nullable=False)
    Result = db.Column(db.String(10))

    screening = db.relationship("Screening", back_populates="test_results")
    test = db.relationship("Test", back_populates="test_results")

    __table_args__ = (
        db.CheckConstraint("Result IN ('Positive','Negative')", name="ck_testresult_result"),
    )
# , Test, TestResult