-- Use it only when:                                          │
-- │   • Tables are small                                        │
-- │   • You actually NEED all combinations                      │
-- │   • You're doing specific analysis                          │
-- │  "CROSS JOIN = multiplication. Every row × every row. No ON needed. 
-- WHERE filters after. 10 employees × 10 departments = 100 rows. Got it! Goodnight."                                  
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- Old way to use 'cross join' 
SELECT 
    dm.*, d.*
FROM
    dept_manager dm,
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- cross join using just join
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
		JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- cross join with where
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

-- cross join wih inner join
SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
        INNER JOIN
    employees e ON e.emp_no = dm.emp_no
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

-- sol:1
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

select * from employees;
select * from dept_manager;

-- sol:2 '10 employees to all departments(10), 10*10 = 100' use logic '< 10011' for for emp_no till 10010 . 
SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;










