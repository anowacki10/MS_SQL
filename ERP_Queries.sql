SELECT * FROM EmployeeSensitiveData
SELECT * FROM EmployeeHeadline
SELECT * FROM Departments
SELECT * FROM Location
SELECT * FROM IntershipGrades


-- INTERSHIP EMPLOYEES GRADES AVARAGE VIEW CREATE
CREATE VIEW ManagersByLocationView AS
SELECT
    RTRIM(esd.FirstName) + ' ' + RTRIM(esd.LastName) AS FullName,
    CAST(AVG(CAST(ig.Grade AS DECIMAL(10, 2))) AS Decimal(10,2)) AS AverageGrade,
	RTRIM(ins.FirstName) + ' ' + RTRIM(ins.LastName) AS Inspector
	
FROM
    EmployeeSensitiveData esd
JOIN
    IntershipGrades ig ON esd.EmployeeID = ig.EmployeeID 
JOIN
    EmployeeSensitiveData ins ON ig.Inspector = ins.EmployeeID
GROUP BY
    esd.FirstName, esd.LastName, IG.Inspector, ins.FirstName, ins.LastName;


-- NUMBER OF MANAGERS ORDER BY COUNTRY VIEW CREATE
CREATE VIEW ManagersByLocationView AS
SELECT
    l.LocationName,
    COUNT(*) AS ManagersNumber
FROM
    EmployeeHeadline eh
JOIN
    Location l ON eh.LocationID = l.LocationID
WHERE
    eh.Role = 'MANAGER' 

GROUP BY
    eh.LocationID, l.LocationName;



-- VIEW QUERIES
SELECT * FROM AvarageGradesOfInternView
SELECT * FROM ManagersByLocationView


-- OUTER Right Join Multiple Tables

SELECT esd.FirstName, esd.LastName, esd.Country, esd.City, dp.DepartmentName
From EmployeeSensitiveData esd
	RIGHT JOIN Location loc
	ON esd.country = loc.locationName
	RIGHT JOIN EmployeeHeadline eh
	ON eh.EmployeeID = esd.EmployeeID
	RIGHT JOIN Departments dp
	ON eh.DepartmentID = dp.DepartmentID
ORDER BY esd.EmployeeID




-- Foreign key set up
ALTER TABLE IntershipGrades
ADD CONSTRAINT FK_IntershipGradesInspectors
FOREIGN KEY (Inspector) 
REFERENCES EmployeeHeadline(EmployeeID); 

-- Simple AVG with 2 declimal points

SELECT CAST(AVG(CAST(Grade AS decimal(10,2))) AS DECIMAL(10,2)) AS average_grade
FROM IntershipGrades
GROUP BY EmployeeID

-- Remove spaces on right side 
SELECT EMPLOYEEID, RTRIM(FirstName) + ' ' + RTRIM(LastName) AS FullName 
FROM EmployeeSensitiveData

