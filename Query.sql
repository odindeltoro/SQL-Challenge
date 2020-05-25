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
