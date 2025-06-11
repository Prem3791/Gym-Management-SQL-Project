
-- Gym Management System SQL Project

-- =========================
-- SCHEMA: Operational Tables
-- =========================

-- Table: Members
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    JoinDate DATE,
    MembershipType VARCHAR(50)
);

-- Table: Trainers
CREATE TABLE Trainers (
    TrainerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Expertise VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

-- Table: Equipment
CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY,
    EquipmentName VARCHAR(100),
    PurchaseDate DATE,
    MaintenanceDate DATE
);

-- Table: Sessions
CREATE TABLE Sessions (
    SessionID INT PRIMARY KEY,
    MemberID INT,
    TrainerID INT,
    SessionDate DATE,
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (TrainerID) REFERENCES Trainers(TrainerID)
);

-- Table: Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    MemberID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- =============================
-- STAR SCHEMA FOR DATA WAREHOUSE
-- =============================

-- Dimension: Member
CREATE TABLE Dim_Member (
    MemberID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Gender VARCHAR(10),
    Age INT,
    MembershipType VARCHAR(50)
);

-- Dimension: Trainer
CREATE TABLE Dim_Trainer (
    TrainerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Expertise VARCHAR(100)
);

-- Dimension: Time
CREATE TABLE Dim_Time (
    TimeID INT PRIMARY KEY,
    DateValue DATE,
    Month INT,
    Quarter INT,
    Year INT
);

-- Fact Table: SessionFact
CREATE TABLE Fact_Session (
    SessionID INT PRIMARY KEY,
    MemberID INT,
    TrainerID INT,
    TimeID INT,
    DurationMinutes INT,
    Revenue DECIMAL(10,2),
    FOREIGN KEY (MemberID) REFERENCES Dim_Member(MemberID),
    FOREIGN KEY (TrainerID) REFERENCES Dim_Trainer(TrainerID),
    FOREIGN KEY (TimeID) REFERENCES Dim_Time(TimeID)
);

-- ======================
-- Sample INSERTs (DML)
-- ======================

-- Insert into Members
INSERT INTO Members VALUES
(1, 'Ravi Kumar', 28, 'Male', '9999999999', 'ravi@email.com', '2024-01-01', 'Gold');

-- Insert into Trainers
INSERT INTO Trainers VALUES
(101, 'Anjali Singh', 'Weight Training', '8888888888', 'anjali@email.com');

-- Insert into Payments
INSERT INTO Payments VALUES
(5001, 1, 1500.00, '2024-01-05', 'Credit Card');
