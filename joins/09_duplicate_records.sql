INSERT INTO dept_manager_dup
values ('110228','d003','1992-03-21','9999-01-01');

insert into departments_dup
values('d009','Customer Service');

SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no ASC;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY emp_no;

-- Error occurs because of the ONLY_FULL_GROUP_BY rule in MySQL
-- Essentially, you are asking SQL to group results by emp_no, but you are also asking it to display dept_no and dept_name.
-- If one employee (emp_no) is associated with multiple departments, SQL does not know which department to display in that single row, so it blocks the query to prevent ambiguous data.
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no,m.dept_no, d.dept_name # use all columns
ORDER BY emp_no;

# use Any_value()
-- If you don't care which department shows up for the employee (you just want the code to run and show one of them),
-- you can wrap the non-grouped columns in ANY_VALUE().
SELECT 
   any_value (m.dept_no) as dept_no,
   m.emp_no,
    any_value(d.dept_name) as dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY emp_no;


