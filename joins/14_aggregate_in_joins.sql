SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender;


SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON e.emp_no = dm.emp_no;

select*from employees;

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    departments d
       right JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON e.emp_no = dm.emp_no;

-- There other many sitaution in which you will need to join more than two tables, right or left join in some of them will be key...
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        RIGHT JOIN
    employees e ON e.emp_no = dm.emp_no;
    
    
    
    
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    titles t
        INNER JOIN
    employees e ON t.emp_no = e.emp_no
        INNER JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        INNER JOIN
    departments d ON dm.dept_no = d.dept_no
WHERE
    t.title = 'manager'
ORDER BY e.emp_no
;

-- Look for key columns , which are common between table involved and nessacery to solve the task at hand 
SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY d.dept_name
having average_salary > 60000
ORDER BY average_salary DESC
;


SELECT 
    e.gender, t.title, COUNT(e.gender) AS distinct_gender
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'manager'
group by e.gender
;




















