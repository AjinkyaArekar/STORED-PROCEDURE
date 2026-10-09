## procedures.sql : All stored procedures ##
USE employee_payroll_db;

DROP PROCEDURE IF EXISTS GetEmployeeSalaryReport;
DROP PROCEDURE IF EXISTS CalculateEmployeeSalary;
DROP PROCEDURE IF EXISTS EmployeeSalaryGrade;
DROP PROCEDURE IF EXISTS GetDepartmentSummary;

DELIMITER $$

-- Task 1: Employee Salary Report
CREATE PROCEDURE GetEmployeeSalaryReport (
    IN p_department_name VARCHAR(50),
    IN p_minimum_salary  DECIMAL(10,2)
)
BEGIN
    -- Validation
    IF p_department_name IS NULL OR TRIM(p_department_name) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Department name cannot be empty.';
    END IF;
    IF p_minimum_salary IS NULL OR p_minimum_salary < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Minimum salary must be zero or greater.';
    END IF;

    SELECT employee_id   AS 'Employee ID',
           employee_name AS 'Employee Name',
           department    AS 'Department',
           designation   AS 'Designation',
           basic_salary  AS 'Basic Salary',
           joining_date  AS 'Joining Date'
    FROM   employees
    WHERE  department   = p_department_name
      AND  basic_salary >= p_minimum_salary
      AND  status       = 'Active'
    ORDER BY basic_salary DESC;
END$$

