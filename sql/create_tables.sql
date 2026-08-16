USE bloodbank;

-- creating the bloodtype table
CREATE TABLE  bloodtype (
    blood_type_id varchar(5) NOT NULL,
    abo_group char(3) NOT NULL CHECK (abo_group IN ('A', 'B', 'AB', 'O')),
    rh_factor varchar(10) NOT NULL CHECK (rh_factor IN ('Positive', 'Negative')),
    PRIMARY KEY (blood_type_id),
    UNIQUE KEY unique_blood_type (abo_group, rh_factor)
)
-- creating the branch table
CREATE TABLE branch (
    branch_id varchar(5) NOT NULL,
    branchName varchar(30) DEFAULT NULL,
    branchAddress varchar(50) DEFAULT NULL,
    branchContact varchar(15) DEFAULT NULL,
    PRIMARY KEY (branch_id)
)

-- create the hospital table

CREATE TABLE  hospital (
    Hospital_id varchar(5) NOT NULL,
    HospitalName varchar(50) NOT NULL,
    Contact varchar(15) DEFAULT NULL,
    address varchar(100) NOT NULL,
    PRIMARY KEY (Hospital_id)
)

-- creating the Staffrole table
CREATE TABLE  staffrole (
    role_id varchar(5) NOT NULL,
    roleName varchar(30) NOT NULL,
    PRIMARY KEY (role_id),
    UNIQUE KEY unique_role_name (roleName)
) 

-- Creating the Donor table

CREATE TABLE  donor (
    donor_id varchar(5) NOT NULL,
    donorFName varchar(30) DEFAULT NULL,
    donorLName varchar(30) DEFAULT NULL,
    DOB date NOT NULL,
    gender char(1) NOT NULL CHECK (gender IN ('M', 'F')),
    contact varchar(15) DEFAULT NULL,
    email varchar(50) DEFAULT NULL,
    address varchar(50) DEFAULT NULL,
    weight decimal(5,2) DEFAULT NULL,
    blood_type_id varchar(5) DEFAULT NULL,
    PRIMARY KEY (donor_id),
    KEY blood_type_id (blood_type_id),
    CONSTRAINT fk_donor_bloodtype
        FOREIGN KEY (blood_type_id)
        REFERENCES bloodtype (blood_type_id)
) ;

-- creating the donation table
CREATE TABLE donation (
    donation_id varchar(5) NOT NULL,
    donor_id varchar(5) NOT NULL,
    volume decimal(5,2) NOT NULL,
    branch_id varchar(5) NOT NULL,
    DonationDate date NOT NULL,
    PRIMARY KEY (donation_id),
    KEY donor_id (donor_id),
    KEY branch_id (branch_id),
    CONSTRAINT fk_donation_donor
        FOREIGN KEY (donor_id)
        REFERENCES donor (donor_id),
    CONSTRAINT fk_donation_branch
        FOREIGN KEY (branch_id)
        REFERENCES branch (branch_id)
) ;

-- creating the bloodunit table
CREATE TABLE  bloodunit (
    bloodUnit_id varchar(5) NOT NULL,
    donation_id varchar(5) NOT NULL,
    blood_type_id varchar(5) DEFAULT NULL,
    procurement_date date NOT NULL,
    expiry_date date NOT NULL,
    blood_vol decimal(5,2) NOT NULL,
    PRIMARY KEY (bloodUnit_id),
    KEY donation_id (donation_id),
    KEY blood_type_id (blood_type_id),
    CONSTRAINT fk_bloodunit_donation
        FOREIGN KEY (donation_id)
        REFERENCES donation (donation_id),
    CONSTRAINT fk_bloodunit_bloodtype
        FOREIGN KEY (blood_type_id)
        REFERENCES bloodtype (blood_type_id)
) ;

-- Creating the deferral table
CREATE TABLE  deferral (
    deferralID varchar(5) NOT NULL,
    donorID varchar(5) NOT NULL,
    deferral_date date NOT NULL,
    reason varchar(100) DEFAULT NULL,
    PRIMARY KEY (deferralID),
    KEY donorID (donorID),
    CONSTRAINT fk_deferral_donor
        FOREIGN KEY (donorID)
        REFERENCES donor (donor_id)
) ;

-- creating the temporarydeferral table
CREATE TABLE  temporarydeferral (
    tempDeferral_id varchar(5) NOT NULL,
    deferralID varchar(5) NOT NULL,
    endDate date NOT NULL,
    PRIMARY KEY (tempDeferral_id),
    KEY deferralID (deferralID),
    CONSTRAINT fk_tempdeferral_deferral
        FOREIGN KEY (deferralID)
        REFERENCES deferral (deferralID)
) ;

-- Creating the compatibility table
CREATE TABLE  compatibility (
    donor_type_id varchar(5) NOT NULL,
    recipient_type_id varchar(5) NOT NULL,
    PRIMARY KEY (donor_type_id, recipient_type_id),
    KEY recipient_type_id (recipient_type_id),
    CONSTRAINT fk_compatibility_donor
        FOREIGN KEY (donor_type_id)
        REFERENCES bloodtype (blood_type_id),
    CONSTRAINT fk_compatibility_recipient
        FOREIGN KEY (recipient_type_id)
        REFERENCES bloodtype (blood_type_id)
) ;

--creating the staff table

CREATE TABLE  staff (
    staff_id varchar(5) NOT NULL,
    staffFName varchar(30) DEFAULT NULL,
    staffLName varchar(30) DEFAULT NULL,
    staffType varchar(20) NOT NULL,
    branchID varchar(5) NOT NULL,
    role_id varchar(5) NOT NULL,
    PRIMARY KEY (staff_id),
    KEY branchID (branchID),
    KEY role_id (role_id),
    CONSTRAINT fk_staff_branch
        FOREIGN KEY (branchID)
        REFERENCES branch (branch_id),
    CONSTRAINT fk_staff_role
        FOREIGN KEY (role_id)
        REFERENCES staffrole (role_id)
) ;

--creating the request table
CREATE TABLE  request (
    Request_id varchar(5) NOT NULL,
    BloodType varchar(5) NOT NULL,
    Priority varchar(10) NOT NULL CHECK (Priority IN ('High', 'Medium', 'Low')),
    Status varchar(20) NOT NULL CHECK (Status IN ('Pending', 'Approved', 'Rejected')),
    RequestDate date NOT NULL,
    Quantity int NOT NULL,
    Hospital_id varchar(5) NOT NULL,
    PRIMARY KEY (Request_id),
    KEY Hospital_id (Hospital_id),
    KEY BloodType (BloodType),
    CONSTRAINT fk_request_hospital
        FOREIGN KEY (Hospital_id)
        REFERENCES hospital (Hospital_id),
    CONSTRAINT fk_request_bloodtype
        FOREIGN KEY (BloodType)
        REFERENCES bloodtype (blood_type_id)
) ;

--creating the test table
CREATE TABLE  test (
    Test_id varchar(5) NOT NULL,
    TestName varchar(30) NOT NULL,
    PRIMARY KEY (Test_id),
    UNIQUE KEY unique_test_name (TestName)
) ;

-- creating the screening table
CREATE TABLE  screening (
    Screening_id varchar(5) NOT NULL,
    ScreeningDate date NOT NULL,
    StaffID varchar(5) NOT NULL,
    BloodUnitID varchar(5) NOT NULL,
    OverallStatus varchar(20) NOT NULL CHECK (OverallStatus IN ('Pending', 'Passed', 'Failed')),
    PRIMARY KEY (Screening_id),
    KEY StaffID (StaffID),
    KEY BloodUnitID (BloodUnitID),
    CONSTRAINT fk_screening_staff
        FOREIGN KEY (StaffID)
        REFERENCES staff (staff_id),
    CONSTRAINT fk_screening_bloodunit
        FOREIGN KEY (BloodUnitID)
        REFERENCES bloodunit (bloodUnit_id)
) ;

-- creating the inventory table
CREATE TABLE  inventory (
    inventory_id varchar(5) NOT NULL,
    bloodUnit_id varchar(5) NOT NULL,
    branch_id varchar(5) NOT NULL,
    status varchar(20) NOT NULL CHECK (status IN ('Available', 'Reserved', 'Issued', 'Expired')),
    PRIMARY KEY (inventory_id),
    KEY bloodUnit_id (bloodUnit_id),
    KEY branch_id (branch_id),
    CONSTRAINT fk_inventory_bloodunit
        FOREIGN KEY (bloodUnit_id)
        REFERENCES bloodunit (bloodUnit_id),
    CONSTRAINT fk_inventory_branch
        FOREIGN KEY (branch_id)
        REFERENCES branch (branch_id)
) ;

-- creating the issuance table
CREATE TABLE  issuance (
    Issuance_id varchar(5) NOT NULL,
    IssuedUnits decimal(5,2) NOT NULL,
    Request_id varchar(5) NOT NULL,
    IssueDate date NOT NULL,
    StaffID varchar(5) NOT NULL,
    PRIMARY KEY (Issuance_id),
    KEY Request_id (Request_id),
    KEY StaffID (StaffID),
    CONSTRAINT fk_issuance_request
        FOREIGN KEY (Request_id)
        REFERENCES request (Request_id),
    CONSTRAINT fk_issuance_staff
        FOREIGN KEY (StaffID)
        REFERENCES staff (staff_id)
) ;

-- creating the issuedbloodunit table
CREATE TABLE  issuedbloodunit (
    Issuance_id varchar(5) NOT NULL,
    bloodUnit_id varchar(5) NOT NULL,
    PRIMARY KEY (Issuance_id, bloodUnit_id),
    KEY bloodUnit_id (bloodUnit_id),
    CONSTRAINT fk_issuedunit_issuance
        FOREIGN KEY (Issuance_id)
        REFERENCES issuance (Issuance_id),
    CONSTRAINT fk_issuedunit_bloodunit
        FOREIGN KEY (bloodUnit_id)
        REFERENCES bloodunit (bloodUnit_id)
) ;

--creating the testresult table
CREATE TABLE  testresult (
    TestResultID varchar(5) NOT NULL,
    Screening_id varchar(5) NOT NULL,
    Test_id varchar(5) NOT NULL,
    Result varchar(10) DEFAULT NULL CHECK (Result IN ('Positive', 'Negative')),
    PRIMARY KEY (TestResultID),
    KEY Screening_id (Screening_id),
    KEY Test_id (Test_id),
    CONSTRAINT fk_testresult_screening
        FOREIGN KEY (Screening_id)
        REFERENCES screening (Screening_id),
    CONSTRAINT fk_testresult_test
        FOREIGN KEY (Test_id)
        REFERENCES test (Test_id)
) ;

--creating the user table
CREATE TABLE  User (
    user_id varchar(5) NOT NULL,
    password_hash varchar(255) NOT NULL,
    user_type varchar(10) NOT NULL CHECK (user_type IN ('staff', 'hospital')),
    staff_id varchar(5) DEFAULT NULL,
    hospital_id varchar(5) DEFAULT NULL,
    PRIMARY KEY (user_id),
    KEY staff_id (staff_id),
    KEY hospital_id (hospital_id),
    CONSTRAINT fk_user_staff
        FOREIGN KEY (staff_id)
        REFERENCES staff (staff_id),
    CONSTRAINT fk_user_hospital
        FOREIGN KEY (hospital_id)
        REFERENCES hospital (Hospital_id)
) ;
