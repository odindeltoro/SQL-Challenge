-- SQL Homework - Employee Database: A Mystery in Two Parts

-- DATA MODELING
-- Inspect the CSVs and sketch out an ERD of the tables. Feel free to use a tool like http://www.quickdatabasediagrams.com.
-- ERD Model in following url https://app.quickdatabasediagrams.com/#/d/mfxi3u

-- DATA ENGINEERING
-- Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.
-- Import each CSV file into the corresponding SQL table.
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Create tables based on the schema
-- Company Human Talent by Department
-- Physical model
CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- Import CSV Files
-- Quick validation of successful import of data by filtering first 5 rows
SELECT * FROM departments
LIMIT 5;
SELECT * FROM dept_emp
LIMIT 5;
SELECT * FROM dept_manager
LIMIT 5;
SELECT * FROM employees
LIMIT 5;
SELECT * FROM salaries
LIMIT 5;
SELECT * FROM titles
LIMIT 5;

-- DATA ANALYSIS
-- Once you have a complete database, do the following:
-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT d.emp_no, d.last_name, d.first_name, d.gender, e.salary
FROM employees AS d
FULL OUTER JOIN salaries AS e
ON d.emp_no = e.emp_no
ORDER BY salary DESC;

-- List employees who were hired in 1986.
SELECT last_name, first_name, gender, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT a.dept_no, a.dept_name, c.emp_no, d.last_name, d.first_name, c.from_date, c.to_date
FROM departments AS a
LEFT JOIN dept_manager AS c
ON a.dept_no = c.dept_no
LEFT JOIN employees AS d
ON c.emp_no = d.emp_no
ORDER BY from_date ASC;

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT b.emp_no, d.last_name, d.first_name, a.dept_name
FROM dept_emp AS b
FULL OUTER JOIN employees AS d
ON b.emp_no = d.emp_no
FULL OUTER JOIN departments AS a
ON b.dept_no = a.dept_no
ORDER BY dept_name ASC;

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'
ORDER BY last_name ASC;

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT b.emp_no, d.last_name, d.first_name, a.dept_name
FROM dept_emp AS b
FULL OUTER JOIN employees AS d
ON b.emp_no = d.emp_no
FULL OUTER JOIN departments AS a
ON b.dept_no = a.dept_no
WHERE a.dept_name = 'Sales'
ORDER BY last_name ASC;

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT b.emp_no, d.last_name, d.first_name, a.dept_name
FROM dept_emp AS b
FULL OUTER JOIN employees AS d
ON b.emp_no = d.emp_no
FULL OUTER JOIN departments AS a
ON b.dept_no = a.dept_no
WHERE a.dept_name = 'Sales' 
OR a.dept_name = 'Development'
ORDER BY dept_name ASC;

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS "number of employees"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
