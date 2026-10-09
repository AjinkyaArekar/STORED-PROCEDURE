-- ## database.sql : Table creation and sample data ##
CREATE DATABASE IF NOT EXISTS employee_payroll_db;
USE employee_payroll_db;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id   INT            PRIMARY KEY,
    employee_name VARCHAR(100)   NOT NULL,
    department    VARCHAR(50)    NOT NULL,
    designation   VARCHAR(50)    NOT NULL,
    basic_salary  DECIMAL(10,2)  NOT NULL CHECK (basic_salary >= 0),
    joining_date  DATE           NOT NULL,
    status        VARCHAR(10)    NOT NULL DEFAULT 'Active',
    CONSTRAINT chk_status CHECK (status IN ('Active', 'Inactive'))
);

INSERT INTO employees VALUES
(101, 'Ajinkya Arekar',   'IT',        'Data Analyst',        85000.00, '2026-03-15', 'Active'),
(102, 'Om Ghag',          'IT',        'Senior Developer',     95000.00, '2022-07-01', 'Active'),
(103, 'Suyash Gurav',     'IT',        'Junior Developer',     28000.00, '2023-01-10', 'Active'),
(104, 'Neha Arekar',      'LAW',       'Legal Executive',      50000.00, '2023-05-20', 'Inactive'),
(105, 'Rohan Desai',      'HR',        'HR Executive',         35000.00, '2022-09-12', 'Active'),
(106, 'Neha Joshi',      'Finance',   'Accountant',           25000.00, '2024-02-05', 'Active'),
(107, 'Mayur Zade',      'IT',        'Data Analyst',         83000.00, '2022-11-30', 'Inactive'),
(108, 'Anjali Gupta',    'Sales',     'Sales Executive',      46000.00, '2023-06-18', 'Active'),
(109, 'Karan Verma',     'Sales',     'Senior Manager',        50000.00, '2026-08-25', 'Inactive'),
(110, 'Pooja Reddy',     'Marketing', 'Marketing Executive',  34000.00, '2026-04-02', 'Active'),
(111, 'Virat Kholi',     'IT',        'ML Engineer',          92000.00, '2025-12-01', 'Inactive'),
(112, 'Rohit Sharma',    'Marketing', 'Marketing Head',       96000.00, '2023-01-15', 'Active');

SELECT * FROM employees;