use employees;

select* from departments_dup order by dept_no asc;
alter table departments_dup
drop column dept_manager;

alter table departments_dup
change column dept_no dept_no char(4) null;

start transaction;
DELETE FROM departments_dup 
WHERE
    dept_name = 'finance';
UPDATE departments_dup 
SET 
    dept_name = 'Public Relations'
WHERE
    dept_no = 'd002';
commit;
rollback;

insert into departments_dup
(dept_no,dept_name)
values('d002','Public Relations');

-- Create Table Departments Manager Duplicate
drop table if exists dept_manager_dup;

create table dept_manager_dup(
emp_no int(11) not null,
dept_no char(4) null,
from_date date not null,
to_date date null);

insert into dept_manager_dup
select * from dept_manager;

insert into dept_manager_dup(emp_no,from_date)
values(999904,'2017-01-01'),
(999905,'2017-01-01'),
(999906,'2017-01-01'),
(999907,'2017-01-01');

delete from dept_manager_dup
where dept_no ='d001';

insert into departments_dup(dept_name)
values ('public relations');

delete from departments_dup
where dept_no = 'd002';
-- code ended

# dept_manager_dup
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no ;

# department_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

