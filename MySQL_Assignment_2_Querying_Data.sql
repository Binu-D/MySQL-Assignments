-- MySQL Assignment 2 – Querying Data
-- Instructions from the assignment:
-- 1. Continue from Assignment 1 (database and tables with constraints).
-- 2. Run the provided Employee Data INSERT statements before these queries.
-- The Employee Data INSERT script was not included with the uploaded PDF,
-- so this file contains the assignment queries only.

USE employee;

-- =========================================================
-- 1. DISTINCT VALUES
-- Retrieve distinct salaries from Employees.
SELECT DISTINCT salary
FROM Employees;

-- =========================================================
-- 2. ALIAS (AS)
-- Display age and salary with the requested aliases.
SELECT
    age AS Employee_Age,
    salary AS Employee_Salary
FROM Employees;

-- =========================================================
-- 3. WHERE CLAUSE & OPERATORS

-- Employees earning more than 50000 and hired before 2016-01-01.
SELECT *
FROM Employees
WHERE salary > 50000
  AND hire_date < '2016-01-01';

-- Find employees whose designation is missing.
SELECT *
FROM Employees
WHERE designation IS NULL;

-- Fill missing designations with "Data Scientist".
UPDATE Employees
SET designation = 'Data Scientist'
WHERE designation IS NULL;

-- =========================================================
-- SORTING AND GROUPING DATA

-- 1. ORDER BY
-- Department ID ascending, salary descending.
SELECT *
FROM Employees
ORDER BY department_id ASC, salary DESC;

-- 2. LIMIT
-- First 5 employees hired in 2018.
SELECT *
FROM Employees
WHERE hire_date >= '2018-01-01'
  AND hire_date < '2019-01-01'
ORDER BY hire_date ASC
LIMIT 5;

-- 3. AGGREGATE FUNCTIONS

-- Sum of salaries in the Finance department.
SELECT SUM(e.salary) AS total_finance_salary
FROM Employees AS e
INNER JOIN Departments AS d
    ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

-- Minimum age among all employees.
SELECT MIN(age) AS minimum_age
FROM Employees;

-- 4. GROUP BY

-- Maximum salary for each location.
SELECT
    l.location,
    MAX(e.salary) AS maximum_salary
FROM Employees AS e
INNER JOIN Location AS l
    ON e.location_id = l.location_id
GROUP BY l.location_id, l.location;

-- Average salary for each designation containing 'Analyst'.
SELECT
    designation,
    AVG(salary) AS average_salary
FROM Employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;

-- 5. HAVING

-- Departments with fewer than 3 employees.
SELECT
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM Departments AS d
LEFT JOIN Employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3;

-- Locations with female employees whose average age is below 30.
SELECT
    l.location,
    AVG(e.age) AS average_age
FROM Location AS l
INNER JOIN Employees AS e
    ON l.location_id = e.location_id
WHERE e.gender = 'F'
GROUP BY l.location_id, l.location
HAVING AVG(e.age) < 30;

-- =========================================================
-- JOINS

-- 1. INNER JOIN
-- Employee names, designations and department names for assigned employees.
SELECT
    e.employee_name,
    e.designation,
    d.department_name
FROM Employees AS e
INNER JOIN Departments AS d
    ON e.department_id = d.department_id;

-- 2. LEFT JOIN
-- All departments, including those with no employees, and employee counts.
SELECT
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS total_employees
FROM Departments AS d
LEFT JOIN Employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- 3. RIGHT JOIN
-- All locations, including locations with no assigned employees.
SELECT
    l.location,
    e.employee_name
FROM Employees AS e
RIGHT JOIN Location AS l
    ON e.location_id = l.location_id;
