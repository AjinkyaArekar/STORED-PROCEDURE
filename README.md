Employee Management & Payroll – MySQL Stored Procedures

Overview :
This project implements an Employee Management and Payroll database in MySQL with four
stored procedures covering reporting, salary calculation, salary grading and department-level
summaries.

Repository Files : 
database.sql -  Creates the employee_payroll_db database, the employees table and 12
sample employees
procedures.sql  - Contains all four stored procedures
test_calls.sql  - Example CALL statements used in the demo


Database Design : 
The sample data has 12 employees across IT, HR, Finance, Sales and Marketing, with different
salary ranges and both Active and Inactive statuses.

Stored Procedures : 

1. GetEmployeeSalaryReport(department_name, minimum_salary)
Task 1 is GetEmployeeSalaryReport. It takes a department name and a minimum
salary as input parameters. It returns only employees who belong to that
department, have a basic salary at or above the minimum, and have status Active.
I'm calling it for the IT department with a minimum of 50,000. It returns Rahul Sharma
and Priya Mehta. Suresh Iyer earns 52,000 in IT, but he is Inactive, so he is correctly
excluded. The procedure also validates its input. If the department is empty or the
salary is negative, it raises a custom error.
Example : Run CALL GetEmployeeSalaryReport('IT', 50000);

3. CalculateEmployeeSalary(employee_id) = 
Task 2 is CalculateEmployeeSalary. It takes an employee ID, reads the basic salary
into variables, and calculates HRA as 20 percent, DA as 10 percent and PF as 12
percent. Net salary is basic plus HRA plus DA minus PF.
For employee 101 the basic salary is 75,000. HRA is 15,000, DA is 7,500 and PF is 9,000,
so the net salary is 88,500.
For error handling, I'll call it with ID 999, which doesn't exist. The procedure checks
first and raises the message 'Employee ID not found', instead of returning something
wrong.
Example : RUN CALL CalculateEmployeeSalary(101); → Net Salary 88500.00

4. EmployeeSalaryGrade(employee_id)
Task 3 is EmployeeSalaryGrade. It uses a CASE statement. Below 30,000 is grade C,
30,000 to 60,000 is grade B, and above 60,000 is grade A.
Employee 103 earns 28,000, so the grade is C. Employee 109 earns exactly 60,000, so
the grade is B, which shows the boundary is handled correctly. Employee 102 earns
95,000, so the grade is A.
Example : Run CALL EmployeeSalaryGrade(103);

5 . : Department summary
The bonus task is GetDepartmentSummary. It uses aggregate functions: COUNT,
AVG, MAX, MIN and SUM. For IT, it shows 4 employees, an average salary of 62,500, a
highest salary of 95,000, a lowest of 28,000, and a total salary expenditure of
250,000.
The bonus requirement is to handle a department that doesn't exist. If I call it with
'Legal', which isn't in the table, the procedure first counts the employees. When the
count is zero, it shows a friendly message, 'Department Legal does not exist', instead
of an empty result.

6 . Conclusion : 
To summarize, I used input parameters, variables, IF and CASE logic, aggregate
functions, salary calculations and error handling with SIGNAL. The code is
commented and organized into database.sql, procedures.sql and a README.
Thank you for your time.
