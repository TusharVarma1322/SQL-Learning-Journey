SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
   departments_dup d ON m.dept_no = d.dept_no
ORDER BY emp_no;

select * from dept_manager;
select *from employees;

SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
     employees e
        INNER JOIN
        dept_manager m
    ON m.emp_no = e.emp_no
ORDER BY emp_no ;














