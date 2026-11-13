USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'FailSafeIT_Database')
BEGIN
	ALTER DATABASE FailSafeIT_Database SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE FailSafeIT_Database;
END
GO

CREATE DATABASE FailSafeIT_Database;
GO

USE FailSafeIT_Database;
GO



CREATE TABLE Customers (
  Id INT IDENTITY (1,1) PRIMARY KEY,
  OrganizationNumber VARCHAR(20) NOT NULL UNIQUE,
  CompanyName NVARCHAR(100) NOT NULL,
  Email NVARCHAR(100) NOT NULL,
  PhoneNumber VARCHAR(30) NOT NULL
);

CREATE TABLE Consultants (
  Id INT IDENTITY (1,1) PRIMARY KEY,
  PersonalIdNumber VARCHAR(20) NOT NULL UNIQUE,
  FullName NVARCHAR(100) NOT NULL,
  HourlyRate DECIMAL(10,2) NOT NULL,
  Specialty NVARCHAR(100) NOT NULL
);

CREATE TABLE Assignments (
  Id INT IDENTITY (1,1) PRIMARY KEY,
  CustomerId INT NOT NULL FOREIGN KEY REFERENCES Customers(Id),
  ConsultantId INT NOT NULL FOREIGN KEY REFERENCES Consultants(Id),
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  RoleDescription NVARCHAR(255) NOT NULL
);
GO



INSERT INTO Customers (OrganizationNumber, CompanyName, Email, PhoneNumber)
VALUES
	('556123-4567', 'Nordic Tech Inc.', 'contact@nordictech.com', '+46 8 123 45 67'),
    ('556987-6543', 'SecureBank Group', 'info@securebank.com', '+46 8 987 65 43'),
    ('556456-7890', 'CloudSolutions Ltd.', 'hello@cloudsolutions.com', '+46 31 456 78 90'),
    ('556000-1111', 'Apex Logistics Corp.', 'info@apexlogistics.com', '+46 40 111 22 33');

INSERT INTO Consultants (PersonalIdNumber, FullName, HourlyRate, Specialty)
VALUES
	('19850412-1234', 'Anna Lindqvist', 1550.00, 'Cybersecurity'),
    ('19901123-5678', 'Erik Svensson', 1300.00, 'C# Developer'),
    ('19880705-9012', 'Sara Bergstrom', 1450.00, 'DevOps'),
    ('19930218-3456', 'Johan Ekstrom', 1200.00, 'Cloud Architect');

INSERT INTO Assignments (CustomerId, ConsultantId, StartDate, EndDate, RoleDescription)
VALUES
    (1, 1, '2026-09-01', '2026-10-31', 'API Security Audit'),
    (3, 2, '2026-09-15', '2026-12-15', '.NET Backend Development'),
    (3, 1, '2026-10-01', '2026-11-30', 'Web Portal Penetration Testing'),
    (2, 3, '2026-10-05', '2027-01-31', 'CI/CD Pipeline Implementation'),
    (1, 3, '2026-11-01', '2026-12-20', 'Azure Cloud Migration'),
    (3, 4, '2026-11-10', '2027-02-28', 'Cloud Infrastructure Architecture');
GO


-- A
SELECT FullName, HourlyRate
FROM Consultants
WHERE HourlyRate > 1200
ORDER BY HourlyRate DESC;
GO


-- B
SELECT cu.CompanyName, cons.FullName, a.StartDate, a.EndDate
FROM Assignments AS a
INNER JOIN Customers AS cu
    ON a.CustomerId = cu.Id
INNER JOIN Consultants AS cons
    ON a.ConsultantId = cons.Id
GO


-- C
SELECT cu.CompanyName,
    COUNT(a.Id) AS TotalAssignments
FROM Customers AS cu
LEFT JOIN Assignments AS a
    ON cu.Id = a.CustomerId
GROUP BY cu.Id, cu.CompanyName;
GO


-- D
UPDATE Consultants
SET HourlyRate = 1400
WHERE Id = 3
GO


-- E
DELETE FROM Customers
WHERE NOT EXISTS (
    SELECT 1
    FROM Assignments
    WHERE Assignments.CustomerId = Customers.Id
);
GO