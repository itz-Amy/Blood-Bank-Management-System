USE bloodbank;

-- summary of all blood units currently available in inventory --

DROP VIEW IF EXISTS vw_availableinventory;
CREATE VIEW vw_availableinventory AS
SELECT
    br.branch_id,
    br.branchName,
    bt.blood_type_id,
    bt.abo_group,
    bt.rh_factor,
    COUNT(*) AS total_available
FROM inventory inv
JOIN branch br
    ON inv.branch_id = br.branch_id
JOIN bloodunit bu
    ON inv.bloodUnit_id = bu.bloodUnit_id
JOIN bloodtype bt
    ON bu.blood_type_id = bt.blood_type_id
WHERE inv.status = 'Available'
GROUP BY
    br.branch_id,
    br.branchName,
    bt.blood_type_id,
    bt.abo_group,
    bt.rh_factor;


-- Shows the number of available blood units that are compatible with each hospital request.--

DROP VIEW IF EXISTS vw_compatibleavailableunits;
CREATE VIEW vw_compatibleavailableunits AS
SELECT
    r.Request_id,
    bt.blood_type_id,
    bt.abo_group,
    bt.rh_factor,
    br.branch_id,
    br.branchName,
    COUNT(bu.bloodUnit_id) AS available_units
FROM request r
JOIN compatibility c
    ON c.recipient_type_id = r.BloodType
JOIN bloodunit bu
    ON bu.blood_type_id = c.donor_type_id
JOIN inventory inv
    ON inv.bloodUnit_id = bu.bloodUnit_id
JOIN bloodtype bt
    ON bu.blood_type_id = bt.blood_type_id
JOIN branch br
    ON inv.branch_id = br.branch_id
WHERE inv.status = 'Available'
  AND bu.expiry_date > CURDATE()
GROUP BY
    r.Request_id,
    bt.blood_type_id,
    bt.abo_group,
    bt.rh_factor,
    br.branch_id,
    br.branchName;

-- Shows donors who are currently eligible to donate blood.-- 

DROP VIEW IF EXISTS vw_eligibledonors;
CREATE VIEW vw_eligibledonors AS
SELECT
    d.donor_id,
    d.donorFName,
    d.donorLName,
    MAX(dn.DonationDate) AS last_donation_date
FROM donor d
LEFT JOIN donation dn
    ON d.donor_id = dn.donor_id
LEFT JOIN (
    SELECT DISTINCT
        df.donorID
    FROM deferral df
    LEFT JOIN temporarydeferral td
        ON df.deferralID = td.deferralID
    WHERE td.tempDeferral_id IS NULL
       OR td.endDate > CURDATE()
) active_def
    ON d.donor_id = active_def.donorID
WHERE active_def.donorID IS NULL
GROUP BY
    d.donor_id,
    d.donorFName,
    d.donorLName
HAVING
    MAX(dn.DonationDate) IS NULL
    OR MAX(dn.DonationDate) <= CURDATE() - INTERVAL 56 DAY;


-- detailed view of blood screening records, including the blood unit, screening information, test and test results performed.--
       
DROP VIEW IF EXISTS vw_screeningstatus;
CREATE VIEW vw_screeningstatus AS
SELECT
    bu.bloodUnit_id,
    br.branchName,
    sc.Screening_id,
    sc.ScreeningDate,
    sc.OverallStatus,
    fn_DaysBetween(
        sc.ScreeningDate,
        CURDATE()
    ) AS days_since_screening_started,
    t.TestName,
    tr.Result
FROM bloodunit bu
JOIN screening sc
    ON sc.BloodUnitID = bu.bloodUnit_id
JOIN donation dn
    ON bu.donation_id = dn.donation_id
JOIN staff st
    ON sc.StaffID = st.staff_id
JOIN branch br
    ON st.branchID = br.branch_id
JOIN testresult tr
    ON tr.Screening_id = sc.Screening_id
JOIN test t
    ON tr.Test_id = t.Test_id
ORDER BY
    sc.ScreeningDate,
    bu.bloodUnit_id;
