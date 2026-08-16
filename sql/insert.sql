-- Inserting data in the tables of the database

-- Blood types

INSERT INTO bloodtype (blood_type_id, abo_group, rh_factor) VALUES
('BT001', 'A', 'Positive'),
('BT002', 'A', 'Negative'),
('BT003', 'B', 'Positive'),
('BT004', 'B', 'Negative'),
('BT005', 'AB', 'Positive'),
('BT006', 'AB', 'Negative'),
('BT007', 'O', 'Positive'),
('BT008', 'O', 'Negative');


-- Branches

INSERT INTO branch (branch_id, branchName, branchAddress, branchContact) VALUES
('B001', 'Accra Central', 'High Street, Accra', '0241001001'),
('B002', 'Kumasi North', 'Asokwa, Kumasi', '0241001002'),
('B003', 'Takoradi Branch', 'Market Circle, Takoradi', '0241001003'),
('B004', 'Tamale Branch', 'Hospital Road, Tamale', '0241001004'),
('B005', 'Cape Coast', 'Pedu Junction, Cape Coast', '0241001005'),
('B006', 'Sunyani Branch', 'Magazine Road, Sunyani', '0241001006'),
('B007', 'Ho Branch', 'Bankoe, Ho', '0241001007'),
('B008', 'Koforidua', 'Effiduase, Koforidua', '0241001008'),
('B009', 'Bolgatanga', 'Main Street, Bolgatanga', '0241001009'),
('B010', 'Wa Branch', 'Wa Central', '0241001010'),
('B011', 'Tema Branch', 'Community 1, Tema', '0241001011'),
('B012', 'Madina Branch', 'Zongo Junction, Madina', '0241001012'),
('B013', 'Kasoa Branch', 'CP Junction, Kasoa', '0241001013'),
('B014', 'Ashaiman', 'Station Road, Ashaiman', '0241001014'),
('B015', 'East Legon', 'Boundary Road, Accra', '0241001015'),
('B016', 'Dansoman', 'Exhibition Road, Accra', '0241001016'),
('B017', 'Adenta Branch', 'Housing Down, Adenta', '0241001017'),
('B018', 'Spintex Branch', 'Spintex Road, Accra', '0241001018'),
('B019', 'Winneba Branch', 'South Campus Road, Winneba', '0241001019'),
('B020', 'Techiman', 'Market Road, Techiman', '0241001020'),
('B021', 'Obuasi Branch', 'Len Clay Road, Obuasi', '0241001021'),
('B022', 'Nkawkaw', 'Roman Ridge, Nkawkaw', '0241001022'),
('B023', 'Dunkwa Branch', 'Hospital Road, Dunkwa', '0241001023'),
('B024', 'Sogakope', 'Main Highway, Sogakope', '0241001024'),
('B025', 'Aflao Branch', 'Border Road, Aflao', '0241001025');


-- Hospitals

INSERT INTO hospital (Hospital_id, HospitalName, Contact, address) VALUES
('H001', 'Korle Bu Teaching Hospital', '0302703300', 'Guggisberg Avenue, Accra'),
('H002', 'Komfo Anokye Teaching Hospital', '0322022301', 'Okomfo Anokye Road, Kumasi'),
('H003', 'Tamale Teaching Hospital', '0372022112', 'Education Ridge, Tamale'),
('H004', 'Cape Coast Teaching Hospital', '0332132450', 'Kotokuraba Road, Cape Coast'),
('H005', 'Ho Teaching Hospital', '0362023101', 'Ho Municipality, Volta Region'),
('H006', '37 Military Hospital', '0302771111', 'Liberation Road, Accra'),
('H007', 'Ridge Hospital', '0302734500', 'Castle Road, Accra'),
('H008', 'Tema General Hospital', '0303214100', 'Community 11, Tema'),
('H009', 'Eastern Regional Hospital', '0342022456', 'Koforidua, Eastern Region'),
('H010', 'Sunyani Regional Hospital', '0352021890', 'Sunyani, Bono Region'),
('H011', 'Effia Nkwanta Regional Hospital', '0312022334', 'Takoradi, Western Region'),
('H012', 'Bolgatanga Regional Hospital', '0382021540', 'Bolgatanga, Upper East Region'),
('H013', 'Wa Regional Hospital', '0392021345', 'Wa, Upper West Region'),
('H014', 'Keta Municipal Hospital', '0362098765', 'Keta, Volta Region'),
('H015', 'Dormaa Presbyterian Hospital', '0352123456', 'Dormaa Ahenkro, Bono Region'),
('H016', 'Holy Family Hospital', '0322099888', 'Techiman, Bono East Region'),
('H017', 'St. Joseph Hospital', '0332099001', 'Koforidua, Eastern Region'),
('H018', 'Agogo Presbyterian Hospital', '0322098760', 'Agogo, Ashanti Region'),
('H019', 'Madina Polyclinic', '0302504321', 'Madina, Accra'),
('H020', 'Ashaiman Polyclinic', '0302311122', 'Ashaiman, Greater Accra'),
('H021', 'Kasoa Polyclinic', '0302398765', 'Kasoa, Central Region'),
('H022', 'Winneba Municipal Hospital', '0332097654', 'Winneba, Central Region'),
('H023', 'Obuasi Government Hospital', '0322095432', 'Obuasi, Ashanti Region'),
('H024', 'Sogakope District Hospital', '0362087654', 'Sogakope, Volta Region'),
('H025', 'Aflao Municipal Hospital', '0362076543', 'Aflao, Volta Region');


-- Staff roles

INSERT INTO staffrole (role_id, roleName) VALUES
('R001', 'Phlebotomist'),
('R002', 'Laboratory Technician'),
('R003', 'Nurse'),
('R004', 'Medical Officer'),
('R005', 'Blood Bank Manager'),
('R006', 'Receptionist'),
('R007', 'Data Entry Clerk'),
('R008', 'Quality Assurance Officer'),
('R009', 'Driver'),
('R010', 'Storekeeper');


-- Donors

INSERT INTO donor (
    donor_id,
    donorFName,
    donorLName,
    DOB,
    gender,
    contact,
    email,
    address,
    weight,
    blood_type_id
) VALUES
('D001', 'Kwame', 'Mensah', '1998-04-15', 'M', '0245011001', 'kwame.mensah@email.com', 'Accra', 72.50, 'BT007'),
('D002', 'Ama', 'Boateng', '2000-08-22', 'F', '0245011002', 'ama.boateng@email.com', 'Kumasi', 61.20, 'BT001'),
('D003', 'Kofi', 'Owusu', '1995-01-10', 'M', '0245011003', 'kofi.owusu@email.com', 'Cape Coast', 78.40, 'BT003'),
('D004', 'Akosua', 'Asante', '1999-06-18', 'F', '0245011004', 'akosua.asante@email.com', 'Takoradi', 64.80, 'BT005'),
('D005', 'Yaw', 'Ofori', '1997-12-05', 'M', '0245011005', 'yaw.ofori@email.com', 'Tema', 80.10, 'BT001'),
('D006', 'Efua', 'Adjei', '2001-02-11', 'F', '0245011006', 'efua.adjei@email.com', 'Ho', 58.30, 'BT007'),
('D007', 'Kojo', 'Antwi', '1996-09-30', 'M', '0245011007', 'kojo.antwi@email.com', 'Sunyani', 75.60, 'BT004'),
('D008', 'Abena', 'Frimpong', '1998-07-19', 'F', '0245011008', 'abena.frimpong@email.com', 'Tamale', 66.70, 'BT003'),
('D009', 'Nana', 'Boadu', '1994-03-14', 'M', '0245011009', 'nana.boadu@email.com', 'Koforidua', 82.40, 'BT002'),
('D010', 'Mavis', 'Amoah', '2002-11-25', 'F', '0245011010', 'mavis.amoah@email.com', 'Kasoa', 60.90, 'BT007'),
('D011', 'Daniel', 'Appiah', '1993-10-09', 'M', '0245011011', 'daniel.appiah@email.com', 'Accra', 84.20, 'BT005'),
('D012', 'Grace', 'Arthur', '1997-05-17', 'F', '0245011012', 'grace.arthur@email.com', 'Tema', 62.10, 'BT001'),
('D013', 'Michael', 'Nyarko', '1999-08-08', 'M', '0245011013', 'michael.nyarko@email.com', 'Ho', 76.30, 'BT006'),
('D014', 'Patricia', 'Darko', '1998-01-21', 'F', '0245011014', 'patricia.darko@email.com', 'Takoradi', 59.50, 'BT008'),
('D015', 'Emmanuel', 'Agyeman', '1995-11-02', 'M', '0245011015', 'emmanuel.agyeman@email.com', 'Kumasi', 79.80, 'BT003'),
('D016', 'Linda', 'Ansah', '2000-04-12', 'F', '0245011016', 'linda.ansah@email.com', 'Cape Coast', 63.40, 'BT002'),
('D017', 'Paa Kwesi', 'Richards', '1999-05-03', 'M', '0383846282', 'udawuue@gmail.com', 'West Street', 73.00, 'BT004'),
('D018', 'Samuel', 'Adu', '1997-03-14', 'M', '0245011018', 'samuel.adu@email.com', 'Accra', 74.50, 'BT007'),
('D019', 'Esi', 'Koranteng', '1999-09-21', 'F', '0245011019', 'esi.koranteng@email.com', 'Tema', 63.20, 'BT001'),
('D020', 'Joseph', 'Amankwah', '1994-12-08', 'M', '0245011020', 'joseph.amankwah@email.com', 'Kumasi', 81.00, 'BT003'),
('D021', 'Akua', 'Mensima', '2001-05-17', 'F', '0245011021', 'akua.mensima@email.com', 'Cape Coast', 60.80, 'BT002'),
('D022', 'Richard', 'Baidoo', '1996-07-26', 'M', '0245011022', 'richard.baidoo@email.com', 'Takoradi', 77.60, 'BT005'),
('D023', 'Mabel', 'Osei', '1998-11-03', 'F', '0245011023', 'mabel.osei@email.com', 'Koforidua', 64.10, 'BT006'),
('D024', 'Eric', 'Tetteh', '1995-02-19', 'M', '0245011024', 'eric.tetteh@email.com', 'Accra', 83.40, 'BT008'),
('D025', 'Adwoa', 'Sarpong', '2000-06-12', 'F', '0245011025', 'adwoa.sarpong@email.com', 'Ho', 62.70, 'BT004'),
('D026', 'Isaac', 'Appiah', '1993-10-29', 'M', '0245011026', 'isaac.appiah@email.com', 'Sunyani', 79.90, 'BT001'),
('D027', 'Naana', 'Quartey', '1999-04-05', 'F', '0245011027', 'naana.quartey@email.com', 'Kasoa', 66.30, 'BT003');


-- Staff

INSERT INTO staff (
    staff_id,
    staffFName,
    staffLName,
    staffType,
    branchID,
    role_id
) VALUES
('S001', 'Daniel', 'Mensah', 'Full-Time', 'B001', 'R005'),
('S002', 'Kofi', 'Owusu', 'Full-Time', 'B002', 'R005'),
('S003', 'Yaw', 'Ofori', 'Full-Time', 'B003', 'R005'),
('S004', 'Kojo', 'Antwi', 'Full-Time', 'B004', 'R005'),
('S005', 'Nana', 'Boadu', 'Full-Time', 'B005', 'R005'),
('S006', 'Michael', 'Nyarko', 'Full-Time', 'B006', 'R005'),
('S007', 'Samuel', 'Baah', 'Full-Time', 'B007', 'R005'),
('S008', 'Isaac', 'Acheampong', 'Full-Time', 'B008', 'R005'),
('S009', 'George', 'Addo', 'Full-Time', 'B009', 'R005'),
('S010', 'Richard', 'Tetteh', 'Full-Time', 'B010', 'R005'),
('S011', 'Kwabena', 'Appiah', 'Full-Time', 'B011', 'R005'),
('S012', 'Emmanuel', 'Agyeman', 'Full-Time', 'B012', 'R005'),
('S013', 'Ama', 'Boateng', 'Full-Time', 'B001', 'R001'),
('S014', 'Akosua', 'Asante', 'Full-Time', 'B002', 'R001'),
('S015', 'Efua', 'Adjei', 'Full-Time', 'B003', 'R001'),
('S016', 'Abena', 'Frimpong', 'Full-Time', 'B004', 'R001'),
('S017', 'Mavis', 'Amoah', 'Full-Time', 'B005', 'R001'),
('S018', 'Grace', 'Arthur', 'Full-Time', 'B006', 'R001'),
('S019', 'Linda', 'Ansah', 'Full-Time', 'B007', 'R001'),
('S020', 'Patricia', 'Darko', 'Full-Time', 'B008', 'R001'),
('S021', 'Priscilla', 'Koranteng', 'Full-Time', 'B009', 'R001'),
('S022', 'Josephine', 'Owusuaa', 'Full-Time', 'B010', 'R001'),
('S023', 'Evelyn', 'Sarpong', 'Full-Time', 'B011', 'R001'),
('S024', 'Janet', 'Opoku', 'Full-Time', 'B012', 'R001'),
('S025', 'Michael', 'Asare', 'Full-Time', 'B001', 'R002'),
('S026', 'Esi', 'Owusu', 'Full-Time', 'B001', 'R004'),
('S027', 'Nana', 'Amoako', 'Full-Time', 'B001', 'R008'),
('S028', 'Yaw', 'Adjei', 'Full-Time', 'B002', 'R002'),
('S029', 'Abena', 'Osei', 'Part-Time', 'B002', 'R004'),
('S030', 'Kwame', 'Frimpong', 'Full-Time', 'B002', 'R008'),
('S031', 'Kojo', 'Arthur', 'Full-Time', 'B003', 'R002'),
('S032', 'Mavis', 'Yakubu', 'Full-Time', 'B004', 'R002'),
('S033', 'Kwesi', 'Mensah', 'Full-Time', 'B005', 'R004'),
('S034', 'Adwoa', 'Boateng', 'Full-Time', 'B006', 'R002'),
('S035', 'Sena', 'Kpodo', 'Full-Time', 'B007', 'R002'),
('S036', 'Emmanuel', 'Asiedu', 'Full-Time', 'B008', 'R004'),
('S037', 'Fati', 'Abubakar', 'Full-Time', 'B009', 'R002'),
('S038', 'Albert', 'Kusi', 'Full-Time', 'B010', 'R002'),
('S039', 'Doreen', 'Agyeman', 'Full-Time', 'B011', 'R002'),
('S040', 'Felix', 'Quaye', 'Full-Time', 'B011', 'R006'),
('S041', 'Richard', 'Asante', 'Full-Time', 'B012', 'R002'),
('S042', 'Akua', 'Darko', 'Full-Time', 'B012', 'R008');


-- Donations

INSERT INTO donation (
    donation_id,
    donor_id,
    volume,
    branch_id,
    DonationDate
) VALUES
('DN001', 'D001', 450.00, 'B001', '2026-01-10'),
('DN002', 'D001', 450.00, 'B001', '2026-04-15'),
('DN003', 'D001', 450.00, 'B001', '2026-07-20'),
('DN004', 'D002', 450.00, 'B002', '2026-01-15'),
('DN005', 'D002', 450.00, 'B002', '2026-04-20'),
('DN006', 'D002', 450.00, 'B002', '2026-07-25'),
('DN007', 'D003', 500.00, 'B003', '2026-02-05'),
('DN008', 'D003', 500.00, 'B003', '2026-05-10'),
('DN009', 'D003', 500.00, 'B003', '2026-08-01'),
('DN010', 'D004', 450.00, 'B004', '2026-02-15'),
('DN011', 'D004', 450.00, 'B004', '2026-05-20'),
('DN012', 'D005', 500.00, 'B005', '2026-01-20'),
('DN013', 'D005', 500.00, 'B005', '2026-04-25'),
('DN014', 'D005', 500.00, 'B005', '2026-07-30'),
('DN015', 'D006', 350.00, 'B006', '2026-03-05'),
('DN016', 'D007', 450.00, 'B007', '2026-03-20'),
('DN017', 'D008', 450.00, 'B008', '2026-04-05'),
('DN018', 'D009', 500.00, 'B009', '2026-04-20'),
('DN019', 'D010', 350.00, 'B010', '2026-05-05'),
('DN020', 'D011', 450.00, 'B011', '2026-05-20'),
('DN021', 'D012', 450.00, 'B012', '2026-06-05'),
('DN022', 'D013', 350.00, 'B013', '2026-06-20'),
('DN023', 'D014', 450.00, 'B014', '2026-07-05'),
('DN024', 'D015', 450.00, 'B015', '2026-07-15'),
('DN025', 'D016', 450.00, 'B016', '2026-08-05'),
('DN026', 'D018', 450.00, 'B001', '2026-08-15'),
('DN027', 'D019', 450.00, 'B002', '2026-08-15'),
('DN028', 'D020', 500.00, 'B003', '2026-08-15'),
('DN029', 'D021', 450.00, 'B004', '2026-08-15'),
('DN030', 'D022', 450.00, 'B005', '2026-08-15'),
('DN031', 'D023', 350.00, 'B006', '2026-08-15'),
('DN032', 'D024', 450.00, 'B007', '2026-08-15'),
('DN033', 'D025', 450.00, 'B008', '2026-08-15'),
('DN034', 'D026', 500.00, 'B009', '2026-08-15'),
('DN035', 'D027', 450.00, 'B010', '2026-08-15');


-- Blood units

INSERT INTO bloodunit (
    bloodUnit_id,
    donation_id,
    blood_type_id,
    procurement_date,
    expiry_date,
    blood_vol
) VALUES
('BU001', 'DN001', 'BT007', '2026-01-10', '2026-02-21', 450.00),
('BU002', 'DN002', 'BT007', '2026-04-15', '2026-05-27', 450.00),
('BU003', 'DN003', 'BT007', '2026-07-20', '2026-08-31', 450.00),
('BU004', 'DN004', 'BT001', '2026-01-15', '2026-02-26', 450.00),
('BU005', 'DN005', 'BT001', '2026-04-20', '2026-06-01', 450.00),
('BU006', 'DN006', 'BT001', '2026-07-25', '2026-09-05', 450.00),
('BU007', 'DN007', 'BT003', '2026-02-05', '2026-03-19', 500.00),
('BU008', 'DN008', 'BT003', '2026-05-10', '2026-06-21', 500.00),
('BU009', 'DN009', 'BT003', '2026-08-01', '2026-09-12', 500.00),
('BU010', 'DN010', 'BT005', '2026-02-15', '2026-03-29', 450.00),
('BU011', 'DN011', 'BT005', '2026-05-20', '2026-07-01', 450.00),
('BU012', 'DN012', 'BT001', '2026-01-20', '2026-03-03', 500.00),
('BU013', 'DN013', 'BT001', '2026-04-25', '2026-06-06', 500.00),
('BU014', 'DN014', 'BT001', '2026-07-30', '2026-09-10', 500.00),
('BU015', 'DN015', 'BT007', '2026-03-05', '2026-04-16', 350.00),
('BU016', 'DN016', 'BT004', '2026-03-20', '2026-05-01', 450.00),
('BU017', 'DN017', 'BT003', '2026-04-05', '2026-05-17', 450.00),
('BU018', 'DN018', 'BT002', '2026-04-20', '2026-06-01', 500.00),
('BU019', 'DN019', 'BT007', '2026-05-05', '2026-06-16', 350.00),
('BU020', 'DN020', 'BT005', '2026-05-20', '2026-07-01', 450.00),
('BU021', 'DN021', 'BT001', '2026-06-05', '2026-07-17', 450.00),
('BU022', 'DN022', 'BT006', '2026-06-20', '2026-08-01', 350.00),
('BU023', 'DN023', 'BT008', '2026-07-05', '2026-08-16', 450.00),
('BU024', 'DN024', 'BT003', '2026-07-15', '2026-08-26', 450.00),
('BU025', 'DN025', 'BT002', '2026-08-05', '2026-09-16', 450.00),
('BU026', 'DN026', 'BT007', '2026-08-15', '2026-09-26', 450.00),
('BU027', 'DN027', 'BT001', '2026-08-15', '2026-09-26', 450.00),
('BU028', 'DN028', 'BT003', '2026-08-15', '2026-09-26', 500.00),
('BU029', 'DN029', 'BT002', '2026-08-15', '2026-09-26', 450.00),
('BU030', 'DN030', 'BT005', '2026-08-15', '2026-09-26', 450.00),
('BU031', 'DN031', 'BT006', '2026-08-15', '2026-09-26', 350.00),
('BU032', 'DN032', 'BT008', '2026-08-15', '2026-09-26', 450.00),
('BU033', 'DN033', 'BT004', '2026-08-15', '2026-09-26', 450.00),
('BU034', 'DN034', 'BT001', '2026-08-15', '2026-09-26', 500.00),
('BU035', 'DN035', 'BT003', '2026-08-15', '2026-09-26', 450.00);


-- Compatibility rules

INSERT INTO compatibility (donor_type_id, recipient_type_id) VALUES
('BT001', 'BT001'),
('BT001', 'BT005'),
('BT002', 'BT001'),
('BT002', 'BT002'),
('BT002', 'BT005'),
('BT002', 'BT006'),
('BT003', 'BT003'),
('BT003', 'BT005'),
('BT004', 'BT003'),
('BT004', 'BT004'),
('BT004', 'BT005'),
('BT004', 'BT006'),
('BT005', 'BT005'),
('BT006', 'BT005'),
('BT006', 'BT006'),
('BT007', 'BT001'),
('BT007', 'BT003'),
('BT007', 'BT005'),
('BT007', 'BT007'),
('BT008', 'BT001'),
('BT008', 'BT002'),
('BT008', 'BT003'),
('BT008', 'BT004'),
('BT008', 'BT005'),
('BT008', 'BT006'),
('BT008', 'BT007'),
('BT008', 'BT008');


-- Deferrals

INSERT INTO deferral (deferralID, donorID, deferral_date, reason) VALUES
('DF001', 'D006', '2026-03-10', 'Recent vaccination'),
('DF002', 'D008', '2026-04-10', 'Recent tattoo'),
('DF003', 'D010', '2026-05-10', 'Recent illness'),
('DF004', 'D011', '2026-05-25', 'Low hemoglobin'),
('DF005', 'D013', '2026-06-25', 'Recent surgery'),
('DF006', 'D014', '2026-07-10', 'Medication'),
('DF007', 'D020', '2026-08-15', 'Failed mandatory screening test'),
('DF008', 'D022', '2026-08-15', 'Failed mandatory screening test'),
('DF009', 'D024', '2026-08-15', 'Failed mandatory screening test'),
('DF010', 'D026', '2026-08-15', 'Failed mandatory screening test');


-- Temporary deferrals

INSERT INTO temporarydeferral (tempDeferral_id, deferralID, endDate) VALUES
('TD001', 'DF001', '2026-08-20'),
('TD002', 'DF002', '2026-08-10'),
('TD003', 'DF003', '2026-09-15');


-- Tests

INSERT INTO test (Test_id, TestName) VALUES
('T001', 'HIV'),
('T002', 'Hepatitis B'),
('T003', 'Hepatitis C'),
('T004', 'Malaria'),
('T005', 'Syphilis'),
('T006', 'Blood Group Verification'),
('T007', 'Hemoglobin Level'),
('T008', 'General Infection');


-- Requests

INSERT INTO request (
    Request_id,
    BloodType,
    Priority,
    Status,
    RequestDate,
    Quantity,
    Hospital_id
) VALUES
('RQ001', 'BT001', 'High', 'Approved', '2026-05-20', 2, 'H001'),
('RQ002', 'BT003', 'Medium', 'Approved', '2026-05-25', 3, 'H002'),
('RQ003', 'BT005', 'High', 'Approved', '2026-03-20', 2, 'H006'),
('RQ004', 'BT007', 'Low', 'Approved', '2026-05-01', 1, 'H007'),
('RQ005', 'BT001', 'High', 'Approved', '2026-08-10', 1, 'H008'),
('RQ006', 'BT003', 'Medium', 'Approved', '2026-08-11', 1, 'H002'),
('RQ007', 'BT005', 'High', 'Approved', '2026-08-12', 1, 'H001'),
('RQ008', 'BT007', 'Medium', 'Pending', '2026-08-13', 2, 'H019'),
('RQ009', 'BT001', 'Low', 'Pending', '2026-08-14', 1, 'H007'),
('RQ010', 'BT002', 'High', 'Pending', '2026-08-16', 2, 'H001');


-- Screenings

INSERT INTO screening (
    Screening_id,
    ScreeningDate,
    StaffID,
    BloodUnitID,
    OverallStatus
) VALUES
('SC001', '2026-01-11', 'S025', 'BU001', 'Passed'),
('SC002', '2026-01-16', 'S028', 'BU004', 'Passed'),
('SC003', '2026-01-21', 'S033', 'BU012', 'Passed'),
('SC004', '2026-02-06', 'S031', 'BU007', 'Passed'),
('SC005', '2026-02-16', 'S032', 'BU010', 'Passed'),
('SC006', '2026-03-06', 'S034', 'BU015', 'Passed'),
('SC007', '2026-03-21', 'S035', 'BU016', 'Passed'),
('SC008', '2026-04-06', 'S036', 'BU017', 'Passed'),
('SC009', '2026-04-16', 'S025', 'BU002', 'Passed'),
('SC010', '2026-04-21', 'S037', 'BU018', 'Passed'),
('SC011', '2026-04-21', 'S028', 'BU005', 'Passed'),
('SC012', '2026-04-26', 'S033', 'BU013', 'Passed'),
('SC013', '2026-05-06', 'S038', 'BU019', 'Passed'),
('SC014', '2026-05-11', 'S031', 'BU008', 'Passed'),
('SC015', '2026-05-21', 'S039', 'BU020', 'Passed'),
('SC016', '2026-05-21', 'S032', 'BU011', 'Passed'),
('SC017', '2026-06-06', 'S041', 'BU021', 'Passed'),
('SC021', '2026-07-21', 'S025', 'BU003', 'Passed'),
('SC022', '2026-07-26', 'S028', 'BU006', 'Passed'),
('SC024', '2026-08-02', 'S031', 'BU009', 'Passed'),
('SC025', '2026-07-31', 'S017', 'BU014', 'Passed'),
('SC026', '2026-08-15', 'S025', 'BU026', 'Passed'),
('SC027', '2026-08-15', 'S028', 'BU027', 'Passed'),
('SC028', '2026-08-15', 'S031', 'BU028', 'Failed'),
('SC029', '2026-08-15', 'S033', 'BU029', 'Passed'),
('SC030', '2026-08-15', 'S034', 'BU030', 'Failed'),
('SC031', '2026-08-15', 'S036', 'BU031', 'Passed'),
('SC032', '2026-08-15', 'S037', 'BU032', 'Failed'),
('SC033', '2026-08-15', 'S038', 'BU033', 'Passed'),
('SC034', '2026-08-15', 'S039', 'BU034', 'Failed'),
('SC035', '2026-08-15', 'S041', 'BU035', 'Passed');


-- Inventory

INSERT INTO inventory (inventory_id, bloodUnit_id, branch_id, status) VALUES
('I001', 'BU003', 'B001', 'Available'),
('I002', 'BU006', 'B002', 'Issued'),
('I003', 'BU009', 'B003', 'Issued'),
('I004', 'BU014', 'B005', 'Available'),
('I005', 'BU005', 'B002', 'Issued'),
('I006', 'BU008', 'B003', 'Issued'),
('I007', 'BU010', 'B004', 'Issued'),
('I008', 'BU002', 'B001', 'Issued'),
('I009', 'BU001', 'B001', 'Available'),
('I010', 'BU004', 'B002', 'Available'),
('I011', 'BU007', 'B003', 'Available'),
('I012', 'BU011', 'B004', 'Available'),
('I013', 'BU012', 'B005', 'Available'),
('I014', 'BU013', 'B005', 'Available'),
('I015', 'BU015', 'B006', 'Available'),
('I016', 'BU016', 'B007', 'Available'),
('I017', 'BU017', 'B008', 'Available'),
('I018', 'BU018', 'B009', 'Available'),
('I019', 'BU019', 'B010', 'Available'),
('I020', 'BU020', 'B011', 'Available'),
('I021', 'BU021', 'B012', 'Available'),
('I022', 'BU026', 'B001', 'Available'),
('I023', 'BU027', 'B002', 'Available'),
('I024', 'BU029', 'B004', 'Available'),
('I025', 'BU031', 'B006', 'Available'),
('I026', 'BU033', 'B008', 'Available'),
('I027', 'BU035', 'B010', 'Available');


-- Issuances

INSERT INTO issuance (
    Issuance_id,
    IssuedUnits,
    Request_id,
    IssueDate,
    StaffID
) VALUES
('IS001', 2.00, 'RQ001', '2026-05-20', 'S002'),
('IS002', 1.00, 'RQ002', '2026-05-25', 'S003'),
('IS003', 2.00, 'RQ003', '2026-03-20', 'S004'),
('IS004', 1.00, 'RQ004', '2026-05-01', 'S001'),
('IS005', 1.00, 'RQ005', '2026-08-14', 'S001'),
('IS006', 1.00, 'RQ006', '2026-08-15', 'S001');


-- Issued blood units

INSERT INTO issuedbloodunit (Issuance_id, bloodUnit_id) VALUES
('IS001', 'BU005'),
('IS002', 'BU008'),
('IS003', 'BU010'),
('IS004', 'BU002'),
('IS005', 'BU006'),
('IS006', 'BU009');


-- Users

INSERT INTO `user` (
    user_id,
    password_hash,
    user_type,
    staff_id,
    hospital_id
) VALUES
('U001', 'scrypt:32768:8:1$NyL3z1AdRMFDvfEj$8a2c43bc55c12aca0361dac124f14d3aacfd5c16e8c47ec9467523d95204119cb89dc361c88527b30dc596efdf255803941234e33abe04c9361c7a5ea00fb85a', 'staff', 'S001', NULL),
('U002', 'scrypt:32768:8:1$vxCLL3Ae5MhfEsn5$4e3f58cd7b1bdd86d165f6e17434ac8bf62dd4fc0553177cc9ff037196262a1d364d6ad99e442d0612f97adf55f83750857c2eb72ea2b70be18fa3797dcfc768', 'staff', 'S013', NULL),
('U003', 'scrypt:32768:8:1$1Gc6Yh4ISraCq4Mv$6ce3414e2dd42ff84753dbb89e272e802fad6fb93d8d48f27c1df3a5d9c02dc8eb2220d909e4d1b07da863705fdf2bbb49007acc52073e624478bd369f8af643', 'staff', 'S025', NULL),
('U004', 'scrypt:32768:8:1$YEfWy3pixET4sgTf$eda6bf545253a0b4661214639fba817cac3ad27787221796139cd998be08f1243ae671055d729873966395134e82b590e7fb8a9a5d3d25b6bf67ed3071e7ff36', 'hospital', NULL, 'H001');


-- Test results

INSERT INTO testresult (TestResultID, Screening_id, Test_id, Result) VALUES
('TR001', 'SC001', 'T001', 'Negative'),
('TR002', 'SC001', 'T002', 'Negative'),
('TR003', 'SC001', 'T003', 'Negative'),
('TR004', 'SC001', 'T004', 'Negative'),
('TR005', 'SC001', 'T005', 'Negative'),
('TR006', 'SC001', 'T006', 'Negative'),
('TR007', 'SC001', 'T007', 'Negative'),
('TR008', 'SC001', 'T008', 'Negative'),

('TR009', 'SC002', 'T001', 'Negative'),
('TR010', 'SC002', 'T002', 'Negative'),
('TR011', 'SC002', 'T003', 'Negative'),
('TR012', 'SC002', 'T004', 'Negative'),
('TR013', 'SC002', 'T005', 'Negative'),
('TR014', 'SC002', 'T006', 'Negative'),
('TR015', 'SC002', 'T007', 'Negative'),
('TR016', 'SC002', 'T008', 'Negative'),

('TR017', 'SC003', 'T001', 'Negative'),
('TR018', 'SC003', 'T002', 'Negative'),
('TR019', 'SC003', 'T003', 'Negative'),
('TR020', 'SC003', 'T004', 'Negative'),
('TR021', 'SC003', 'T005', 'Negative'),
('TR022', 'SC003', 'T006', 'Negative'),
('TR023', 'SC003', 'T007', 'Negative'),
('TR024', 'SC003', 'T008', 'Negative'),

('TR025', 'SC004', 'T001', 'Negative'),
('TR026', 'SC004', 'T002', 'Negative'),
('TR027', 'SC004', 'T003', 'Negative'),
('TR028', 'SC004', 'T004', 'Negative'),
('TR029', 'SC004', 'T005', 'Negative'),
('TR030', 'SC004', 'T006', 'Negative'),
('TR031', 'SC004', 'T007', 'Negative'),
('TR032', 'SC004', 'T008', 'Negative'),

('TR033', 'SC005', 'T001', 'Negative'),
('TR034', 'SC005', 'T002', 'Negative'),
('TR035', 'SC005', 'T003', 'Negative'),
('TR036', 'SC005', 'T004', 'Negative'),
('TR037', 'SC005', 'T005', 'Negative'),
('TR038', 'SC005', 'T006', 'Negative'),
('TR039', 'SC005', 'T007', 'Negative'),
('TR040', 'SC005', 'T008', 'Negative'),

('TR041', 'SC006', 'T001', 'Negative'),
('TR042', 'SC006', 'T002', 'Negative'),
('TR043', 'SC006', 'T003', 'Negative'),
('TR044', 'SC006', 'T004', 'Negative'),
('TR045', 'SC006', 'T005', 'Negative'),
('TR046', 'SC006', 'T006', 'Negative'),
('TR047', 'SC006', 'T007', 'Negative'),
('TR048', 'SC006', 'T008', 'Negative'),

('TR049', 'SC007', 'T001', 'Negative'),
('TR050', 'SC007', 'T002', 'Negative'),
('TR051', 'SC007', 'T003', 'Negative'),
('TR052', 'SC007', 'T004', 'Negative'),
('TR053', 'SC007', 'T005', 'Negative'),
('TR054', 'SC007', 'T006', 'Negative'),
('TR055', 'SC007', 'T007', 'Negative'),
('TR056', 'SC007', 'T008', 'Negative'),

('TR057', 'SC008', 'T001', 'Negative'),
('TR058', 'SC008', 'T002', 'Negative'),
('TR059', 'SC008', 'T003', 'Negative'),
('TR060', 'SC008', 'T004', 'Negative'),
('TR061', 'SC008', 'T005', 'Negative'),
('TR062', 'SC008', 'T006', 'Negative'),
('TR063', 'SC008', 'T007', 'Negative'),
('TR064', 'SC008', 'T008', 'Negative'),

('TR065', 'SC009', 'T001', 'Negative'),
('TR066', 'SC009', 'T002', 'Negative'),
('TR067', 'SC009', 'T003', 'Negative'),
('TR068', 'SC009', 'T004', 'Negative'),
('TR069', 'SC009', 'T005', 'Negative'),
('TR070', 'SC009', 'T006', 'Negative'),
('TR071', 'SC009', 'T007', 'Negative'),
('TR072', 'SC009', 'T008', 'Negative'),

('TR073', 'SC010', 'T001', 'Negative'),
('TR074', 'SC010', 'T002', 'Negative'),
('TR075', 'SC010', 'T003', 'Negative'),
('TR076', 'SC010', 'T004', 'Negative'),
('TR077', 'SC010', 'T005', 'Negative'),
('TR078', 'SC010', 'T006', 'Negative'),
('TR079', 'SC010', 'T007', 'Negative'),
('TR080', 'SC010', 'T008', 'Negative'),

('TR081', 'SC011', 'T001', 'Negative'),
('TR082', 'SC011', 'T002', 'Negative'),
('TR083', 'SC011', 'T003', 'Negative'),
('TR084', 'SC011', 'T004', 'Negative'),
('TR085', 'SC011', 'T005', 'Negative'),
('TR086', 'SC011', 'T006', 'Negative'),
('TR087', 'SC011', 'T007', 'Negative'),
('TR088', 'SC011', 'T008', 'Negative'),

('TR089', 'SC012', 'T001', 'Negative'),
('TR090', 'SC012', 'T002', 'Negative'),
('TR091', 'SC012', 'T003', 'Negative'),
('TR092', 'SC012', 'T004', 'Negative'),
('TR093', 'SC012', 'T005', 'Negative'),
('TR094', 'SC012', 'T006', 'Negative'),
('TR095', 'SC012', 'T007', 'Negative'),
('TR096', 'SC012', 'T008', 'Negative'),

('TR097', 'SC013', 'T001', 'Negative'),
('TR098', 'SC013', 'T002', 'Negative'),
('TR099', 'SC013', 'T003', 'Negative'),
('TR100', 'SC013', 'T004', 'Negative'),
('TR101', 'SC013', 'T005', 'Negative'),
('TR102', 'SC013', 'T006', 'Negative'),
('TR103', 'SC013', 'T007', 'Negative'),
('TR104', 'SC013', 'T008', 'Negative'),

('TR105', 'SC014', 'T001', 'Negative'),
('TR106', 'SC014', 'T002', 'Negative'),
('TR107', 'SC014', 'T003', 'Negative'),
('TR108', 'SC014', 'T004', 'Negative'),
('TR109', 'SC014', 'T005', 'Negative'),
('TR110', 'SC014', 'T006', 'Negative'),
('TR111', 'SC014', 'T007', 'Negative'),
('TR112', 'SC014', 'T008', 'Negative'),

('TR113', 'SC015', 'T001', 'Negative'),
('TR114', 'SC015', 'T002', 'Negative'),
('TR115', 'SC015', 'T003', 'Negative'),
('TR116', 'SC015', 'T004', 'Negative'),
('TR117', 'SC015', 'T005', 'Negative'),
('TR118', 'SC015', 'T006', 'Negative'),
('TR119', 'SC015', 'T007', 'Negative'),
('TR120', 'SC015', 'T008', 'Negative'),

('TR121', 'SC016', 'T001', 'Negative'),
('TR122', 'SC016', 'T002', 'Negative'),
('TR123', 'SC016', 'T003', 'Negative'),
('TR124', 'SC016', 'T004', 'Negative'),
('TR125', 'SC016', 'T005', 'Negative'),
('TR126', 'SC016', 'T006', 'Negative'),
('TR127', 'SC016', 'T007', 'Negative'),
('TR128', 'SC016', 'T008', 'Negative'),

('TR129', 'SC017', 'T001', 'Negative'),
('TR130', 'SC017', 'T002', 'Negative'),
('TR131', 'SC017', 'T003', 'Negative'),
('TR132', 'SC017', 'T004', 'Negative'),
('TR133', 'SC017', 'T005', 'Negative'),
('TR134', 'SC017', 'T006', 'Negative'),
('TR135', 'SC017', 'T007', 'Negative'),
('TR136', 'SC017', 'T008', 'Negative'),

('TR137', 'SC021', 'T001', 'Negative'),
('TR138', 'SC021', 'T002', 'Negative'),
('TR139', 'SC021', 'T003', 'Negative'),
('TR140', 'SC021', 'T004', 'Negative'),
('TR141', 'SC021', 'T005', 'Negative'),
('TR142', 'SC021', 'T006', 'Negative'),
('TR143', 'SC021', 'T007', 'Negative'),
('TR144', 'SC021', 'T008', 'Negative'),

('TR145', 'SC022', 'T001', 'Negative'),
('TR146', 'SC022', 'T002', 'Negative'),
('TR147', 'SC022', 'T003', 'Negative'),
('TR148', 'SC022', 'T004', 'Negative'),
('TR149', 'SC022', 'T005', 'Negative'),
('TR150', 'SC022', 'T006', 'Negative'),
('TR151', 'SC022', 'T007', 'Negative'),
('TR152', 'SC022', 'T008', 'Negative'),

('TR153', 'SC024', 'T001', 'Negative'),
('TR154', 'SC024', 'T002', 'Negative'),
('TR155', 'SC024', 'T003', 'Negative'),
('TR156', 'SC024', 'T004', 'Negative'),
('TR157', 'SC024', 'T005', 'Negative'),
('TR158', 'SC024', 'T006', 'Negative'),
('TR159', 'SC024', 'T007', 'Negative'),
('TR160', 'SC024', 'T008', 'Negative'),

('TR161', 'SC025', 'T001', 'Negative'),
('TR162', 'SC025', 'T002', 'Negative'),
('TR163', 'SC025', 'T003', 'Negative'),
('TR164', 'SC025', 'T004', 'Negative'),
('TR165', 'SC025', 'T005', 'Negative'),
('TR166', 'SC025', 'T006', 'Negative'),
('TR167', 'SC025', 'T007', 'Negative'),
('TR168', 'SC025', 'T008', 'Negative'),

('TR169', 'SC002', 'T002', 'Negative'),

('TR170', 'SC026', 'T001', 'Negative'),
('TR171', 'SC026', 'T002', 'Negative'),
('TR172', 'SC026', 'T003', 'Negative'),
('TR173', 'SC026', 'T004', 'Negative'),
('TR174', 'SC026', 'T005', 'Negative'),
('TR175', 'SC026', 'T006', 'Negative'),
('TR176', 'SC026', 'T007', 'Negative'),
('TR177', 'SC026', 'T008', 'Negative'),

('TR178', 'SC027', 'T001', 'Negative'),
('TR179', 'SC027', 'T002', 'Negative'),
('TR180', 'SC027', 'T003', 'Negative'),
('TR181', 'SC027', 'T004', 'Negative'),
('TR182', 'SC027', 'T005', 'Negative'),
('TR183', 'SC027', 'T006', 'Negative'),
('TR184', 'SC027', 'T007', 'Negative'),
('TR185', 'SC027', 'T008', 'Negative'),

('TR186', 'SC028', 'T001', 'Positive'),
('TR187', 'SC028', 'T002', 'Negative'),
('TR188', 'SC028', 'T003', 'Negative'),
('TR189', 'SC028', 'T004', 'Negative'),
('TR190', 'SC028', 'T005', 'Negative'),
('TR191', 'SC028', 'T006', 'Negative'),
('TR192', 'SC028', 'T007', 'Negative'),
('TR193', 'SC028', 'T008', 'Negative'),

('TR194', 'SC029', 'T001', 'Negative'),
('TR195', 'SC029', 'T002', 'Negative'),
('TR196', 'SC029', 'T003', 'Negative'),
('TR197', 'SC029', 'T004', 'Negative'),
('TR198', 'SC029', 'T005', 'Negative'),
('TR199', 'SC029', 'T006', 'Negative'),
('TR200', 'SC029', 'T007', 'Negative'),
('TR201', 'SC029', 'T008', 'Negative'),

('TR202', 'SC030', 'T001', 'Negative'),
('TR203', 'SC030', 'T002', 'Positive'),
('TR204', 'SC030', 'T003', 'Negative'),
('TR205', 'SC030', 'T004', 'Negative'),
('TR206', 'SC030', 'T005', 'Negative'),
('TR207', 'SC030', 'T006', 'Negative'),
('TR208', 'SC030', 'T007', 'Negative'),
('TR209', 'SC030', 'T008', 'Negative'),

('TR210', 'SC031', 'T001', 'Negative'),
('TR211', 'SC031', 'T002', 'Negative'),
('TR212', 'SC031', 'T003', 'Negative'),
('TR213', 'SC031', 'T004', 'Negative'),
('TR214', 'SC031', 'T005', 'Negative'),
('TR215', 'SC031', 'T006', 'Negative'),
('TR216', 'SC031', 'T007', 'Negative'),
('TR217', 'SC031', 'T008', 'Negative'),

('TR218', 'SC032', 'T001', 'Negative'),
('TR219', 'SC032', 'T002', 'Negative'),
('TR220', 'SC032', 'T003', 'Negative'),
('TR221', 'SC032', 'T004', 'Negative'),
('TR222', 'SC032', 'T005', 'Positive'),
('TR223', 'SC032', 'T006', 'Negative'),
('TR224', 'SC032', 'T007', 'Negative'),
('TR225', 'SC032', 'T008', 'Negative'),

('TR226', 'SC033', 'T001', 'Negative'),
('TR227', 'SC033', 'T002', 'Negative'),
('TR228', 'SC033', 'T003', 'Negative'),
('TR229', 'SC033', 'T004', 'Negative'),
('TR230', 'SC033', 'T005', 'Negative'),
('TR231', 'SC033', 'T006', 'Negative'),
('TR232', 'SC033', 'T007', 'Negative'),
('TR233', 'SC033', 'T008', 'Negative'),

('TR234', 'SC034', 'T001', 'Negative'),
('TR235', 'SC034', 'T002', 'Negative'),
('TR236', 'SC034', 'T003', 'Negative'),
('TR237', 'SC034', 'T004', 'Positive'),
('TR238', 'SC034', 'T005', 'Negative'),
('TR239', 'SC034', 'T006', 'Negative'),
('TR240', 'SC034', 'T007', 'Negative'),
('TR241', 'SC034', 'T008', 'Negative'),

('TR242', 'SC035', 'T001', 'Negative'),
('TR243', 'SC035', 'T002', 'Negative'),
('TR244', 'SC035', 'T003', 'Negative'),
('TR245', 'SC035', 'T004', 'Negative'),
('TR246', 'SC035', 'T005', 'Negative'),
('TR247', 'SC035', 'T006', 'Negative'),
('TR248', 'SC035', 'T007', 'Negative'),
('TR249', 'SC035', 'T008', 'Negative');