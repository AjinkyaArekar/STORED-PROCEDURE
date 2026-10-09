

## procedures.sql : All stored procedures ##


DROP PROCEDURE IF EXISTS GetEmployeeSalaryReport;
DROP PROCEDURE IF EXISTS CalculateEmployeeSalary;
DROP PROCEDURE IF EXISTS EmployeeSalaryGrade;
DROP PROCEDURE IF EXISTS GetDepartmentSummary;

DELIMITER $$


               ### Task 1: Employee Salary Report ###
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

                          ### ------- ###
	### Task 2: Employee Salary Calculation ### 
CREATE PROCEDURE CalculateEmployeeSalary (
    IN p_employee_id INT
)
BEGIN
    DECLARE v_name  VARCHAR(100);
    DECLARE v_basic DECIMAL(10,2);
    DECLARE v_hra   DECIMAL(10,2);
    DECLARE v_da    DECIMAL(10,2);
    DECLARE v_pf    DECIMAL(10,2);
    DECLARE v_net   DECIMAL(10,2);
    DECLARE v_found INT DEFAULT 0;

    SELECT COUNT(*) INTO v_found FROM employees WHERE employee_id = p_employee_id;

    IF v_found = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee ID not found.';
    END IF;

    SELECT employee_name, basic_salary INTO v_name, v_basic
    FROM employees WHERE employee_id = p_employee_id;

    SET v_hra = v_basic * 0.20;
    SET v_da  = v_basic * 0.10;
    SET v_pf  = v_basic * 0.12;
    SET v_net = v_basic + v_hra + v_da - v_pf;

    SELECT v_name  AS 'Employee Name',
           v_basic AS 'Basic Salary',
           v_hra   AS 'HRA',
           v_da    AS 'DA',
           v_pf    AS 'PF',
           v_net   AS 'Net Salary';
END$$


                             #### --- ### 

  ###Task 3: Salary Grade ###
CREATE PROCEDURE EmployeeSalaryGrade (
    IN p_employee_id INT
)
BEGIN
    DECLARE v_name  VARCHAR(100);
    DECLARE v_basic DECIMAL(10,2);
    DECLARE v_grade CHAR(1);
    DECLARE v_found INT DEFAULT 0;

    SELECT COUNT(*) INTO v_found FROM employees WHERE employee_id = p_employee_id;

    IF v_found = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee ID not found.';
    END IF;

    SELECT employee_name, basic_salary INTO v_name, v_basic
    FROM employees WHERE employee_id = p_employee_id;

    SET v_grade = CASE
                      WHEN v_basic < 30000  THEN 'C'
                      WHEN v_basic <= 60000 THEN 'B'
                      ELSE 'A'
                  END;

    SELECT v_name  AS 'Employee Name',
           v_basic AS 'Basic Salary',
           v_grade AS 'Salary Grade';
END$$
                               
                               ### ---- ###
						## Bonus: Department Summary
CREATE PROCEDURE GetDepartmentSummary (
    IN p_department_name VARCHAR(50)
)
BEGIN
    DECLARE v_emp_count INT DEFAULT 0;

    SELECT COUNT(*) INTO v_emp_count FROM employees WHERE department = p_department_name;

    IF v_emp_count = 0 THEN
        SELECT CONCAT('Department "', IFNULL(p_department_name, 'NULL'),
                      '" does not exist.') AS 'Message';
    ELSE
        SELECT department                 AS 'Department',
               COUNT(*)                   AS 'Total Employees',
               ROUND(AVG(basic_salary),2) AS 'Average Salary',
               MAX(basic_salary)          AS 'Highest Salary',
               MIN(basic_salary)          AS 'Lowest Salary',
               SUM(basic_salary)          AS 'Total Salary Expenditure'
        FROM   employees
        WHERE  department = p_department_name
        GROUP BY department;
    END IF;

END$$

DELIMITER ;


