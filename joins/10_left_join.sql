# REMOVE THE DUPLICATES FROM THE TWO TABLES

delete from dept_manager_dup
where emp_no = '110228';

delete from departments_dup
where dept_no = 'd009';

insert into dept_manager_dup
values('110228','d003','1992-03-21','9999-01-01');

insert into departments_dup
values('d009','Customer Service');


SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON d.dept_no = m.dept_no
group by m.emp_no,m.dept_no,d.dept_name
order by m.emp_no desc;