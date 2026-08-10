

CREATE DATABASE IF NOT EXISTS bloodbank;
USE bloodbank;



CREATE TABLE BloodType(blood_type_id VARCHAR(5) PRIMARY KEY, abo_group CHAR(3) NOT NULL CHECK(abo_group IN ('A', 'B', 'AB','O')), rh_factor VARCHAR(10) NOT NULL CHECK(rh_factor IN ('Positive', 'Negative')), UNIQUE(abo_group,rh_factor)
);


CREATE TABLE Branch(branch_id VARCHAR(5) PRIMARY KEY, branchName VARCHAR(30), branchAddress VARCHAR(50), branchContact VARCHAR(15));


CREATE TABLE Hospital(Hospital_id VARCHAR(5) PRIMARY KEY, HospitalName VARCHAR(50) NOT NULL, Contact VARCHAR(15), 
    address VARCHAR(100) NOT NULL);


CREATE TABLE StaffRole(
    role_id VARCHAR(5) PRIMARY KEY,
    roleName VARCHAR(30) UNIQUE NOT NULL);


CREATE TABLE Test(
    Test_id VARCHAR(5) PRIMARY KEY,
    TestName VARCHAR(30) UNIQUE NOT NULL);






CREATE TABLE Donor(donor_id VARCHAR(5) PRIMARY KEY, donorFName VARCHAR(30), donorLName VARCHAR(30), DOB DATE NOT NULL, 
    gender CHAR(1) NOT NULL CHECK(gender IN ('M', 'F')), contact VARCHAR(15), email VARCHAR(50), 
    address VARCHAR(50), weight DECIMAL(5,2), blood_type_id VARCHAR(5), FOREIGN KEY (blood_type_id) REFERENCES BloodType(blood_type_id)
); 


CREATE TABLE Deferral( deferralID VARCHAR(5) PRIMARY KEY, donorID VARCHAR(5) NOT NULL, deferral_date DATE NOT NULL, reason VARCHAR(100), FOREIGN KEY (donorID) REFERENCES Donor(donor_id) ); 

CREATE TABLE TemporaryDeferral( tempDeferral_id VARCHAR(5) PRIMARY KEY, deferralID VARCHAR(5) NOT NULL, endDate DATE NOT NULL, FOREIGN KEY (deferralID) REFERENCES Deferral(deferralID) ); 


CREATE TABLE Staff(staff_id VARCHAR(5) PRIMARY KEY, staffFName VARCHAR(30), staffLName VARCHAR(30),
    staffType VARCHAR(20) NOT NULL, branchID VARCHAR(5) NOT NULL, role_id VARCHAR(5) NOT NULL,
    FOREIGN KEY (branchID) REFERENCES Branch(branch_id),
    FOREIGN KEY (role_id) REFERENCES StaffRole(role_id)
);



CREATE TABLE Donation(donation_id VARCHAR(5) PRIMARY KEY, donor_id VARCHAR(5) NOT NULL, volume DECIMAL(5,2) NOT NULL, branch_id VARCHAR(5)  NOT NULL,
    DonationDate DATE NOT NULL,FOREIGN KEY (donor_id) REFERENCES Donor(donor_id),
FOREIGN KEY (branch_id ) REFERENCES Branch(branch_id )
);

CREATE TABLE BloodUnit(
    bloodUnit_id VARCHAR(5) PRIMARY KEY,
    donation_id VARCHAR(5) NOT NULL,
    blood_type_id VARCHAR(5),
    procurement_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    blood_vol DECIMAL(5,2) NOT NULL,

    FOREIGN KEY (donation_id)
        REFERENCES Donation(donation_id),

    FOREIGN KEY (blood_type_id)
        REFERENCES BloodType(blood_type_id)
);



CREATE TABLE Screening(Screening_id VARCHAR(5) PRIMARY KEY, ScreeningDate DATE NOT NULL, StaffID VARCHAR(5) NOT NULL, BloodUnitID VARCHAR(5) NOT NULL, 
    OverallStatus VARCHAR(20) NOT NULL CHECK(OverallStatus IN ('Pending','Passed', 'Failed')),
    FOREIGN KEY (StaffID) REFERENCES Staff(staff_id), FOREIGN KEY (BloodUnitID) REFERENCES BloodUnit(bloodUnit_id)
);


CREATE TABLE TestResult(
    TestResultID VARCHAR(5) PRIMARY KEY,Screening_id VARCHAR(5) NOT NULL, Test_id VARCHAR(5) NOT NULL,
    Result VARCHAR(10) CHECK(Result IN ('Positive','Negative')), 
    FOREIGN KEY(Screening_id) REFERENCES Screening(Screening_id), FOREIGN KEY(Test_id) REFERENCES Test(Test_id)

);

CREATE TABLE Request( Request_id VARCHAR(5) PRIMARY KEY, BloodType VARCHAR(5) NOT NULL, Priority VARCHAR(10) NOT NULL CHECK(Priority IN ('High', 'Medium', 'Low')),      Status VARCHAR(20) NOT NULL CHECK(Status IN ('Pending', 'Approved', 'Rejected')), RequestDate DATE NOT NULL, Quantity INT NOT NULL, Hospital_id VARCHAR(5) NOT NULL, FOREIGN KEY (Hospital_id) REFERENCES Hospital(Hospital_id),FOREIGN KEY (BloodType) REFERENCES BloodType(blood_type_id) ); 


CREATE TABLE Inventory( inventory_id VARCHAR(5) PRIMARY KEY, bloodUnit_id VARCHAR(5) NOT NULL, branch_id VARCHAR(5) NOT NULL, status VARCHAR(20) NOT NULL CHECK (status IN ('Available', 'Reserved', 'Issued', 'Expired')), FOREIGN KEY (bloodUnit_id) REFERENCES BloodUnit(bloodUnit_id), FOREIGN KEY (branch_id) REFERENCES Branch(branch_id) ); 


CREATE TABLE Issuance( Issuance_id VARCHAR(5) PRIMARY KEY, IssuedUnits DECIMAL(5,2) NOT NULL, Request_id VARCHAR(5) NOT NULL, IssueDate DATE NOT NULL, StaffID VARCHAR(5) NOT NULL, FOREIGN KEY (Request_id) REFERENCES Request(Request_id), FOREIGN KEY (StaffID) REFERENCES Staff(staff_id) ); 




CREATE TABLE IssuedBloodUnit(Issuance_id VARCHAR(5), bloodUnit_id VARCHAR(5), PRIMARY KEY(Issuance_id, bloodUnit_id ),
FOREIGN KEY(Issuance_id) REFERENCES Issuance(Issuance_id), FOREIGN KEY(bloodUnit_id ) REFERENCES BloodUnit(bloodUnit_id )
);


CREATE TABLE Compatibility (
    donor_type_id VARCHAR(5) NOT NULL,
    recipient_type_id VARCHAR(5) NOT NULL,
    PRIMARY KEY (donor_type_id, recipient_type_id),
    FOREIGN KEY (donor_type_id) REFERENCES BloodType(blood_type_id),
    FOREIGN KEY (recipient_type_id) REFERENCES BloodType(blood_type_id)
);








INSERT INTO BloodType (blood_type_id, abo_group, rh_factor) VALUES
('BT001', 'A', 'Positive'),
('BT002', 'A', 'Negative'),
('BT003', 'B', 'Positive'),
('BT004', 'B', 'Negative'),
('BT005', 'AB', 'Positive'),
('BT006', 'AB', 'Negative'),
('BT007', 'O', 'Positive'),
('BT008', 'O', 'Negative');



INSERT INTO Branch (branch_id, branchName, branchAddress, branchContact) VALUES
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




INSERT INTO Hospital (Hospital_id, HospitalName, Contact, address) VALUES 
('H001', 'Korle Bu Teaching Hospital', '0302703300', 'Guggisberg Avenue, Accra'), 
('H002', 'Komfo Anokye Teaching Hospital', '0322022301', 'Okomfo Anokye Road, Kumasi'), ('H003', 'Tamale Teaching Hospital', '0372022112', 'Education Ridge, Tamale'), 
('H004', 'Cape Coast Teaching Hospital', '0332132450', 'Kotokuraba Road, Cape Coast'), ('H005', 'Ho Teaching Hospital', '0362023101', 'Ho Municipality, Volta Region'), 
('H006', '37 Military Hospital', '0302771111', 'Liberation Road, Accra'), 
('H007', 'Ridge Hospital', '0302734500', 'Castle Road, Accra'), 
('H008', 'Tema General Hospital', '0303214100', 'Community 11, Tema'), 
('H009', 'Eastern Regional Hospital', '0342022456', 'Koforidua, Eastern Region'), 
('H010', 'Sunyani Regional Hospital', '0352021890', 'Sunyani, Bono Region'), 
('H011', 'Effia Nkwanta Regional Hospital', '0312022334', 'Takoradi, Western Region'), 
('H012', 'Bolgatanga Regional Hospital', '0382021540', 'Bolgatanga, Upper East Region'), ('H013', 'Wa Regional Hospital', '0392021345', 'Wa, Upper West Region'), 
('H014', 'Keta Municipal Hospital', '0362098765', 'Keta, Volta Region'), 
('H015', 'Dormaa Presbyterian Hospital', '0352123456', 'Dormaa Ahenkro, Bono Region'), ('H016', 'Holy Family Hospital', '0322099888', 'Techiman, Bono East Region'), 
('H017', 'St. Joseph Hospital', '0332099001', 'Koforidua, Eastern Region'), 
('H018', 'Agogo Presbyterian Hospital', '0322098760', 'Agogo, Ashanti Region'), 
('H019', 'Madina Polyclinic', '0302504321', 'Madina, Accra'), 
('H020', 'Ashaiman Polyclinic', '0302311122', 'Ashaiman, Greater Accra'), 
('H021', 'Kasoa Polyclinic', '0302398765', 'Kasoa, Central Region'), 
('H022', 'Winneba Municipal Hospital', '0332097654', 'Winneba, Central Region'), 
('H023', 'Obuasi Government Hospital', '0322095432', 'Obuasi, Ashanti Region'), 
('H024', 'Sogakope District Hospital', '0362087654', 'Sogakope, Volta Region'), 
('H025', 'Aflao Municipal Hospital', '0362076543', 'Aflao, Volta Region'); 




INSERT INTO StaffRole (role_id, roleName) VALUES
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





INSERT INTO Test (Test_id, TestName) VALUES
('T001', 'HIV'),
('T002', 'Hepatitis B'),
('T003', 'Hepatitis C'),
('T004', 'Malaria'),
('T005', 'Syphilis'),
('T006', 'Blood Group Verification'),
('T007', 'Hemoglobin Level'),
('T008', 'General Infection');







INSERT INTO Donor (donor_id, donorFName, donorLName, DOB, gender, contact, email, address, weight, blood_type_id) VALUES 
('D001', 'Kwame', 'Mensah', '1998-04-15', 'M', '0245010001', 'kwame.mensah@email.com', 'Accra', 72.50, 'BT007'), 
('D002', 'Ama', 'Boateng', '2000-08-22', 'F', '0245010002', 'ama.boateng@email.com', 'Kumasi', 61.20, 'BT001'), 
('D003', 'Kofi', 'Owusu', '1995-01-10', 'M', '0245010003', 'kofi.owusu@email.com', 'Cape Coast', 78.40, 'BT003'), 
('D004', 'Akosua', 'Asante', '1999-06-18', 'F', '0245010004', 'akosua.asante@email.com', 'Takoradi', 64.80, 'BT005'), 
('D005', 'Yaw', 'Ofori', '1997-12-05', 'M', '0245010005', 'yaw.ofori@email.com', 'Tema', 80.10, 'BT001'), 
('D006', 'Efua', 'Adjei', '2001-02-11', 'F', '0245010006', 'efua.adjei@email.com', 'Ho', 58.30, 'BT007'), 
('D007', 'Kojo', 'Antwi', '1996-09-30', 'M', '0245010007', 'kojo.antwi@email.com', 'Sunyani', 75.60, 'BT004'), 
('D008', 'Abena', 'Frimpong', '1998-07-19', 'F', '0245010008', 'abena.frimpong@email.com', 'Tamale', 66.70, 'BT003'), 
('D009', 'Nana', 'Boadu', '1994-03-14', 'M', '0245010009', 'nana.boadu@email.com', 'Koforidua', 82.40, 'BT002'), 
('D010', 'Mavis', 'Amoah', '2002-11-25', 'F', '0245010010', 'mavis.amoah@email.com', 'Kasoa', 60.90, 'BT007'), 
('D011', 'Daniel', 'Appiah', '1993-10-09', 'M', '0245010011', 'daniel.appiah@email.com', 'Accra', 84.20, 'BT005'), 
('D012', 'Grace', 'Arthur', '1997-05-17', 'F', '0245010012', 'grace.arthur@email.com', 'Tema', 62.10, 'BT001'), 
('D013', 'Michael', 'Nyarko', '1999-08-08', 'M', '0245010013', 'michael.nyarko@email.com', 'Ho', 76.30, 'BT007'), 
('D014', 'Patricia', 'Darko', '1998-01-21', 'F', '0245010014', 'patricia.darko@email.com', 'Takoradi', 59.50, 'BT006'), 
('D015', 'Emmanuel', 'Agyeman', '1995-11-02', 'M', '0245010015', 'emmanuel.agyeman@email.com', 'Kumasi', 79.80, 'BT003'), 
('D016', 'Linda', 'Ansah', '2000-04-12', 'F', '0245010016', 'linda.ansah@email.com', 'Cape Coast', 63.40, 'BT002'), 
('D017', 'Samuel', 'Baah', '1996-06-24', 'M', '0245010017', 'samuel.baah@email.com', 'Sunyani', 77.00, 'BT008'), 
('D018', 'Josephine', 'Owusuaa', '1999-09-27', 'F', '0245010018', 'josephine.owusuaa@email.com', 'Accra', 65.60, 'BT007'), 
('D019', 'Richard', 'Tetteh', '1994-02-16', 'M', '0245010019', 'richard.tetteh@email.com', 'Madina', 81.70, 'BT001'), 
('D020', 'Priscilla', 'Koranteng', '2001-12-01', 'F', '0245010020', 'priscilla.k@email.com', 'Ashaiman', 57.90, 'BT003'), 
('D021', 'Isaac', 'Acheampong', '1998-05-13', 'M', '0245010021', 'isaac.acheampong@email.com', 'Obuasi', 74.90, 'BT007'), 
('D022', 'Janet', 'Opoku', '1997-03-29', 'F', '0245010022', 'janet.opoku@email.com', 'Winneba', 61.80, 'BT004'), 
('D023', 'Felix', 'Kusi', '1995-07-06', 'M', '0245010023', 'felix.kusi@email.com', 'Bolgatanga', 83.10, 'BT005'), 
('D024', 'Evelyn', 'Sarpong', '2002-10-15', 'F', '0245010024', 'evelyn.sarpong@email.com', 'Wa', 60.30, 'BT001'), 
('D025', 'George', 'Addo', '1996-01-04', 'M', '0245010025', 'george.addo@email.com', 'Aflao', 78.90, 'BT007');



INSERT INTO Deferral (deferralID, donorID, deferral_date, reason) VALUES 
('DF001', 'D011', '2025-01-15', 'Low hemoglobin'), 
('DF002', 'D022', '2025-02-08', 'Recent tattoo'), 
('DF003', 'D013', '2025-02-20', 'Fever'), 
('DF004', 'D004', '2025-03-01', 'Recent surgery'), 
('DF005', 'D008', '2025-03-12', 'Under medication'), 
('DF006', 'D003', '2025-03-18', 'Pregnancy'),
('DF007', 'D002', '2025-03-01', 'Recent vaccination'),
('DF008', 'D004', '2025-04-15', 'Recent surgery'),
('DF009', 'D006', '2025-05-10', 'Recent illness'),
('DF010', 'D008', '2025-06-01', 'Recent tattoo'),
('DF011', 'D010', '2025-06-20', 'Recent antibiotic use'),
('DF012', 'D012', '2025-07-05', 'Low hemoglobin'),
('DF013', 'D014', '2025-08-01', 'Recent dental procedure'),
('DF014', 'D016', '2025-08-25', 'Recent travel to malaria-risk area'),
('DF015', 'D018', '2025-09-10', 'Temporary illness'),
('DF016', 'D020', '2025-10-05', 'Recent vaccination'),
('DF017', 'D022', '2025-10-30', 'Recent piercing'),
('DF018', 'D024', '2025-11-15', 'Under temporary medication');



INSERT INTO TemporaryDeferral(tempDeferral_id, deferralID, endDate) VALUES
('TD001', 'DF007', '2025-04-01'),
('TD002', 'DF008', '2025-05-15'),
('TD003', 'DF009', '2025-06-10'),
('TD004', 'DF010', '2025-07-01'),
('TD005', 'DF011', '2025-07-20'),
('TD006', 'DF012', '2025-08-05'),
('TD007', 'DF013', '2025-09-01'),
('TD008', 'DF014', '2025-09-25'),
('TD009', 'DF015', '2025-10-10'),
('TD010', 'DF016', '2025-11-05'),
('TD011', 'DF017', '2025-11-30'),
('TD012', 'DF018', '2025-12-15');


INSERT INTO Staff (staff_id, staffFName, staffLName, staffType, branchID, role_id) VALUES ('S001', 'Daniel', 'Mensah', 'Full-Time', 'B001', 'R005'), 
('S002', 'Ama', 'Boateng', 'Full-Time', 'B001', 'R001'), 
('S003', 'Kofi', 'Owusu', 'Full-Time', 'B002', 'R002'), 
('S004', 'Akosua', 'Asante', 'Part-Time', 'B002', 'R003'), 
('S005', 'Yaw', 'Ofori', 'Full-Time', 'B003', 'R004'), 
('S006', 'Efua', 'Adjei', 'Full-Time', 'B003', 'R006'), 
('S007', 'Kojo', 'Antwi', 'Contract', 'B004', 'R007'), 
('S008', 'Abena', 'Frimpong', 'Full-Time', 'B004', 'R001'), 
('S009', 'Nana', 'Boadu', 'Full-Time', 'B005', 'R008'), 
('S010', 'Mavis', 'Amoah', 'Part-Time', 'B005', 'R002'), 
('S011', 'Michael', 'Nyarko', 'Full-Time', 'B006', 'R005'), 
('S012', 'Grace', 'Arthur', 'Full-Time', 'B007', 'R003'), 
('S013', 'Samuel', 'Baah', 'Contract', 'B008', 'R009'), 
('S014', 'Patricia', 'Darko', 'Full-Time', 'B009', 'R010'), 
('S015', 'Emmanuel', 'Agyeman', 'Full-Time', 'B010', 'R004'), 
('S016', 'Linda', 'Ansah', 'Part-Time', 'B011', 'R006'), 
('S017', 'Isaac', 'Acheampong', 'Full-Time', 'B012', 'R002'), 
('S018', 'Janet', 'Opoku', 'Full-Time', 'B013', 'R001'), 
('S019', 'Felix', 'Kusi', 'Contract', 'B014', 'R007'), 
('S020', 'Evelyn', 'Sarpong', 'Full-Time', 'B015', 'R003'), 
('S021', 'George', 'Addo', 'Full-Time', 'B016', 'R008'), 
('S022', 'Priscilla', 'Koranteng', 'Part-Time', 'B017', 'R006'), 
('S023', 'Richard', 'Tetteh', 'Full-Time', 'B018', 'R004'), 
('S024', 'Josephine', 'Owusuaa', 'Full-Time', 'B019', 'R002'), 
('S025', 'Kwabena', 'Appiah', 'Full-Time', 'B020', 'R005'); 




INSERT INTO Donation (donation_id, donor_id, volume, branch_id, DonationDate) VALUES ('DN001', 'D001', 450.00, 'B001', '2025-01-10'), 
('DN002', 'D002', 350.00, 'B001', '2025-01-18'), 
('DN003', 'D003', 450.00, 'B002', '2025-02-02'), 
('DN004', 'D004', 450.00, 'B002', '2025-02-15'), 
('DN005', 'D005', 500.00, 'B003', '2025-02-28'), 
('DN006', 'D006', 350.00, 'B003', '2025-03-05'), 
('DN007', 'D007', 450.00, 'B004', '2025-03-18'), 
('DN008', 'D008', 450.00, 'B004', '2025-03-29'), 
('DN009', 'D009', 500.00, 'B005', '2025-04-09'), 
('DN010', 'D010', 350.00, 'B005', '2025-04-22'), 
('DN011', 'D011', 450.00, 'B006', '2025-05-03'), 
('DN012', 'D012', 450.00, 'B007', '2025-05-17'), 
('DN013', 'D013', 500.00, 'B008', '2025-05-29'), 
('DN014', 'D014', 350.00, 'B009', '2025-06-11'), 
('DN015', 'D015', 450.00, 'B010', '2025-06-24'), 
('DN016', 'D016', 450.00, 'B011', '2025-07-06'), 
('DN017', 'D017', 500.00, 'B012', '2025-07-19'), 
('DN018', 'D018', 350.00, 'B013', '2025-08-01'), 
('DN019', 'D019', 450.00, 'B014', '2025-08-15'), 
('DN020', 'D020', 450.00, 'B015', '2025-08-27'), 
('DN021', 'D021', 500.00, 'B016', '2025-09-10'), 
('DN022', 'D022', 350.00, 'B017', '2025-09-24'), 
('DN023', 'D023', 450.00, 'B018', '2025-10-08'), 
('DN024', 'D024', 450.00, 'B019', '2025-10-21'), 
('DN025', 'D025', 500.00, 'B020', '2025-11-04');  




INSERT INTO BloodUnit
(bloodUnit_id, donation_id, blood_type_id, procurement_date, expiry_date, blood_vol)
VALUES
('BU001', 'DN001', 'BT007', '2025-01-10', '2025-02-21', 450.00),
('BU002', 'DN002', 'BT001', '2025-01-18', '2025-03-01', 350.00),
('BU003', 'DN003', 'BT003', '2025-02-02', '2025-03-16', 450.00),
('BU004', 'DN004', 'BT005', '2025-02-15', '2025-03-29', 450.00),
('BU005', 'DN005', 'BT001', '2025-02-28', '2025-04-11', 500.00),
('BU006', 'DN006', 'BT007', '2025-03-05', '2025-04-16', 350.00),
('BU007', 'DN007', 'BT004', '2025-03-18', '2025-04-29', 450.00),
('BU008', 'DN008', 'BT003', '2025-03-29', '2025-05-10', 450.00),
('BU009', 'DN009', 'BT002', '2025-04-09', '2025-05-21', 500.00),
('BU010', 'DN010', 'BT007', '2025-04-22', '2025-06-03', 350.00),
('BU011', 'DN011', 'BT005', '2025-05-03', '2025-06-14', 450.00),
('BU012', 'DN012', 'BT001', '2025-05-17', '2025-06-28', 450.00),
('BU013', 'DN013', 'BT007', '2025-05-29', '2025-07-10', 500.00),
('BU014', 'DN014', 'BT006', '2025-06-11', '2025-07-23', 350.00),
('BU015', 'DN015', 'BT003', '2025-06-24', '2025-08-05', 450.00),
('BU016', 'DN016', 'BT002', '2025-07-06', '2025-08-17', 450.00),
('BU017', 'DN017', 'BT008', '2025-07-19', '2025-08-30', 500.00),
('BU018', 'DN018', 'BT007', '2025-08-01', '2025-09-12', 350.00),
('BU019', 'DN019', 'BT001', '2025-08-15', '2025-09-26', 450.00),
('BU020', 'DN020', 'BT003', '2025-08-27', '2025-10-08', 450.00),
('BU021', 'DN021', 'BT007', '2025-09-10', '2025-10-22', 500.00),
('BU022', 'DN022', 'BT004', '2025-09-24', '2025-11-05', 350.00),
('BU023', 'DN023', 'BT005', '2025-10-08', '2025-11-19', 450.00),
('BU024', 'DN024', 'BT001', '2025-10-21', '2025-12-02', 450.00),
('BU025', 'DN025', 'BT007', '2025-11-04', '2025-12-16', 500.00);


INSERT INTO Screening (Screening_id, ScreeningDate, StaffID, BloodUnitID, OverallStatus) VALUES 
('SC001', '2025-01-11', 'S002', 'BU001', 'Passed'), 
('SC002', '2025-01-19', 'S003', 'BU002', 'Passed'), 
('SC003', '2025-02-03', 'S005', 'BU003', 'Passed'), 
('SC004', '2025-02-16', 'S008', 'BU004', 'Passed'), 
('SC005', '2025-03-01', 'S009', 'BU005', 'Failed'), 
('SC006', '2025-03-06', 'S011', 'BU006', 'Passed'), 
('SC007', '2025-03-19', 'S012', 'BU007', 'Passed'), 
('SC008', '2025-03-30', 'S015', 'BU008', 'Passed'), 
('SC009', '2025-04-10', 'S017', 'BU009', 'Passed'), 
('SC010', '2025-04-23', 'S018', 'BU010', 'Failed'), 
('SC011', '2025-05-04', 'S020', 'BU011', 'Passed'), 
('SC012', '2025-05-18', 'S021', 'BU012', 'Passed'), 
('SC013', '2025-05-30', 'S023', 'BU013', 'Passed'), 
('SC014', '2025-06-12', 'S024', 'BU014', 'Failed'), 
('SC015', '2025-06-25', 'S025', 'BU015', 'Passed'), 
('SC016', '2025-07-07', 'S002', 'BU016', 'Passed'), 
('SC017', '2025-07-20', 'S003', 'BU017', 'Passed'), 
('SC018', '2025-08-02', 'S005', 'BU018', 'Pending'), 
('SC019', '2025-08-16', 'S008', 'BU019', 'Passed'), 
('SC020', '2025-08-28', 'S009', 'BU020', 'Passed'), 
('SC021', '2025-09-11', 'S011', 'BU021', 'Failed'), 
('SC022', '2025-09-25', 'S012', 'BU022', 'Passed'), 
('SC023', '2025-10-09', 'S015', 'BU023', 'Passed'), 
('SC024', '2025-10-22', 'S017', 'BU024', 'Passed'), 
('SC025', '2025-11-05', 'S018', 'BU025', 'Passed'); 




INSERT INTO TestResult (TestResultID, Screening_id, Test_id, Result) VALUES 
('TR001', 'SC001', 'T001', 'Negative'), 
('TR002', 'SC001', 'T002', 'Negative'), 
('TR003', 'SC002', 'T003', 'Negative'), 
('TR004', 'SC002', 'T004', 'Negative'), 
('TR005', 'SC003', 'T001', 'Negative'), 
('TR006', 'SC003', 'T005', 'Negative'), 
('TR007', 'SC004', 'T002', 'Negative'), 
('TR008', 'SC004', 'T006', 'Positive'), 
('TR009', 'SC005', 'T001', 'Positive'), 
('TR010', 'SC006', 'T003', 'Negative'), 
('TR011', 'SC007', 'T004', 'Negative'), 
('TR012', 'SC008', 'T005', 'Negative'), 
('TR013', 'SC009', 'T001', 'Negative'), 
('TR014', 'SC009', 'T002', 'Negative'), 
('TR015', 'SC010', 'T003', 'Positive'), 
('TR016', 'SC011', 'T006', 'Positive'), 
('TR017', 'SC012', 'T007', 'Positive'), 
('TR018', 'SC013', 'T008', 'Negative'), 
('TR019', 'SC014', 'T001', 'Negative'), 
('TR020', 'SC015', 'T002', 'Negative'), 
('TR021', 'SC016', 'T003', 'Negative'), 
('TR022', 'SC017', 'T004', 'Negative'), 
('TR023', 'SC018', 'T005', 'Negative'), 
('TR024', 'SC019', 'T001', 'Negative'), 
('TR025', 'SC020', 'T002', 'Negative'), 
('TR026', 'SC021', 'T006', 'Positive'), 
('TR027', 'SC022', 'T007', 'Positive'), 
('TR028', 'SC023', 'T008', 'Negative'), 
('TR029', 'SC024', 'T001', 'Negative'), 
('TR030', 'SC025', 'T003', 'Negative'); 


INSERT INTO Request (Request_id, BloodType, Priority, Status, RequestDate, Quantity, Hospital_id) VALUES 
('RQ001', 'BT007', 'High', 'Approved', '2025-01-12', 4, 'H001'), 
('RQ002', 'BT001', 'Medium', 'Approved', '2025-01-20', 2, 'H002'), 
('RQ003', 'BT003', 'High', 'Pending', '2025-02-03', 6, 'H003'), 
('RQ004', 'BT005', 'Low', 'Approved', '2025-02-11', 1, 'H004'), 
('RQ005', 'BT002', 'Medium', 'Rejected', '2025-02-24', 3, 'H005'), 
('RQ006', 'BT007', 'High', 'Approved', '2025-03-08', 8, 'H006'), 
('RQ007', 'BT004', 'Medium', 'Pending', '2025-03-19', 2, 'H007'), 
('RQ008', 'BT001', 'Low', 'Approved', '2025-03-30', 1, 'H008'), 
('RQ009', 'BT008', 'High', 'Approved', '2025-04-10', 5, 'H009'), 
('RQ010', 'BT003', 'Medium', 'Pending', '2025-04-22', 4, 'H010'), 
('RQ011', 'BT005', 'Low', 'Approved', '2025-05-02', 2, 'H011'), 
('RQ012', 'BT007', 'High', 'Approved', '2025-05-14', 7, 'H012'), 
('RQ013', 'BT006', 'Medium', 'Rejected', '2025-05-27', 1, 'H013'), 
('RQ014', 'BT002', 'Low', 'Approved', '2025-06-09', 2, 'H014'), 
('RQ015', 'BT001', 'High', 'Pending', '2025-06-20', 5, 'H015'), 
('RQ016', 'BT007', 'High', 'Approved', '2025-07-04', 6, 'H016'), 
('RQ017', 'BT003', 'Medium', 'Approved', '2025-07-18', 3, 'H017'), 
('RQ018', 'BT004', 'Low', 'Pending', '2025-08-01', 2, 'H018'), 
('RQ019', 'BT005', 'Medium', 'Approved', '2025-08-15', 4, 'H019'), 
('RQ020', 'BT001', 'High', 'Approved', '2025-09-03', 5, 'H020'), 
('RQ021', 'BT007', 'Medium', 'Pending', '2025-09-18', 3, 'H021'), 
('RQ022', 'BT008', 'High', 'Approved', '2025-10-02', 2, 'H022'), 
('RQ023', 'BT002', 'Low', 'Rejected', '2025-10-19', 1, 'H023'), 
('RQ024', 'BT006', 'Medium', 'Approved', '2025-11-05', 2, 'H024'), 
('RQ025', 'BT003', 'High', 'Pending', '2025-11-22', 4, 'H025'); 

INSERT INTO Inventory
(inventory_id, bloodUnit_id, branch_id, status)
VALUES
('I001', 'BU001', 'B001', 'Issued'),
('I002', 'BU002', 'B001', 'Issued'),
('I003', 'BU003', 'B002', 'Available'),
('I004', 'BU004', 'B002', 'Issued'),
('I005', 'BU005', 'B003', 'Expired'),
('I006', 'BU006', 'B003', 'Available'),
('I007', 'BU007', 'B004', 'Issued'),
('I008', 'BU008', 'B004', 'Issued'),
('I009', 'BU009', 'B005', 'Issued'),
('I010', 'BU010', 'B005', 'Expired'),
('I011', 'BU011', 'B006', 'Issued'),
('I012', 'BU012', 'B007', 'Issued'),
('I013', 'BU013', 'B008', 'Issued'),
('I014', 'BU014', 'B009', 'Expired'),
('I015', 'BU015', 'B010', 'Issued'),
('I016', 'BU016', 'B011', 'Available'),
('I017', 'BU017', 'B012', 'Issued'),
('I018', 'BU018', 'B013', 'Available'),
('I019', 'BU019', 'B014', 'Issued'),
('I020', 'BU020', 'B015', 'Issued'),
('I021', 'BU021', 'B016', 'Expired'),
('I022', 'BU022', 'B017', 'Available'),
('I023', 'BU023', 'B018', 'Issued'),
('I024', 'BU024', 'B019', 'Issued'),
('I025', 'BU025', 'B020', 'Issued');

INSERT INTO Issuance
(Issuance_id, IssuedUnits, Request_id, IssueDate, StaffID)
VALUES
('IS001', 1.00, 'RQ001', '2025-01-13', 'S001'),
('IS002', 1.00, 'RQ002', '2025-01-21', 'S002'),
('IS003', 1.00, 'RQ004', '2025-02-13', 'S004'),
('IS004', 2.00, 'RQ006', '2025-03-10', 'S006'),
('IS005', 1.00, 'RQ008', '2025-04-01', 'S008'),
('IS006', 2.00, 'RQ009', '2025-04-12', 'S009'),
('IS007', 1.00, 'RQ011', '2025-05-04', 'S011'),
('IS008', 2.00, 'RQ012', '2025-05-16', 'S012'),
('IS009', 1.00, 'RQ014', '2025-06-11', 'S014'),
('IS010', 2.00, 'RQ016', '2025-07-06', 'S016'),
('IS011', 1.00, 'RQ017', '2025-07-20', 'S017'),
('IS012', 1.00, 'RQ019', '2025-08-17', 'S019'),
('IS013', 1.00, 'RQ020', '2025-09-05', 'S020'),
('IS014', 1.00, 'RQ022', '2025-10-04', 'S022'),
('IS015', 1.00, 'RQ024', '2025-11-07', 'S024');


INSERT INTO IssuedBloodUnit
(Issuance_id, bloodUnit_id)
VALUES
('IS001', 'BU001'),
('IS002', 'BU002'),
('IS003', 'BU004'),
('IS004', 'BU007'),
('IS004', 'BU008'),
('IS005', 'BU010'),
('IS006', 'BU011'),
('IS006', 'BU012'),
('IS007', 'BU013'),
('IS008', 'BU015'),
('IS008', 'BU016'),
('IS009', 'BU017'),
('IS010', 'BU019'),
('IS010', 'BU020'),
('IS011', 'BU021'),
('IS012', 'BU023'),
('IS013', 'BU024'),
('IS014', 'BU025'),
('IS015', 'BU018');



INSERT INTO Compatibility
(donor_type_id, recipient_type_id)
VALUES
-- O Negative
('BT008', 'BT008'),
('BT008', 'BT007'),
('BT008', 'BT004'),
('BT008', 'BT003'),
('BT008', 'BT002'),
('BT008', 'BT001'),
('BT008', 'BT006'),
('BT008', 'BT005'),

-- O Positive
('BT007', 'BT007'),
('BT007', 'BT005'),
('BT007', 'BT003'),
('BT007', 'BT001'),

-- A Negative
('BT002', 'BT002'),
('BT002', 'BT001'),
('BT002', 'BT006'),
('BT002', 'BT005'),

-- A Positive
('BT001', 'BT001'),
('BT001', 'BT005'),

-- B Negative
('BT004', 'BT004'),
('BT004', 'BT003'),
('BT004', 'BT006'),
('BT004', 'BT005'),

-- B Positive
('BT003', 'BT003'),
('BT003', 'BT005'),

-- AB Negative
('BT006', 'BT006'),
('BT006', 'BT005'),

-- AB Positive
('BT005', 'BT005');


DELIMITER //
CREATE FUNCTION fn_DaysBetween(start_date DATE, end_date DATE) RETURNS INT DETERMINISTIC BEGIN RETURN DATEDIFF(end_date, start_date); END//
DELIMITER ;



DELIMITER //

CREATE FUNCTION fn_HasActiveDeferral(p_donor_id VARCHAR(5))
RETURNS TINYINT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_count INT DEFAULT 0; 

    SELECT COUNT(*) INTO v_count
    FROM Deferral df
    LEFT JOIN TemporaryDeferral td ON df.deferralID = td.deferralID
    WHERE df.donorID = p_donor_id
      AND (td.tempDeferral_id IS NULL OR td.endDate > CURDATE());

    IF v_count > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END //

DELIMITER ;



CREATE VIEW vw_CompatibleAvailableUnits AS
SELECT r.Request_id, bu.bloodUnit_id, bt.abo_group, bt.rh_factor, bu.expiry_date,   bu.blood_vol, br.branchName
FROM Request r
JOIN Compatibility c ON c.recipient_type_id = r.BloodType
JOIN BloodUnit bu ON bu.blood_type_id = c.donor_type_id
JOIN Inventory inv ON inv.bloodUnit_id = bu.bloodUnit_id
JOIN BloodType bt ON bu.blood_type_id = bt.blood_type_id
JOIN Branch br ON inv.branch_id = br.branch_id
WHERE inv.status = 'Available'
  AND bu.expiry_date > CURDATE() AND r.Status = 'Pending';


CREATE VIEW vw_AvailableInventory AS
SELECT br.branch_id, br.branchName, bt.blood_type_id, bt.abo_group, bt.rh_factor, COUNT(*) AS total_available
FROM Inventory inv
JOIN Branch br ON inv.branch_id = br.branch_id
JOIN BloodUnit bu ON inv.bloodUnit_id = bu.bloodUnit_id
JOIN BloodType bt ON bu.blood_type_id = bt.blood_type_id
WHERE inv.status = 'Available'
GROUP BY br.branch_id, br.branchName, bt.blood_type_id, bt.abo_group, bt.rh_factor;


CREATE VIEW vw_EligibleDonors AS
SELECT  d.donor_id, d.donorFName, d.donorLName, MAX(dn.DonationDate) AS last_donation_date
FROM Donor d
LEFT JOIN Donation dn ON d.donor_id = dn.donor_id

LEFT JOIN (
    SELECT DISTINCT df.donorID
    FROM Deferral df
    LEFT JOIN TemporaryDeferral td ON df.deferralID = td.deferralID
    WHERE td.tempDeferral_id IS NULL  OR td.endDate > CURDATE()
) AS active_def ON d.donor_id = active_def.donorID

WHERE active_def.donorID IS NULL

GROUP BY  d.donor_id, d.donorFName, d.donorLName

HAVING MAX(dn.DonationDate) IS NULL OR MAX(dn.DonationDate) <= DATE_SUB(CURDATE(), INTERVAL 56 DAY);



CREATE VIEW PendingRequests AS 
SELECT r.Request_id, h.HospitalName, bt.abo_group, bt.rh_factor, 
r.Quantity, r.Priority, r.RequestDate, 
fn_DaysBetween(r.RequestDate, CURDATE()) AS days_outstanding 
FROM Request as r 
JOIN Hospital as h ON r.Hospital_id = h.Hospital_id 
JOIN BloodType as bt ON r.BloodType = bt.blood_type_id 
WHERE r.Status = 'Pending' 
ORDER BY r.RequestDate ASC; 


CREATE VIEW vw_ScreeningStatus AS 
SELECT bu.bloodUnit_id, br.branchName, sc.Screening_id, sc.ScreeningDate, 
sc.OverallStatus, fn_DaysBetween(sc.ScreeningDate, CURDATE()) AS
days_since_screening_started, t.TestName, tr.Result 
FROM BloodUnit as bu 
JOIN Screening as sc ON sc.BloodUnitID = bu.bloodUnit_id 
JOIN Donation as dn ON bu.donation_id = dn.donation_id 
JOIN Staff as st ON sc.StaffID = st.staff_id 
JOIN Branch as br ON st.branchID = br.branch_id 
CROSS JOIN Test as t 
LEFT JOIN TestResult as tr ON tr.Screening_id = sc.Screening_id AND tr.Test_id = t.Test_id WHERE sc.OverallStatus IN ('Pending', 'Failed') 
ORDER BY sc.ScreeningDate ASC, bu.bloodUnit_id; 









DELIMITER //
CREATE TRIGGER trg_CheckDeferralBeforeDonation 
BEFORE INSERT ON Donation 
FOR EACH ROW 
BEGIN
IF fn_HasActiveDeferral(NEW.donor_id) = 1 
THEN SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Donor currently has an active deferral! Donation blocked'; 
END IF; 
END //
DELIMITER ; 



DELIMITER //

CREATE TRIGGER trg_CheckRecencyBeforeDonation
BEFORE INSERT ON Donation
FOR EACH ROW
BEGIN
    DECLARE v_last_donation DATE;

    SELECT MAX(DonationDate) INTO v_last_donation
    FROM Donation WHERE donor_id = NEW.donor_id;

    IF v_last_donation IS NOT NULL
       AND fn_DaysBetween(v_last_donation, CURDATE()) < 56 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Donor has not waited long enough since last donation';
    END IF;
END //


DELIMITER ;



DELIMITER //

CREATE TRIGGER trg_UpdateScreeningStatus
AFTER INSERT ON TestResult
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

END //

DELIMITER ;



DELIMITER //

CREATE TRIGGER trg_AutoDeferOnFailedScreening
AFTER UPDATE ON Screening
FOR EACH ROW
BEGIN
    DECLARE v_donor_id VARCHAR(5);

    IF NEW.OverallStatus = 'Failed' AND OLD.OverallStatus <> 'Failed' THEN
        SELECT d.donor_id INTO v_donor_id
        FROM BloodUnit bu
        JOIN Donation dn ON bu.donation_id = dn.donation_id
        JOIN Donor d ON dn.donor_id = d.donor_id
        WHERE bu.bloodUnit_id = NEW.BloodUnitID;

        INSERT INTO Deferral (deferralID, donorID, deferral_date, reason)
        VALUES (CONCAT('DF', LPAD((SELECT COUNT(*) FROM Deferral) + 1, 3, '0')),
                v_donor_id, CURDATE(), 'Failed mandatory screening test');
    END IF;
END //


DELIMITER ;


DELIMITER //
CREATE TRIGGER trg_CheckCompatibilityBeforeIssue
BEFORE INSERT ON IssuedBloodUnit
FOR EACH ROW
BEGIN

    DECLARE unit_type VARCHAR(5);
    DECLARE request_type VARCHAR(5);
    DECLARE is_compatible INT;
    DECLARE unit_status VARCHAR(20);

    SELECT
        bu.blood_type_id
    INTO unit_type
    FROM BloodUnit bu
    WHERE bu.bloodUnit_id = NEW.bloodUnit_id;

    SELECT
        r.BloodType
    INTO request_type
    FROM Issuance i
    JOIN Request r
        ON i.Request_id = r.Request_id
    WHERE i.Issuance_id = NEW.Issuance_id;

    SELECT
        COUNT(*)
    INTO is_compatible
    FROM Compatibility
    WHERE donor_type_id = unit_type
      AND recipient_type_id = request_type;

    SELECT
        status
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

END //

DELIMITER ;



DELIMITER //

CREATE TRIGGER trg_SetUnitBloodType
BEFORE INSERT ON BloodUnit
FOR EACH ROW
BEGIN
    SELECT d.blood_type_id INTO @unit_type
    FROM Donation dn
    JOIN Donor d ON dn.donor_id = d.donor_id
    WHERE dn.donation_id = NEW.donation_id;

    SET NEW.blood_type_id = @unit_type;
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER trg_CheckBloodUnitBeforeInventory
BEFORE INSERT ON Inventory
FOR EACH ROW
BEGIN

    DECLARE v_status VARCHAR(20);
    DECLARE v_blood_type VARCHAR(5);

    SELECT
        OverallStatus
    INTO v_status
    FROM Screening
    WHERE BloodUnitID = NEW.bloodUnit_id;

    SELECT
        blood_type_id
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

END //

DELIMITER ;













DELIMITER //

CREATE PROCEDURE sp_RegisterDonation(
    IN p_donor_id VARCHAR(5),
    IN p_volume DECIMAL(5,2),
    IN p_branch_id VARCHAR(5)
)
BEGIN
    DECLARE v_donation_id VARCHAR(5);
    DECLARE v_unit_id VARCHAR(5);

    SET v_donation_id = CONCAT('DN', LPAD((SELECT COUNT(*)+1  FROM Donation), 3, '0'));
    SET v_unit_id = CONCAT('BU', LPAD((SELECT COUNT(*)+1 FROM BloodUnit), 3, '0'));

    INSERT INTO Donation (donation_id, donor_id, volume, DonationDate, branch_id)
    VALUES (v_donation_id, p_donor_id, p_volume, CURDATE(), p_branch_id);

    INSERT INTO BloodUnit (bloodUnit_id, donation_id, procurement_date, expiry_date, blood_vol)
    VALUES (v_unit_id, v_donation_id, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 42 DAY), p_volume);
END //

DELIMITER ;



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

DELIMITER ;





DELIMITER //

CREATE PROCEDURE sp_IssueBloodUnit(
    IN p_request_id VARCHAR(5),
    IN p_bloodUnit_id VARCHAR(5),
    IN p_staff_id VARCHAR(5)
)
BEGIN

    DECLARE v_issuance_id VARCHAR(5);
    START TRANSACTION;

    SET v_issuance_id = CONCAT( 'IS', LPAD((SELECT COUNT(*) + 1 FROM Issuance), 3, '0'));

    INSERT INTO Issuance (Issuance_id,Request_id,StaffID,IssueDate)
    VALUES ( v_issuance_id, p_request_id,p_staff_id,CURDATE() );

    INSERT INTO IssuedBloodUnit (Issuance_id,bloodUnit_id)
    VALUES ( v_issuance_id, p_bloodUnit_id);

    UPDATE Inventory
    SET status = 'Issued'
    WHERE bloodUnit_id = p_bloodUnit_id;

    COMMIT;

END //








