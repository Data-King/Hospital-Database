# Hospital-Database
I'll be designing a simplified database schema for a hospital system that connects patients to nurses, doctors, and includes a payroll component. This database will use SQL and I'll provide the CREATE TABLE statements to set it up.


This schema creates the following tables:

1. Departments: Stores different hospital departments.
2. Employees: Stores information about both doctors and nurses.
3. Patients: Stores patient information.
4. Appointments: Links patients with doctors for scheduled appointments.
5. PatientCare: Tracks nurse assignments to patients.
6. Payroll: Manages payroll information for employees.

Here's a brief explanation of how these tables are connected:

- Employees (doctors and nurses) are associated with departments.
- Patients are connected to doctors through the Appointments table.
- Patients are connected to nurses through the PatientCare table.
- The Payroll table is linked to employees for managing salaries.

To use this database, you would:

1. Insert departments into the Departments table.
2. Add employees (doctors and nurses) to the Employees table.
3. Register patients in the Patients table.
4. Schedule appointments between patients and doctors in the Appointments table.
5. Assign nurses to patients in the PatientCare table.
5. Record payroll information in the Payroll table.

This is a basic structure and might need to be expanded based on specific hospital requirements. For example, you might want to add:

A more detailed medical records table
A table for medical procedures or treatments
Inventory management for medical supplies
More detailed scheduling system for staff shifts.
