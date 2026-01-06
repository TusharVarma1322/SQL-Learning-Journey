select *
from salaries
order by emp_no  desc
limit 10;

insert into employees
(emp_no,
birth_date,
first_name,
last_name,
gender,
hire_date)
 values(999901,
 '1958-01-06',
 'John',
 'Smith',
 'M',
 '2011-02-03')
 ;
 
 insert into salaries
 (emp_no,
 from_date,
 to_date
 )
 values
 (999902,
 '1996-02-04',
 '1998-06-04'
 );
 
 insert into employees
 (birth_date,
 emp_no,
 first_name,
 last_name,
 hire_date,
 gender
 )
 values
 ('1978-02-03',
 999902,
 'Patricia',
 'Lawrence',
 '1999-02-20',
 'F'
 );
 
 select *
from employees
order by emp_no  desc
limit 10;

insert into employees
values(999903,
'1987-02-06',
'Johnathan',
'Creek',
'M',
'1989-02-24'
);


SELECT 
    *
FROM
    departments;

create table departments_dup
(
   dept_no char(4) not null,
   dept_name varchar(40) not null
   );
   
drop table departments_dup;

insert into departments_dup
(
dept_no,
dept_name
)
select * from departments;

SELECT 
    *
FROM
    departments_dup
order by dept_no;

-- new data should not satisfy the constraints of already been set in the database will always show error, means already added data constraints should not match new data.

SELECT 
    *
FROM
    titles
order by emp_no desc
limit
     10;
     
insert into titles
(emp_no,
title,
from_date
)
values
(999903,
'Senior Engineer',
'1997-08-01');

SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

insert into dept_emp
(emp_no,
dept_no,
from_date,
to_date)
values
(999903,
'd005',
'1997-08-01',
'9999-01-01');


SELECT 
    *
FROM
    departments
order by dept_no desc
LIMIT 10;

insert into departments 
(dept_no,
dept_name) values('d010','Business Analysis');
select * 
from departments
order by dept_no desc
limit 10


