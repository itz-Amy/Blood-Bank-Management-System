USE bloodbank;

DELIMITER //

DROP FUNCTION IF EXISTS fn_hasactivedeferral//

CREATE FUNCTION fn_hasactivedeferral(
    p_donor_id VARCHAR(5)
)
RETURNS TINYINT
READS SQL DATA
BEGIN
    DECLARE v_count INT DEFAULT 0;

    SELECT COUNT(*)
    INTO v_count
    FROM Deferral df
    LEFT JOIN TemporaryDeferral td
        ON df.deferralID = td.deferralID
    WHERE df.donorID = p_donor_id
      AND (td.tempDeferral_id IS NULL
           OR td.endDate > CURDATE());

    IF v_count > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END//

DROP FUNCTION IF EXISTS fn_daysbetween//

CREATE FUNCTION fn_daysbetween(
    start_date DATE,
    end_date DATE
)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(end_date, start_date);
END//

DELIMITER ;