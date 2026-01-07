use employees;

set autocommit = 0;

commit;

SELECT 
    *
FROM
    employees
where emp_no = 999903; 

SELECT 
    *
FROM
    titles
where emp_no = 999903; 


delete from employees
where emp_no = 999903;

rollback;


-- Use "start transaction" , when you want to turn off auto commit for few lines.
SELECT 
    *
FROM
    departments_dup;

start transaction;
delete from departments_dup;
rollback;

SELECT 
    *
FROM
    departments;