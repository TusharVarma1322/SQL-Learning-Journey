select *
from departments ;

select dept_no
from departments;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'denis';
    
   SELECT 
    *
FROM
    employees
WHERE
    first_name = 'elvis';
    
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'denis' AND gender = 'M';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'kellie' AND gender = 'F';
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'denis'
        OR first_name = 'elvis'
        ;
        
 SELECT 
    *
FROM
    employees
WHERE
    first_name = 'kellie'
        OR first_name = 'aruna';
        
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'kellie'
        OR first_name = 'aruna');   
        

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('cathie' , 'mark', 'nathan');
    
    
 SELECT 
    *
FROM
    employees
WHERE
    first_name not IN ('cathie' , 'mark', 'nathan');   
    
  
select * 
from employees
where first_name like ('mar%');

select * 
from employees
where first_name like ('mar_');

select * 
from employees
where first_name like ('%ar%');

-- not like 
select * 
from employees
where first_name not like ('%ar%');

select *
from employees
where hire_date like('2000%');

select*
from employees
where emp_no not like ('1000_');

select*
from employees
where first_name like ('%jack%');

select*
from employees 
where first_name not like('jack');

select*
from employees
where hire_date between '1990-01-01' and '2000-01-01';


select*
from employees
where hire_date not between '1990-01-01' and '2000-01-01';

select*
from salaries
where salary between '66000' and '70000';

select*
from salaries
where emp_no between '10004' and '10012';

select dept_name
from departments
where dept_no between 'd003' and 'd006' ;

select*
from departments
where dept_no is not null;

select*
from employees
where gender = 'f' and hire_date >= '2000-01-01';

select*
from salaries
where salary >'150000';

select distinct hire_date
from employees;

select count(first_name)
from employees;

-- remember aggregate fuctions won't count null values if not specified they defaultly ignore them.
select count(distinct first_name)
from employees;

select count(salary)
from salaries
where salary >=100000;

select count(*)
from dept_manager;

select *
from employees
order by first_name asc;

select *
from employees
order by hire_date desc;

select first_name ,count(first_name) as total_count
from employees
group by first_name
order by first_name;

select*
from employees;

select gender, avg(gender),sum(gender), max(gender), min(gender) 
from employees
group by gender
order by gender;

select*
from salaries;

select salary ,count(salary) as emp_with_same_salaries
from salaries
where salary >= 80000
group by salary
order by salary ;

SELECT 
    *
FROM
    titles;
    
SELECT 
    title, COUNT(title) AS emps_with_same_titles
FROM
    titles
WHERE
    to_date <'1995-12-01'
GROUP BY title
ORDER BY title;



select*
from titles;

select title , count(title) as same_title_emps
from titles
where from_date <'1990-08-01'
group by title
order by title desc;


SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name) > 255
ORDER BY first_name ASC;

select * from salaries;

SELECT 
    emp_no, AVG(salary) AS salary_more_than_20k
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no ASC;

SELECT 
    *, AVG(salary) AS salary_more_than_20k
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no ASC;

SELECT 
    emp_no, avg(salary) AS higher_than_120k
FROM
    salaries
WHERE
    salary > '120000'
GROUP BY emp_no
ORDER BY emp_no ASC;


SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < '200'
ORDER BY first_name ASC;

select* from dept_emp;

SELECT 
    emp_no, COUNT(emp_no) AS more_contracts
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > '1'
ORDER BY emp_no ASC
limit 100;



SELECT 
    *
FROM
    salaries
ORDER BY salary DESC
LIMIT 10;

select *
from dept_emp
limit 100;








