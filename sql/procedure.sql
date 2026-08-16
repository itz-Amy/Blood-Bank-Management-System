
-- issueing a blood unit
DELIMITER //

CREATE PROCEDURE sp_IssueBloodUnit(
    IN p_request_id VARCHAR(5),
    IN p_blood_type_id VARCHAR(5),
    IN p_quantity INT,
    IN p_staff_id VARCHAR(5)
)
BEGIN
    DECLARE v_issuance_id VARCHAR(5);
    DECLARE v_request_quantity INT;
    DECLARE v_issued_quantity DECIMAL(10,2);
    DECLARE v_remaining_quantity INT;
    DECLARE v_available_quantity INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT Quantity
    INTO v_request_quantity
    FROM Request
    WHERE Request_id = p_request_id
      AND Status = 'Approved'
    FOR UPDATE;

    IF v_request_quantity IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Approved request does not exist';
    END IF;

    SELECT COALESCE(SUM(IssuedUnits), 0)
    INTO v_issued_quantity
    FROM Issuance
    WHERE Request_id = p_request_id;

    SET v_remaining_quantity = v_request_quantity - v_issued_quantity;

    IF p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    IF p_quantity > v_remaining_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity exceeds remaining request quantity';
    END IF;

    SELECT inv.bloodUnit_id
    FROM Inventory inv
    JOIN BloodUnit bu ON bu.bloodUnit_id = inv.bloodUnit_id
    JOIN Compatibility c ON c.donor_type_id = bu.blood_type_id
    JOIN Request r ON r.BloodType = c.recipient_type_id
    WHERE r.Request_id = p_request_id
      AND bu.blood_type_id = p_blood_type_id
      AND inv.status = 'Available'
      AND bu.expiry_date > CURDATE()
    ORDER BY bu.expiry_date ASC
    LIMIT p_quantity
    FOR UPDATE;

    SELECT COUNT(*)
    INTO v_available_quantity
    FROM BloodUnit bu
    JOIN Inventory inv ON inv.bloodUnit_id = bu.bloodUnit_id
    JOIN Compatibility c ON c.donor_type_id = bu.blood_type_id
    JOIN Request r ON r.BloodType = c.recipient_type_id
    WHERE r.Request_id = p_request_id
      AND bu.blood_type_id = p_blood_type_id
      AND inv.status = 'Available'
      AND bu.expiry_date > CURDATE();

    IF v_available_quantity < p_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough compatible units available';
    END IF;

    SELECT CONCAT(
        'IS',
        LPAD(
            COALESCE(MAX(CAST(SUBSTRING(Issuance_id, 3) AS UNSIGNED)), 0) + 1,
            3, '0'
        )
    )
    INTO v_issuance_id
    FROM Issuance;

    INSERT INTO Issuance (Issuance_id, IssuedUnits, Request_id, StaffID, IssueDate)
    VALUES (v_issuance_id, p_quantity, p_request_id, p_staff_id, CURDATE());

    INSERT INTO IssuedBloodUnit (Issuance_id, bloodUnit_id)
    SELECT v_issuance_id, bu.bloodUnit_id
    FROM BloodUnit bu
    JOIN Inventory inv ON inv.bloodUnit_id = bu.bloodUnit_id
    JOIN Compatibility c ON c.donor_type_id = bu.blood_type_id
    JOIN Request r ON r.BloodType = c.recipient_type_id
    WHERE r.Request_id = p_request_id
      AND bu.blood_type_id = p_blood_type_id
      AND inv.status = 'Available'
      AND bu.expiry_date > CURDATE()
    ORDER BY bu.expiry_date ASC
    LIMIT p_quantity;

    UPDATE Inventory inv
    JOIN IssuedBloodUnit ibu ON ibu.bloodUnit_id = inv.bloodUnit_id
    SET inv.status = 'Issued'
    WHERE ibu.Issuance_id = v_issuance_id;

    COMMIT;
END //

-- recording a test result

DELIMITER //

CREATE PROCEDURE sp_RecordTestResult(
    IN p_screening_id VARCHAR(5),
    IN p_test_id VARCHAR(5),
    IN p_result VARCHAR(10)
)
BEGIN
    DECLARE v_result_id VARCHAR(5);

    SET v_result_id = CONCAT('TR', LPAD((SELECT COUNT(*) FROM TestResult) + 1, 3, '0'));

    INSERT INTO TestResult (TestResultID, Screening_id, Test_id, Result)
    VALUES (v_result_id, p_screening_id, p_test_id, p_result);
END //


-- registering donations and add a blood unit to the table
DELIMITER //

CREATE PROCEDURE sp_RegisterDonation(
    IN p_donor_id VARCHAR(5),
    IN p_volume DECIMAL(5,2),
    IN p_branch_id VARCHAR(5)
)
BEGIN
    DECLARE v_donation_id VARCHAR(5);
    DECLARE v_unit_id VARCHAR(5);

    SET v_donation_id = CONCAT('DN', LPAD((SELECT COUNT(*)+1 FROM Donation), 3, '0'));
    SET v_unit_id = CONCAT('BU', LPAD((SELECT COUNT(*)+1 FROM BloodUnit), 3, '0'));

    INSERT INTO Donation (donation_id, donor_id, volume, DonationDate, branch_id)
    VALUES (v_donation_id, p_donor_id, p_volume, CURDATE(), p_branch_id);

    INSERT INTO BloodUnit (bloodUnit_id, donation_id, procurement_date, expiry_date, blood_vol)
    VALUES (v_unit_id, v_donation_id, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 42 DAY), p_volume);
END //

DELIMITER ;

-- creating a request

DELIMITER //

CREATE PROCEDURE sp_CreateRequest(
    IN p_blood_type VARCHAR(5),
    IN p_priority VARCHAR(10),
    IN p_quantity INT,
    IN p_hospital_id VARCHAR(5)
)
BEGIN
    DECLARE v_request_id VARCHAR(5);
    DECLARE v_next_num INT;

    IF p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    SELECT COALESCE(MAX(CAST(SUBSTRING(Request_id, 3) AS UNSIGNED)), 0) + 1
    INTO v_next_num
    FROM Request;

    SET v_request_id = CONCAT('RQ', LPAD(v_next_num, 3, '0'));

    INSERT INTO Request (
        Request_id, BloodType, Priority, Status,
        RequestDate, Quantity, Hospital_id
    )
    VALUES (
        v_request_id, p_blood_type, p_priority, 'Pending',
        CURDATE(), p_quantity, p_hospital_id
    );
END //

DELIMITER ;
