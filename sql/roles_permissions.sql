
--creating the roles--
CREATE ROLE db_admin;
CREATE ROLE blood_bank_manager;
CREATE ROLE lab_tech;
CREATE ROLE phlebotomist;
CREATE ROLE hospital_rep;

--granting db_admin privileges--
GRANT ALL PRIVILEGES ON bloodbank.* TO db_admin;

-- blood bank managers privileges--

GRANT SELECT, UPDATE ON bloodbank.request TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.branch TO blood_bank_manager;
GRANT SELECT ON bloodbank.issuedbloodunit TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.donation TO blood_bank_manager;
GRANT SELECT ON bloodbank.compatibility TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.staff TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.staffrole TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.bloodunit TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.testresult TO blood_bank_manager;
GRANT SELECT ON bloodbank.bloodtype TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.donor TO blood_bank_manager;
GRANT SELECT ON bloodbank.issuance TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.hospital TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.inventory TO blood_bank_manager;
GRANT SELECT ON bloodbank.test TO blood_bank_manager;
GRANT SELECT ON bloodbank.deferral TO blood_bank_manager;
GRANT SELECT, INSERT, UPDATE ON bloodbank.screening TO blood_bank_manager;
GRANT SELECT ON bloodbank.temporarydeferral TO blood_bank_manager;
GRANT EXECUTE ON PROCEDURE bloodbank.sp_recordtestresult TO blood_bank_manager;
GRANT EXECUTE ON PROCEDURE bloodbank.sp_registerdonation TO blood_bank_manager;
GRANT EXECUTE ON FUNCTION bloodbank.fn_daysbetween TO blood_bank_manager;
GRANT EXECUTE ON FUNCTION bloodbank.fn_hasactivedeferral TO blood_bank_manager;

--Lab tech privileges --

GRANT SELECT ON bloodbank.donation TO lab_tech;
GRANT SELECT, INSERT, UPDATE ON bloodbank.bloodunit TO lab_tech;
GRANT SELECT ON bloodbank.bloodtype TO lab_tech;
GRANT SELECT ON bloodbank.donor TO lab_tech;
GRANT SELECT ON bloodbank.compatibility TO lab_tech;
GRANT SELECT ON bloodbank.hospital TO lab_tech;
GRANT SELECT ON bloodbank.test TO lab_tech;
GRANT SELECT ON bloodbank.branch TO lab_tech;
GRANT SELECT, INSERT, UPDATE ON bloodbank.screening TO lab_tech;
GRANT SELECT, INSERT ON bloodbank.issuedbloodunit TO lab_tech;
GRANT SELECT ON bloodbank.temporarydeferral TO lab_tech;
GRANT SELECT ON bloodbank.request TO lab_tech;
GRANT SELECT, INSERT ON bloodbank.issuance TO lab_tech;
GRANT SELECT, INSERT, UPDATE ON bloodbank.testresult TO lab_tech;
GRANT SELECT, INSERT, UPDATE ON bloodbank.inventory TO lab_tech;
GRANT SELECT ON bloodbank.deferral TO lab_tech;
GRANT EXECUTE ON PROCEDURE bloodbank.sp_recordtestresult TO lab_tech;

-- Phlebotomist privileges--
GRANT SELECT, INSERT, UPDATE ON bloodbank.temporarydeferral TO phlebotomist;
GRANT SELECT ON bloodbank.bloodtype TO phlebotomist;
GRANT SELECT, INSERT, UPDATE ON bloodbank.donation TO phlebotomist;
GRANT SELECT, INSERT, UPDATE ON bloodbank.deferral TO phlebotomist;
GRANT SELECT ON bloodbank.branch TO phlebotomist;
GRANT SELECT, INSERT, UPDATE ON bloodbank.donor TO phlebotomist;
GRANT SELECT, INSERT ON bloodbank.bloodunit TO phlebotomist;
GRANT EXECUTE ON PROCEDURE bloodbank.sp_registerdonation TO phlebotomist;

--Hospital rep privileges --

GRANT SELECT ON bloodbank.hospital TO hospital_rep;
GRANT SELECT, INSERT ON bloodbank.issuedbloodunit TO hospital_rep;
GRANT SELECT ON bloodbank.compatibility TO hospital_rep;
GRANT SELECT ON bloodbank.bloodtype TO hospital_rep;
GRANT SELECT, INSERT ON bloodbank.request TO hospital_rep;
GRANT SELECT, INSERT ON bloodbank.issuance TO hospital_rep;
GRANT EXECUTE ON PROCEDURE bloodbank.sp_CreateRequest TO hospital_rep;

-- grant the roles to the bloodbank_app user--

GRANT phlebotomist TO 'bloodbank_app'@'localhost';
GRANT lab_tech TO 'bloodbank_app'@'localhost';
GRANT blood_bank_manager TO 'bloodbank_app'@'localhost';
GRANT hospital_rep TO 'bloodbank_app'@'localhost';

--Select privileges for the bloodbank_app user
GRANT SELECT ON bloodbank.bloodtype TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.bloodunit TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.branch TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.hospital TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.inventory TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.issuance TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.pendingrequests TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.request TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.staff TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.user TO 'bloodbank_app'@'localhost';

GRANT SELECT ON bloodbank.vw_availableinventory TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.vw_compatibleavailableunits TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.vw_eligibledonors TO 'bloodbank_app'@'localhost';
GRANT SELECT ON bloodbank.vw_screeningstatus TO 'bloodbank_app'@'localhost';

GRANT EXECUTE ON PROCEDURE bloodbank.sp_registerdonation TO 'bloodbank_app'@'localhost';
GRANT EXECUTE ON PROCEDURE bloodbank.sp_recordtestresult TO 'bloodbank_app'@'localhost';
GRANT EXECUTE ON FUNCTION bloodbank.fn_hasactivedeferral TO 'bloodbank_app'@'localhost';
GRANT EXECUTE ON FUNCTION bloodbank.fn_daysbetween TO 'bloodbank_app'@'localhost';
