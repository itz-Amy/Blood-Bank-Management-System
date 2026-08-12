

CREATE ROLE IF NOT EXISTS db_admin;
CREATE ROLE IF NOT EXISTS blood_bank_manager;
CREATE ROLE IF NOT EXISTS lab_tech;
CREATE ROLE IF NOT EXISTS phlebotomist;
CREATE ROLE IF NOT EXISTS hospital_rep;




GRANT ALL PRIVILEGES
ON bloodbank.*
TO db_admin;



GRANT SELECT
ON bloodbank.BloodType
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.Compatibility
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.Donor
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.Deferral
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.TemporaryDeferral
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.BloodUnit
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.Screening
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.Test
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.TestResult
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.Issuance
TO blood_bank_manager;

GRANT SELECT
ON bloodbank.IssuedBloodUnits
TO blood_bank_manager;


GRANT SELECT, INSERT, UPDATE
ON bloodbank.Branch
TO blood_bank_manager;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.Staff
TO blood_bank_manager;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.StaffRole
TO blood_bank_manager;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.Hospital
TO blood_bank_manager;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.Inventory
TO blood_bank_manager;


GRANT SELECT, UPDATE
ON bloodbank.Request
TO blood_bank_manager;






GRANT SELECT
ON bloodbank.BloodType
TO lab_tech;

GRANT SELECT
ON bloodbank.Donor
TO lab_tech;

GRANT SELECT
ON bloodbank.Deferral
TO lab_tech;

GRANT SELECT
ON bloodbank.Donation
TO lab_tech;

GRANT SELECT
ON bloodbank.BloodUnit
TO lab_tech;

GRANT SELECT
ON bloodbank.TemporaryDeferral
TO lab_tech;

GRANT SELECT
ON bloodbank.Branch
TO lab_tech;

GRANT SELECT
ON bloodbank.Hospital
TO lab_tech;

GRANT SELECT
ON bloodbank.Request
TO lab_tech;

GRANT SELECT
ON bloodbank.Compatibility
TO lab_tech;


GRANT SELECT, INSERT, UPDATE
ON bloodbank.Screening
TO lab_tech;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.TestResult
TO lab_tech;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.Inventory
TO lab_tech;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.BloodUnit
TO lab_tech;


GRANT SELECT, INSERT
ON bloodbank.Issuance
TO lab_tech;

GRANT SELECT, INSERT
ON bloodbank.IssuedBloodUnit
TO lab_tech;







GRANT SELECT
ON bloodbank.BloodType
TO phlebotomist;

GRANT SELECT
ON bloodbank.Branch
TO phlebotomist;


GRANT SELECT, INSERT, UPDATE
ON bloodbank.Donor
TO phlebotomist;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.Deferral
TO phlebotomist;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.TemporaryDeferral
TO phlebotomist;

GRANT SELECT, INSERT, UPDATE
ON bloodbank.Donation
TO phlebotomist;






GRANT SELECT
ON bloodbank.BloodType
TO hospital_rep;

GRANT SELECT
ON bloodbank.Compatibility
TO hospital_rep;

GRANT SELECT
ON bloodbank.Hospital
TO hospital_rep;


GRANT SELECT, INSERT
ON bloodbank.Request
TO hospital_rep;

GRANT SELECT, INSERT
ON bloodbank.Issuance
TO hospital_rep;

GRANT SELECT, INSERT
ON bloodbank.IssuedBloodUnit
TO hospital_rep;





SET ROLE phlebotomist;

SELECT * FROM bloodbank.Donor;





SET ROLE phlebotomist;

UPDATE bloodbank.Hospital
SET HospitalName = 'Test'
WHERE HospitalNo = 999999;