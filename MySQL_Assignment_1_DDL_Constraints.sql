-- MySQL Assignment 1 – DDL Commands & Constraints
-- Run in MySQL Workbench.
-- Part 1 demonstrates DDL commands. The DROP commands at the end remove
-- the database; Part 2 then recreates it with the required constraints.

-- =========================================================
-- PART 1: DDL COMMANDS
-- =========================================================

-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS employee;
USE employee;

-- 1. CREATE TABLES (initial schema)
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE Location (
    location_id INT PRIMARY KEY,
    location VARCHAR(30)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    gender ENUM('M', 'F'),
    age INT,
    hire_date DATE,
    designation VARCHAR(100),
    department_id INT,
    location_id INT,
    salary DECIMAL(10,2)
);

-- 2. ALTER TABLE
-- Add email
ALTER TABLE Employees
ADD email VARCHAR(100);

-- Widen designation
ALTER TABLE Employees
MODIFY designation VARCHAR(255);

-- Drop age
ALTER TABLE Employees
DROP COLUMN age;

-- Rename hire_date
ALTER TABLE Employees
RENAME COLUMN hire_date TO date_of_joining;

-- 3. RENAME TABLES
RENAME TABLE Departments TO Departments_Info;
RENAME TABLE Location TO Locations;

-- 4. TRUNCATE TABLE
TRUNCATE TABLE Employees;

-- 5. DROP TABLE, THEN DROP DATABASE
DROP TABLE Employees;
DROP DATABASE employee;


-- =========================================================
-- PART 2: DATABASE RECREATION AND CONSTRAINTS
-- =========================================================

DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

-- Departments: unique, non-NULL department names
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Location: automatically generated IDs and unique, non-NULL locations
CREATE TABLE Location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(30) NOT NULL UNIQUE
);

-- Employees: required constraints and foreign-key relationships
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender ENUM('M', 'F'),
    age INT CHECK (age >= 18),
    hire_date DATE DEFAULT (CURRENT_DATE),
    designation VARCHAR(100),
    department_id INT,
    location_id INT,
    salary DECIMAL(10,2),
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),
    CONSTRAINT fk_employee_location
        FOREIGN KEY (location_id)
        REFERENCES Location(location_id)
);

-- VERIFICATION
SHOW TABLES;
DESC Departments;
DESC Location;
DESC Employees;
SHOW CREATE TABLE Employees;
