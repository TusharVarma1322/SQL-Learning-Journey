select* FROM salaries;

SELECT 
    emp_no, AVG(salary) AS avg_salary
FROM
    salaries
GROUP BY emp_no;

SELECT DISTINCT
    *
FROM
    departments;
    
SELECT 
    *
FROM
    salaries
ORDER BY salary desc
LIMIT 10;

select * from dept_emp;

SELECT 
    dept_no, COUNT(emp_no) AS same_hire
FROM
    dept_emp
GROUP BY dept_no
having count(emp_no)>1
limit 10;

SELECT 
    COUNT(salary)
FROM
    salaries;

SELECT 
    *
FROM
    salaries
order by
emp_no desc;

-- Aggregate fuctions avoid null values if not specified and use can use count(*) to count null values too...
SELECT 
    COUNT(*)
FROM
    salaries;


SELECT 
    count(distinct dept_no)
FROM
    dept_emp;

SELECT 
    SUM(salary)
FROM
    salaries;

SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

select * from salaries;

SELECT 
    MAX(salary)
FROM
    salaries;

SELECT 
    min(salary)
FROM
    salaries;
    
SELECT 
    MIN(emp_no)
FROM
    employees;
    
SELECT 
    MAX(emp_no)
FROM
    employees;

SELECT 
    AVG(salary)
FROM
    salaries;

SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

-- Round fuctions relates to Precision and Scaler
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries;

SELECT 
    ROUND(AVG(salary), 2) as after_1997
FROM
    salaries
where from_date > '1997-01-01';

-- Coalesce and is null 

select * from departments_dup;

start transaction;
delete from departments_dup
where dept_no = 'd010'; 
commit;

start transaction;
alter table departments_dup
change column dept_name dept_name varchar(40) null;

-- Two insert into one column use seperate paranthesis...The Comma is OUTSIDE the parentheses.
-- This tells SQL: "Here is one row. Finished. AND here is another row."
-- Result: You get 2 rows added to your table.

insert into departments_dup
(dept_no) 
values ('d010'),('d011');

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC;

alter table employees.departments_dup
add column  dept_manager varchar(255) after dept_name;

set autocommit =0;
commit;

SELECT 
    dept_no,
    IFNULL(dept_name,
            'no department name is displayed') as dept_name
FROM
     departments_dup;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager,dept_name, 'N/A') AS dept_manager
FROM
    departments_dup;



select * from departments_dup;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_name,dept_no) AS dept_info
FROM
    departments_dup;

-- To avoid duplicate column -- remember not to mention /use twice column name in select statement cause you are renaming new column in "ifnull" and "coalsce"
SELECT 
    ifnull(dept_no,'N/A') as dept_no ,
    IFNULL(dept_name,'department name not provided') as dept_name ,
    coalesce(dept_no,dept_name,'N/A') as dept_info
FROM
    departments_dup
    order by dept_no asc;