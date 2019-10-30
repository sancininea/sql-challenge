/* List the following details of each employee: employee number, last name, first name, gender, and salary */
SELECT employees.emp_no as "Employee number", employees.last_name as "Last name", 
employees.first_name as "First name", employees.gender as "Gender", salaries.salary as "Salary"
FROM
employees INNER JOIN salaries
ON employees.emp_no = salaries.emp_no;

/* List employees who were hired in 1986.*/
SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

/* List the manager of each department with the following information: department number, department name,
the manager's employee number, last name, first name, and start and end employment dates. */
SELECT dept_manager.dept_no as "Department number", departments.dept_name as "Department name",
dept_manager.emp_no as "Emplyoyee number", employees.last_name as "Last name", 
employees.first_name as "First name", dept_emp.from_date as "Start employment date", 
dept_emp.to_date as "End employment date"
FROM
dept_manager 
LEFT JOIN departments ON dept_manager.dept_no = departments.dept_no
LEFT JOIN employees ON dept_manager.emp_no = employees.emp_no
LEFT JOIN dept_emp ON dept_manager.emp_no = dept_emp.emp_no;

/* List the department of each employee with the following information: employee number, last name,
first name, and department name. */
SELECT employees.emp_no as "Employee number", employees.last_name as "Last name", 
employees.first_name as "First name", deps.dept_name as "Department name"
FROM employees
INNER JOIN 
(SELECT dept_emp.emp_no, departments.dept_name
FROM dept_emp INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
) AS deps
ON 
employees.emp_no = deps.emp_no;

/* List all employees whose first name is "Hercules" and last names begin with "B." */
SELECT * FROM employees
WHERE
first_name = 'Hercules'
AND
last_name like 'B%';

/* List all employees in the Sales department, including their employee number, last name, first name,
and department name. */
SELECT employees.emp_no as "Employee number", employees.last_name as "Last name", 
employees.first_name as "First name", deps.dept_name as "Department name"
FROM employees
RIGHT JOIN 
(SELECT dept_emp.emp_no, departments.dept_name
FROM dept_emp INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
) AS deps
ON 
employees.emp_no = deps.emp_no;

/* List all employees in the Sales and Development departments, including their employee number, last name,
first name, and department name.*/
SELECT employees.emp_no as "Employee number", employees.last_name as "Last name", 
employees.first_name as "First name", deps.dept_name as "Department name"
FROM employees
RIGHT JOIN 
(SELECT dept_emp.emp_no, departments.dept_name
FROM dept_emp INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'
) AS deps
ON 
employees.emp_no = deps.emp_no;

/* In descending order, list the frequency count of employee last names, i.e., how many employees share 
each last name. */
SELECT last_name, count(first_name) as how_many FROM employees
GROUP BY last_name
ORDER BY how_many DESC;
