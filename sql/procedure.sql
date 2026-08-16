USE bloodbank;

DELIMITER //

DROP PROCEDURE IF EXISTS sp_registerdonation//

CREATE PROCEDURE sp_registerdonation(
    IN p_donor_id VARCHAR(5),
    IN p_volume DECIMAL(5,2),
    IN p_branch_id VARCHAR(5)
)
BEGIN
    DECLARE v_donation_id VARCHAR(5);
    DECLARE v_unit_id VARCHAR(5);

    SET v_donation_id = CONCAT(
        'DN',
        LPAD((SELECT COUNT(*) + 1 FROM Donation), 3, '0')
    );

    SET v_unit_id = CONCAT(
        'BU',
        LPAD((SELECT COUNT(*) + 1 FROM BloodUnit), 3, '0')
    );

    INSERT INTO Donation
        (donation_id, donor_id, volume, DonationDate, branch_id)
    VALUES
        (v_donation_id, p_donor_id, p_volume, CURDATE(), p_branch_id);

    INSERT INTO BloodUnit
        (bloodUnit_id, donation_id, procurement_date, expiry_date, blood_vol)
    VALUES
        (v_unit_id, v_donation_id, CURDATE(),
         DATE_ADD(CURDATE(), INTERVAL 42 DAY), p_volume);
END//

DROP PROCEDURE IF EXISTS sp_recordtestresult//

CREATE PROCEDURE sp_recordtestresult(
    IN p_screening_id VARCHAR(5),
    IN p_test_id VARCHAR(5),
    IN p_result VARCHAR(10)
)
BEGIN
    DECLARE v_result_id VARCHAR(5);

    SET v_result_id = CONCAT(
        'TR',
        LPAD((SELECT COUNT(*) FROM TestResult) + 1, 3, '0')
    );

    INSERT INTO TestResult
        (TestResultID, Screening_id, Test_id, Result)
    VALUES
        (v_result_id, p_screening_id, p_test_id, p_result);
END//

DELIMITER ;