-- 1 -- Find all appointments for a specific patient:
SELECT a.AppointmentID, a.AppointmentDate, e.FirstName AS DoctorFirstName, e.LastName AS DoctorLastName, d.DepartmentName
FROM Appointments a
JOIN Employees e ON a.DoctorID = e.EmployeeID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE a.PatientID = 1001
ORDER BY a.AppointmentDate DESC;

-- 2 -- List all nurses assigned to a specific patient in the last month:
SELECT pc.AssignmentDate, e.FirstName AS NurseFirstName, e.LastName AS NurseLastName
FROM PatientCare pc
JOIN Employees e ON pc.NurseID = e.EmployeeID
WHERE pc.PatientID = 1002
  AND pc.AssignmentDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
ORDER BY pc.AssignmentDate DESC;



-- 3 -- Calculate the total payroll for each department in the last pay period:
SELECT d.DepartmentName, SUM(p.NetPay) AS TotalPayroll
FROM Payroll p
JOIN Employees e ON p.EmployeeID = e.EmployeeID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE p.PayPeriodEnd = (SELECT MAX(PayPeriodEnd) FROM Payroll)
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY TotalPayroll DESC;



-- 4 -- Find the doctors with the most appointments in the last week:
SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(*) AS AppointmentCount
FROM Appointments a
JOIN Employees e ON a.DoctorID = e.EmployeeID
WHERE a.AppointmentDate >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY AppointmentCount DESC
LIMIT 5;



-- 5 --  Identify patients who haven't had an appointment in the last 6 months:
SELECT p.PatientID, p.FirstName, p.LastName, MAX(a.AppointmentDate) AS LastAppointment
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.FirstName, p.LastName
HAVING LastAppointment IS NULL OR LastAppointment < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY LastAppointment;


-- 6 --  Calculate overtime pay for nurses in the last pay period:
SELECT e.EmployeeID, e.FirstName, e.LastName, p.Overtime
FROM Payroll p
JOIN Employees e ON p.EmployeeID = e.EmployeeID
WHERE e.Role = 'Nurse'
  AND p.PayPeriodEnd = (SELECT MAX(PayPeriodEnd) FROM Payroll)
  AND p.Overtime > 0
ORDER BY p.Overtime DESC;


-- 7 -- Find the busiest department based on the number of appointments:
SELECT d.DepartmentName, COUNT(*) AS AppointmentCount
FROM Appointments a
JOIN Employees e ON a.DoctorID = e.EmployeeID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE a.AppointmentDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY AppointmentCount DESC
LIMIT 1;

-- 8 -- List patients with their primary doctor (most recent appointment):
SELECT p.PatientID, p.FirstName AS PatientFirstName, p.LastName AS PatientLastName,
       e.FirstName AS DoctorFirstName, e.LastName AS DoctorLastName
FROM Patients p
LEFT JOIN (
    SELECT PatientID, DoctorID, ROW_NUMBER() OVER (PARTITION BY PatientID ORDER BY AppointmentDate DESC) as rn
    FROM Appointments
) a ON p.PatientID = a.PatientID AND a.rn = 1
LEFT JOIN Employees e ON a.DoctorID = e.EmployeeID
ORDER BY p.LastName, p.FirstName;
