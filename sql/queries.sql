
-- 1. Donation History for Ama Boatenge
SELECT donation.donation_id, donation.DonationDate, donation.volume
FROM Donation
JOIN Donor ON donation.donor_id = donor.donor_id
WHERE donor.donorFName = 'Ama' AND donor.donorLName = 'Boateng';

--2. Available blood units by branch

SELECT  b.branchName, bt.abo_group,  bt.rh_factor,
    COUNT(*) AS total_available
FROM Inventory i
JOIN Branch b ON i.branch_id = b.branch_id
JOIN BloodUnit bu ON i.bloodUnit_id = bu.bloodUnit_id
JOIN BloodType bt ON bu.blood_type_id = bt.blood_type_id
WHERE i.status = 'Available'
GROUP BY b.branch_id, b.branchName, bt.blood_type_id, bt.abo_group, bt.rh_factor
ORDER BY b.branchName;

--3. Donors and their blood type
SELECT d.donor_id, d.donorFName, d.donorLName, bt.abo_group, bt.rh_factor
FROM Donor as d
JOIN BloodType as bt ON d.blood_type_id = bt.blood_type_id;

-- 4. Donors eligible to donate again
SELECT d.donor_id, d.donorFName, d.donorLName, MAX(dn.DonationDate) AS last_donation
FROM Donor as d
JOIN Donation as dn ON d.donor_id = dn.donor_id
GROUP BY d.donor_id, d.donorFName, d.donorLName
HAVING fn_DaysBetween(Max(dn.DonationDate), CURDATE()) >= 56
   AND donor_id NOT IN (
        SELECT df.donorID
        FROM Deferral as df
        LEFT JOIN TemporaryDeferral as td ON df.deferralID = td.tempDeferral_id
        WHERE td.tempDeferral_id IS NULL OR td.endDate > CURDATE() );


-- 5. Find available blood units expiring within 7 days
SELECT bu.bloodUnit_id, bt.abo_group, bt.rh_factor, bu.expiry_date, inv.branch_id
FROM BloodUnit bu
JOIN BloodType bt ON bu.blood_type_id = bt.blood_type_id
JOIN Inventory inv ON inv.bloodUnit_id = bu.bloodUnit_id
WHERE inv.status = 'Available'  AND fn_DaysBetween( CURDATE(),  bu.expiry_date ) BETWEEN 0 AND 7
ORDER BY bu.expiry_date;

-- 6. Count donations made at each branch this month
SELECT br.branchName, COUNT(*) AS total_units_this_month
FROM Donation dn
JOIN Branch br ON dn.branch_id = br.branch_id
WHERE MONTH(dn.DonationDate) = MONTH(CURDATE())
  AND YEAR(dn.DonationDate) = YEAR(CURDATE())
GROUP BY br.branchName
ORDER BY total_units_this_month DESC;

-- 7. Staff assigned to a specific branch
SELECT s.staff_id, s.staffFName, s.staffLName, s.staffType
FROM Staff s
JOIN Branch br ON s.branchID = br.branch_id
WHERE br.branchName = 'Accra Central';

-- 8. Count pending requests by hospital
SELECT h.HospitalName, COUNT(*) AS pending_requests
FROM Request as r
JOIN Hospital as h ON r.Hospital_id = h.Hospital_id
WHERE r.Status = 'Pending'
GROUP BY h.HospitalName
ORDER BY pending_requests DESC;

-- 9. Donors with no recorded deferrals
SELECT d.donor_id, d.donorFName, d.donorLName
FROM Donor d
LEFT JOIN Deferral df 
    ON d.donor_id = df.donorID
LEFT JOIN TemporaryDeferral td
    ON df.deferralID = td.deferralID
WHERE df.deferralID IS NULL;

-- 10. Find compatible available blood unit for a request

SELECT inv.inventory_id, bu.bloodUnit_id, bt.abo_group, bt.rh_factor, bu.blood_vol,    inv.branch_id
FROM Request r
JOIN Compatibility c ON c.recipient_type_id = r.BloodType
JOIN BloodUnit bu ON bu.blood_type_id = c.donor_type_id
JOIN Inventory inv ON inv.bloodUnit_id = bu.bloodUnit_id
JOIN BloodType bt ON bu.blood_type_id = bt.blood_type_id
WHERE r.Request_id = 'RQ007'
  AND inv.status = 'Available'
  AND bu.expiry_date > CURDATE();


-- 11. Rank staff members by number of screenings conducted
SELECT s.staff_id, s.staffFName, s.staffLName,
       COUNT(*) AS screenings_done
FROM Staff s
JOIN Screening sc ON s.staff_id = sc.StaffID
GROUP BY s.staff_id, s.staffFName, s.staffLName
ORDER BY screenings_done DESC;


-- 12 Requests for a specific hospital 

SELECT r.Request_id, r.BloodType, r.Quantity, r.Priority, r.Status, r.RequestDate
FROM Request as r
JOIN Hospital as h ON r.Hospital_id = h.Hospital_id
WHERE h.HospitalName = 'Korle Bu Teaching Hospital';


-- 3. High priority pending blood requests
SELECT r.Request_id, h.HospitalName, r.Quantity, r.RequestDate
FROM Request as r
JOIN Hospital as h ON r.Hospital_id = h.Hospital_id
WHERE r.Priority = 'High' AND r.Status = 'Pending';

