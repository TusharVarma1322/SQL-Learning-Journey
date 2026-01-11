-- new syntax 
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON d.dept_no = m.dept_no
ORDER BY m.dept_no;

-- old syntax

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m,
    departments_dup d
WHERE
    d.dept_no = m.dept_no
ORDER BY dept_no;
      

select * from employees;
select * from dept_manager;

SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
    employees e,
    dept_manager dm
WHERE
    e.emp_no = dm.emp_no
ORDER BY emp_no;

-- New Join 
SELECT 
    e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
ORDER BY emp_no;

-- join and where used together

SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    salary > 145000;
    
select * from employees;
select * from titles;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title AS Job_Title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'margareta'
        AND last_name = 'markovitch';