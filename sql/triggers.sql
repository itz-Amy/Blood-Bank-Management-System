USE bloodbank;

-- 1. Automatically set blood type for a new blood unit
DELIMITER //

CREATE TRIGGER trg_SetUnitBloodType
BEFORE INSERT ON bloodunit
FOR EACH ROW
BEGIN
    SELECT d.blood_type_id INTO @unit_type
    FROM Donation dn
    JOIN Donor d ON dn.donor_id = d.donor_id
    WHERE dn.donation_id = NEW.donation_id;

    SET NEW.blood_type_id = @unit_type;
END//

-- 2. Prevent Donation from a donor with an active deferral

DELIMITER //

CREATE TRIGGER trg_CheckDeferralBeforeDonation
BEFORE INSERT ON donation
FOR EACH ROW
BEGIN
    IF fn_HasActiveDeferral(NEW.donor_id) = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Donor currently has an active deferral! Donation blocked';
    END IF;
END//

--3. Enforce the 56 days waiting period between donations
DELIMITER //

CREATE TRIGGER trg_CheckRecencyBeforeDonation
BEFORE INSERT ON donation
FOR EACH ROW
BEGIN
    DECLARE v_last_donation DATE;

    SELECT MAX(DonationDate)
    INTO v_last_donation
    FROM Donation
    WHERE donor_id = NEW.donor_id;

    IF v_last_donation IS NOT NULL
       AND fn_DaysBetween(v_last_donation, CURDATE()) < 56 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Donor has not waited long enough since last donation';
    END IF;
END//

-- 4. Prevent registration of donors under 18 years old

DELIMITER //

CREATE TRIGGER trg_CheckDonorAge
BEFORE INSERT ON donor
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.DOB, CURDATE()) < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Donor must be at least 18 years old';
    END IF;
END//
-- 5. Prevent Unsuitable blood units from entering inventory

DELIMITER //
CREATE TRIGGER trg_CheckBloodUnitBeforeInventory
BEFORE INSERT ON inventory
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(20);
    DECLARE v_blood_type VARCHAR(5);

    SELECT OverallStatus
    INTO v_status
    FROM Screening
    WHERE BloodUnitID = NEW.bloodUnit_id;

    SELECT blood_type_id
    INTO v_blood_type
    FROM BloodUnit
    WHERE bloodUnit_id = NEW.bloodUnit_id;

    IF v_status <> 'Passed' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Only blood units that pass screening can enter inventory';

    ELSEIF v_blood_type IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Blood type must be determined before entering inventory';
    END IF;
END//

-- 6. Prevent issuing incompatible or unavailable blood units
DELIMITER //

CREATE TRIGGER trg_CheckCompatibilityBeforeIssue
BEFORE INSERT ON issuedbloodunit
FOR EACH ROW
BEGIN
    DECLARE unit_type VARCHAR(5);
    DECLARE request_type VARCHAR(5);
    DECLARE is_compatible INT;
    DECLARE unit_status VARCHAR(20);

    SELECT bu.blood_type_id
    INTO unit_type
    FROM BloodUnit bu
    WHERE bu.bloodUnit_id = NEW.bloodUnit_id;

    SELECT r.BloodType
    INTO request_type
    FROM Issuance i
    JOIN Request r ON i.Request_id = r.Request_id
    WHERE i.Issuance_id = NEW.Issuance_id;

    SELECT COUNT(*)
    INTO is_compatible
    FROM Compatibility
    WHERE donor_type_id = unit_type
      AND recipient_type_id = request_type;

    SELECT status
    INTO unit_status
    FROM Inventory
    WHERE bloodUnit_id = NEW.bloodUnit_id;

    IF unit_status <> 'Available' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Blood unit is not currently available';

    ELSEIF is_compatible = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Blood type incompatible with request';
    END IF;
END//

--7. Automatically defer donor after failed screening

DELIMITER //

CREATE TRIGGER trg_AutoDeferOnFailedScreening
AFTER UPDATE ON screening
FOR EACH ROW
BEGIN
    DECLARE v_donor_id VARCHAR(5);

    IF NEW.OverallStatus = 'Failed'
       AND OLD.OverallStatus <> 'Failed' THEN

        SELECT d.donor_id
        INTO v_donor_id
        FROM BloodUnit bu
        JOIN Donation dn ON bu.donation_id = dn.donation_id
        JOIN Donor d ON dn.donor_id = d.donor_id
        WHERE bu.bloodUnit_id = NEW.BloodUnitID;

        INSERT INTO Deferral
            (deferralID, donorID, deferral_date, reason)
        VALUES
            (
                CONCAT('DF', LPAD(
                    (SELECT COUNT(*) FROM Deferral) + 1,
                    3, '0'
                )),
                v_donor_id,
                CURDATE(),
                'Failed mandatory screening test'
            );
    END IF;
END//


-- 8. Automatically Update Screening Status Based on Test Results
DELIMITER //

CREATE TRIGGER trg_UpdateScreeningStatus
AFTER INSERT ON testresult
FOR EACH ROW
BEGIN
    DECLARE v_total_tests INT;
    DECLARE v_recorded_tests INT;
    DECLARE v_failed_tests INT;

    SELECT COUNT(*)
    INTO v_total_tests
    FROM Test;

    SELECT COUNT(DISTINCT Test_id)
    INTO v_recorded_tests
    FROM TestResult
    WHERE Screening_id = NEW.Screening_id;

    SELECT COUNT(*)
    INTO v_failed_tests
    FROM TestResult
    WHERE Screening_id = NEW.Screening_id
      AND Result = 'Positive';

    IF v_failed_tests > 0 THEN
        UPDATE Screening
        SET OverallStatus = 'Failed'
        WHERE Screening_id = NEW.Screening_id;

    ELSEIF v_recorded_tests = v_total_tests THEN
        UPDATE Screening
        SET OverallStatus = 'Passed'
        WHERE Screening_id = NEW.Screening_id;
    END IF;
END//

DELIMITER ;


-- 9. Automatically add a passed blood unit to inventory
DELIMITER //
DROP TRIGGER IF EXISTS trg_AddPassedUnitToInventory//

CREATE TRIGGER trg_AddPassedUnitToInventory
AFTER UPDATE ON Screening
FOR EACH ROW
BEGIN
    DECLARE v_branch_id VARCHAR(5);
    DECLARE v_inventory_id VARCHAR(5);

    IF NEW.OverallStatus = 'Passed'
       AND OLD.OverallStatus <> 'Passed' THEN

        SELECT dn.branch_id
        INTO v_branch_id
        FROM BloodUnit bu
        JOIN Donation dn
            ON bu.donation_id = dn.donation_id
        WHERE bu.bloodUnit_id = NEW.BloodUnitID;

        SELECT CONCAT(
            'IN',
            LPAD(COALESCE(
                    MAX(CAST(SUBSTRING(inventory_id, 3) AS UNSIGNED)),0) + 1,3,'0'))
        INTO v_inventory_id
        FROM Inventory;

        INSERT INTO Inventory
            ( inventory_id,
                bloodUnit_id,
                branch_id,
                status)
        VALUES
            (  v_inventory_id,
                NEW.BloodUnitID,
                v_branch_id,
                'Available' );
    END IF;
END//

DELIMITER ;
