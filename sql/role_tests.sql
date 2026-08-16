-- Sample queries to set permissions --
SET ROLE phlebotomist;

SELECT * FROM bloodbank.Donor;




SET ROLE phlebotomist;
UPDATE bloodbank.Hospital
SET HospitalName = 'Test'
WHERE Hospital_id = 999999;
