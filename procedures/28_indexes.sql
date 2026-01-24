# How many people have been hired after the 1st of january 2000 ?

SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';

-- it took 0.266 sec / 0.000 sec without indexes

create index i_hire_date
on employees(hire_date);

# composite indexes - Applied on multiple columns for optimized search

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'georgi'
        AND last_name = 'facello'; 

create index i_composite
on employees(first_name,last_name);

-- There are other indexes like primary key and unique key
-- to view indexes you created or check the indexes use info icon on database or table,
-- write 

show index from employees from employees;


drop index i_hire_date on employees;

select * from salaries where salary > 89000;

create index i_salary on salaries (salary);