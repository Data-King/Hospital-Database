-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Create Employees table (for both doctors and nurses)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('Doctor', 'Nurse')),
    DepartmentID INT,
    HireDate DATE NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')),
    ContactNumber VARCHAR(15)
);

-- Create Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Employees(EmployeeID)
);

-- Create PatientCare table (to track nurse assignments)
CREATE TABLE PatientCare (
    CareID INT PRIMARY KEY,
    PatientID INT,
    NurseID INT,
    AssignmentDate DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (NurseID) REFERENCES Employees(EmployeeID)
);

-- Create Payroll table
CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY,
    EmployeeID INT,
    PayPeriodStart DATE NOT NULL,
    PayPeriodEnd DATE NOT NULL,
    BaseSalary DECIMAL(10, 2) NOT NULL,
    Overtime DECIMAL(10, 2) DEFAULT 0,
    Deductions DECIMAL(10, 2) DEFAULT 0,
    NetPay DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
