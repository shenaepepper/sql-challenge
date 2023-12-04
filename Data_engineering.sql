ALTER DATABASE "employees_db" SET datestyle TO "ISO, MDY";

--TITLES TABLE--
CREATE TABLE Titles (
	title_id Varchar Primary key,
	title Varchar
);

Select * from Titles;

--EMPLOYEES TABLE--
CREATE TABLE Employees (
	emp_no int primary key,
	emp_title_id Varchar References titles (title_id),
	birth_date Date,
	first_name Varchar(255),
	last_name Varchar(255),
	sex Varchar(255),
	hire_date Date
);

select * from Employees limit 10;

--DEPARTMENT TABLE--
CREATE TABLE Department (
	dept_no Varchar Primary key,
	dept_name Varchar
);

select * from Department;

--DEPT_MANAGER TABLE--
CREATE TABLE Dept_manager (
	dept_no Varchar References Department(dept_no),
	emp_no int References Employees(emp_no)
);

Select * from Dept_manager limit 10;

--DEPT_EMP TABLE--
CREATE TABLE Dept_emp (
	emp_no int References Employees(emp_no),
	dept_no Varchar References Department(dept_no)
);

Select * from Dept_emp limit 10;


--SALARIES TABLE--
CREATE TABLE Salaries (
	emp_no int References Employees(emp_no),
	salary int
);

Select * from Salaries limit 10;

--Q1--
SELECT
    e.emp_no AS "Employee Number",
    e.last_name AS "Last Name",
    e.first_name AS "First Name",
    e.sex AS "Sex",
    s.salary AS "Salary"
FROM
    Employees e
    JOIN Salaries s ON e.emp_no = s.emp_no
LIMIT 10;

--Q2--
SELECT first_name, last_name, hire_date
FROM Employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--Q3--
SELECT
    dm.dept_no,
    d.dept_name,
    dm.emp_no AS manager_emp_no,
    e.last_name AS manager_last_name,
    e.first_name AS manager_first_name
FROM
    Dept_manager dm
JOIN
    Department d ON dm.dept_no = d.dept_no
JOIN
    Employees e ON dm.emp_no = e.emp_no;
	
--Q4--
SELECT
    de.emp_no,
    e.last_name,
    e.first_name,
    de.dept_no,
    d.dept_name
FROM
    Dept_emp de
JOIN
    Employees e ON de.emp_no = e.emp_no
JOIN
    Department d ON de.dept_no = d.dept_no;

--Q5--
SELECT
    first_name,
    last_name,
    sex
FROM
    Employees
WHERE
    first_name = 'Hercules'
    AND last_name LIKE 'B%';
	
--Q6--
SELECT
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    Employees e
JOIN
    Dept_emp de ON e.emp_no = de.emp_no
JOIN
    Department d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Sales';
	
--Q7--
SELECT
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM
    Employees e
JOIN
    Dept_emp de ON e.emp_no = de.emp_no
JOIN
    Department d ON de.dept_no = d.dept_no
WHERE
    d.dept_name IN ('Sales', 'Development');

--Q8--
SELECT
    last_name,
    COUNT(*) AS name_count
FROM
    Employees
GROUP BY
    last_name
ORDER BY
    name_count DESC, last_name;




