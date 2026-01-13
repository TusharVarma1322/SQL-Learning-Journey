drop table if exists employees_dup;
create table employees_dup
( emp_no int(11),
birth_date date,
first_name varchar(14),
last_name varchar(16),
gender enum('M','F'),
hire_date date
);

insert into employees_dup
select e.*
from employees e 
limit 20;

select * from employees_dup order by emp_no;

insert into employees_dup
values (10001,'1953-09-02','Georgi','Facello','M','1986-06-26');


SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION  SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    dm.dept_no,
    dm.from_date
FROM
    dept_manager dm;







