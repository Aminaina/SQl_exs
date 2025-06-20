-- ============================================================================
-- Database Setup Script for SQL Exercise 1
-- ============================================================================
-- This script creates the employee table and populates it with sample data
-- Compatible with MySQL, PostgreSQL, SQL Server
-- ============================================================================
-- DROP TABLE IF EXISTS employee;
-- Create the employee table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE NOT NULL,
    age INT NOT NULL
);

-- Insert sample data
INSERT INTO employee (emp_id, first_name, last_name, department, salary, hire_date, age) VALUES
(1, 'John', 'Smith', 'IT', 75000.00, '2020-01-15', 28),
(2, 'Sarah', 'Johnson', 'HR', 65000.00, '2019-03-22', 34),
(3, 'Mike', 'Wilson', 'Finance', 80000.00, '2021-07-10', 29),
(4, 'Emily', 'Davis', 'IT', 72000.00, '2020-11-05', 26),
(5, 'Robert', 'Brown', 'Marketing', 68000.00, '2018-09-12', 31),
(6, 'Lisa', 'Anderson', 'Finance', 85000.00, '2017-05-18', 38),
(7, 'David', 'Taylor', 'IT', 78000.00, '2019-12-03', 32),
(8, 'Jennifer', 'Miller', 'HR', 62000.00, '2021-02-28', 27),
(9, 'James', 'Garcia', 'Marketing', 71000.00, '2020-06-14', 30),
(10, 'Maria', 'Rodriguez', 'Finance', 77000.00, '2018-11-20', 35);


