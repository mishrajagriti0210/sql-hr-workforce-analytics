-- ============================================
-- SQL MINI PROJECT 2: HR WORKFORCE ANALYTICS
-- Database: BA_HR_Project
-- Purpose: Analyze employee data, departments,
-- locations, salaries, performance, attendance
-- and workforce trends.
-- ============================================

CREATE DATABASE BA_HR_Project;

USE BA_HR_Project;

-- ============================================
-- 1. TABLE CREATION
-- ============================================

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Locations (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    LocationID INT,
    JobLevel VARCHAR(30),
    Gender VARCHAR(20),
    JoiningDate DATE,
    Salary DECIMAL(10,2),
    Status VARCHAR(20),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

CREATE TABLE Performance (
    PerformanceID INT PRIMARY KEY,
    EmployeeID INT,
    PerformanceRating DECIMAL(3,2),
    AttendancePercentage DECIMAL(5,2),
    ReviewYear INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- ============================================
-- 2. INSERTING SAMPLE DATA
-- ============================================

INSERT INTO Departments VALUES
(1,'IT'),
(2,'HR'),
(3,'Finance'),
(4,'Sales'),
(5,'Marketing'),
(6,'Operations');

INSERT INTO Locations VALUES
(1,'Delhi Office','Delhi'),
(2,'Mumbai Office','Mumbai'),
(3,'Bangalore Office','Bengaluru'),
(4,'Hyderabad Office','Hyderabad'),
(5,'Pune Office','Pune');

INSERT INTO Employees VALUES
(1,'Amit Sharma',1,1,'Senior','Male','2021-03-15',85000,'Active'),
(2,'Priya Singh',2,2,'Mid','Female','2022-06-10',62000,'Active'),
(3,'Rahul Verma',3,1,'Senior','Male','2020-01-20',92000,'Active'),
(4,'Neha Gupta',4,3,'Mid','Female','2023-04-12',68000,'Active'),
(5,'Arjun Mehta',5,4,'Junior','Male','2024-02-05',52000,'Active'),
(6,'Sneha Patel',6,5,'Senior','Female','2019-08-19',88000,'Active'),
(7,'Vikas Kumar',1,4,'Mid','Male','2022-11-11',72000,'Active'),
(8,'Riya Das',2,1,'Junior','Female','2024-07-01',48000,'Active'),
(9,'Karan Shah',3,2,'Mid','Male','2023-09-18',70000,'Active'),
(10,'Pooja Nair',4,3,'Senior','Female','2021-12-10',90000,'Active'),
(11,'Manish Rao',5,4,'Mid','Male','2022-03-21',65000,'Inactive'),
(12,'Anjali Joshi',6,5,'Junior','Female','2025-01-15',50000,'Active'),
(13,'Rohit Jain',1,1,'Junior','Male','2025-03-10',55000,'Active'),
(14,'Kavya Menon',4,3,'Mid','Female','2020-05-14',75000,'Active'),
(15,'Suresh Kumar',6,4,'Mid','Male','2023-06-22',68000,'Active'),
(16,'Meera Shah',5,2,'Senior','Female','2021-09-09',83000,'Active'),
(17,'Deepak Singh',3,1,'Junior','Male','2024-08-17',54000,'Inactive'),
(18,'Nisha Kapoor',2,5,'Senior','Female','2020-11-03',79000,'Active'),
(19,'Varun Gupta',1,4,'Senior','Male','2019-04-27',95000,'Active'),
(20,'Simran Kaur',4,3,'Junior','Female','2025-02-12',51000,'Active');

INSERT INTO Performance VALUES
(1,1,4.5,94,2026),
(2,2,3.8,91,2026),
(3,3,4.7,96,2026),
(4,4,3.9,89,2026),
(5,5,3.2,87,2026),
(6,6,4.6,95,2026),
(7,7,3.7,92,2026),
(8,8,3.5,90,2026),
(9,9,4.1,93,2026),
(10,10,4.8,97,2026),
(11,11,2.9,82,2026),
(12,12,3.6,88,2026),
(13,13,3.3,91,2026),
(14,14,4.2,94,2026),
(15,15,3.8,90,2026),
(16,16,4.4,96,2026),
(17,17,2.7,80,2026),
(18,18,4.3,93,2026),
(19,19,4.9,98,2026),
(20,20,3.4,86,2026);

-- ============================================
-- 3. DATA EXPLORATION
-- ============================================

SELECT * FROM Departments;

SELECT * FROM Locations;

SELECT * FROM Employees;

SELECT * FROM Performance;

SELECT COUNT(*) FROM Employees;

SELECT * 
FROM Employees 
WHERE Status = 'Active';

SELECT * 
FROM Employees 
WHERE Salary > 70000;

SELECT * 
FROM Employees 
WHERE JoiningDate > '2023-01-01';

SELECT * 
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
WHERE d.DepartmentName = 'Sales';

SELECT * 
FROM Employees 
WHERE JobLevel = 'Senior';

SELECT * 
FROM Employees 
WHERE Status = 'Inactive';

-- ============================================
-- 4. AGGREGATE FUNCTIONS
-- ============================================

SELECT COUNT(*) AS TotalEmployees 
FROM Employees;

SELECT COUNT(*) AS ActiveEmployees 
FROM Employees 
WHERE Status = 'Active';

SELECT COUNT(*) AS InactiveEmployees 
FROM Employees 
WHERE Status = 'Inactive';

SELECT SUM(Salary) AS TotalSalaryExpenditure 
FROM Employees;

SELECT AVG(Salary) AS AverageSalary 
FROM Employees;

SELECT MAX(Salary) AS HighestSalary 
FROM Employees;

SELECT MIN(Salary) AS LowestSalary 
FROM Employees;

-- ============================================
-- 5. GROUP BY AND HAVING
-- ============================================

SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount 
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
GROUP BY d.DepartmentName;

SELECT d.DepartmentName, AVG(e.Salary) AS AverageSalary 
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
GROUP BY d.DepartmentName;

SELECT JobLevel, COUNT(EmployeeID) AS EmployeeCount 
FROM Employees 
GROUP BY JobLevel;

SELECT Gender, COUNT(EmployeeID) AS EmployeeCount 
FROM Employees 
GROUP BY Gender;

SELECT l.City, COUNT(e.EmployeeID) AS EmployeeCount 
FROM Employees e 
JOIN Locations l ON e.LocationID = l.LocationID 
GROUP BY l.City;

SELECT l.City, AVG(e.Salary) AS AverageSalary 
FROM Employees e 
JOIN Locations l ON e.LocationID = l.LocationID 
GROUP BY l.City;

SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount 
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
GROUP BY d.DepartmentName 
HAVING COUNT(e.EmployeeID) > 2;

SELECT d.DepartmentName, AVG(e.Salary) AS AverageSalary 
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
GROUP BY d.DepartmentName 
HAVING AVG(e.Salary) > 70000;

SELECT l.City, COUNT(e.EmployeeID) AS EmployeeCount 
FROM Employees e 
JOIN Locations l ON e.LocationID = l.LocationID 
GROUP BY l.City 
HAVING COUNT(e.EmployeeID) > 3;

-- ============================================
-- 6. JOINS
-- ============================================

SELECT e.EmployeeName, d.DepartmentName, e.Salary 
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeName, d.DepartmentName, l.City, e.Salary 
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
JOIN Locations l ON e.LocationID = l.LocationID;

SELECT e.EmployeeName, p.PerformanceRating, p.AttendancePercentage 
FROM Employees e 
JOIN Performance p ON e.EmployeeID = p.EmployeeID;

SELECT e.EmployeeName, d.DepartmentName, p.PerformanceRating, p.AttendancePercentage 
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
JOIN Performance p ON e.EmployeeID = p.EmployeeID;

-- ============================================
-- 7. PERFORMANCE ANALYSIS 
-- ============================================

SELECT d.DepartmentName, AVG(p.PerformanceRating) AS AvgPerformance 
FROM Performance p 
JOIN Employees e ON p.EmployeeID = e.EmployeeID 
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
GROUP BY d.DepartmentName;

SELECT d.DepartmentName, AVG(p.AttendancePercentage) AS AvgAttendance 
FROM Performance p 
JOIN Employees e ON p.EmployeeID = e.EmployeeID 
JOIN Departments d ON e.DepartmentID = d.DepartmentID 
GROUP BY d.DepartmentName;

SELECT e.EmployeeName, p.PerformanceRating 
FROM Employees e 
JOIN Performance p ON e.EmployeeID = p.EmployeeID 
WHERE p.PerformanceRating > 4.0;

SELECT e.EmployeeName, p.AttendancePercentage 
FROM Employees e 
JOIN Performance p ON e.EmployeeID = p.EmployeeID 
WHERE p.AttendancePercentage < 90;

SELECT e.EmployeeName, p.PerformanceRating 
FROM Employees e 
JOIN Performance p ON e.EmployeeID = p.EmployeeID 
ORDER BY p.PerformanceRating DESC 
LIMIT 1;

SELECT EmployeeName, Salary 
FROM Employees 
ORDER BY Salary DESC 
LIMIT 1;

-- ============================================
-- 8. CASE STATEMENTS
-- ============================================

SELECT e.EmployeeName, p.PerformanceRating, 
       CASE 
           WHEN p.PerformanceRating >= 4.5 THEN 'Excellent' 
           WHEN p.PerformanceRating >= 4.0 THEN 'Very Good' 
           WHEN p.PerformanceRating >= 3.0 THEN 'Good' 
           ELSE 'Needs Improvement' 
       END AS PerformanceCategory 
FROM Employees e 
JOIN Performance p ON e.EmployeeID = p.EmployeeID;

SELECT EmployeeName, Salary, 
       CASE 
           WHEN Salary >= 90000 THEN 'High' 
           WHEN Salary >= 70000 THEN 'Medium' 
           ELSE 'Low' 
       END AS SalaryCategory 
FROM Employees;

SELECT e.EmployeeName, p.AttendancePercentage, 
       CASE 
           WHEN p.AttendancePercentage >= 95 THEN 'Excellent' 
           WHEN p.AttendancePercentage >= 90 THEN 'Good' 
           ELSE 'Needs Attention' 
       END AS AttendanceCategory 
FROM Employees e 
JOIN Performance p ON e.EmployeeID = p.EmployeeID;

-- ============================================
-- 9. SUBQUERIES
-- ============================================

SELECT EmployeeName, Salary 
FROM Employees 
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

SELECT e.EmployeeName, p.PerformanceRating 
FROM Employees e 
JOIN Performance p ON e.EmployeeID = p.EmployeeID 
WHERE p.PerformanceRating > (SELECT AVG(PerformanceRating) FROM Performance);

SELECT e.EmployeeName, e.DepartmentID, e.Salary 
FROM Employees e 
WHERE e.Salary > (
    SELECT AVG(Salary) 
    FROM Employees 
    WHERE DepartmentID = e.DepartmentID
);

-- ============================================
-- 10. COMMON TABLE EXPRESSIONS (CTEs)
-- ============================================

WITH DepartmentSummary AS (
    SELECT d.DepartmentName, 
           COUNT(e.EmployeeID) AS EmployeeCount, 
           AVG(e.Salary) AS AvgSalary 
    FROM Employees e 
    JOIN Departments d ON e.DepartmentID = d.DepartmentID 
    GROUP BY d.DepartmentName
)
SELECT * 
FROM DepartmentSummary 
WHERE AvgSalary > 70000;

WITH EmployeePerformance AS (
    SELECT e.EmployeeName, e.Salary, p.PerformanceRating
    FROM Employees e
    JOIN Performance p ON e.EmployeeID = p.EmployeeID
)
SELECT *
FROM EmployeePerformance
WHERE Salary > 70000 AND PerformanceRating > 4.0;

WITH DeptAvgPerformance AS (
    SELECT d.DepartmentName, AVG(p.PerformanceRating) AS DeptAvg 
    FROM Employees e 
    JOIN Departments d ON e.DepartmentID = d.DepartmentID 
    JOIN Performance p ON e.EmployeeID = p.EmployeeID 
    GROUP BY d.DepartmentName
)
SELECT * 
FROM DeptAvgPerformance
WHERE DeptAvg > (SELECT AVG(PerformanceRating) FROM Performance);

-- ============================================
-- 11. WINDOW FUNCTIONS
-- ============================================

SELECT EmployeeName, Salary, 
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank 
FROM Employees;

SELECT e.EmployeeName, p.PerformanceRating,
	   DENSE_RANK() OVER (ORDER BY p.PerformanceRating DESC) AS PerformanceRank
FROM Employees e
JOIN Performance p on e.EmployeeID = p.EmployeeID;

WITH RankedEmployees AS (
    SELECT e.EmployeeName, d.DepartmentName, e.Salary, 
           ROW_NUMBER() OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS RowNum 
    FROM Employees e 
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
)
SELECT EmployeeName, DepartmentName, Salary 
FROM RankedEmployees 
WHERE RowNum = 1;

SELECT e.EmployeeName, d.DepartmentName, e.Salary, 
       DENSE_RANK() OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS DeptSalaryRank 
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeName, d.DepartmentName, e.Salary, 
       LAG(e.Salary, 1) OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS PreviousSalary,
       LAG(e.Salary, 1) OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) - e.Salary AS SalaryDifference
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- ============================================
-- 12. HIRING ANALYSIS 
-- ============================================

SELECT 
    YEAR(JoiningDate) AS JoinYear, 
    COUNT(EmployeeID) AS EmployeeCount 
FROM Employees 
GROUP BY YEAR(JoiningDate) 
ORDER BY JoinYear;

SELECT 
    YEAR(JoiningDate) AS JoinYear, 
    COUNT(EmployeeID) AS EmployeeCount 
FROM Employees 
GROUP BY YEAR(JoiningDate) 
ORDER BY EmployeeCount DESC 
LIMIT 1;

SELECT * 
FROM Employees 
WHERE YEAR(JoiningDate) = 2024;

SELECT * 
FROM Employees 
ORDER BY JoiningDate DESC 
LIMIT 1;

-- ============================================
-- 13. HR WORKFORCE SUMMARY ANALYSIS
-- ============================================

SELECT
    COUNT(DISTINCT e.EmployeeID) AS Total_Employees,
    ROUND(AVG(e.Salary), 2) AS Average_Salary,
    ROUND(AVG(p.PerformanceRating), 2) AS Average_Performance_Rating,
    ROUND(AVG(p.AttendancePercentage), 2) AS Average_Attendance_Percentage
FROM Employees e
LEFT JOIN Performance p
    ON e.EmployeeID = p.EmployeeID;