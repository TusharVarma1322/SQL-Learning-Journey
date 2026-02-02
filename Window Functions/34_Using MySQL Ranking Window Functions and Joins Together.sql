# Using MySQL Ranking Window Functions and Joins Together
use employees;


# Create a query that will complete all the following subtasks at once:
-- Obtain data only about the managers from the "employees" database.
-- Partition the relevant information by the department where the managers have worked in.
-- Arrange the partitions by the managers' salary contract values in descending order.
-- Rank the managers according to their salaries in a certain department (where you prefer to not lose track of the number of salary contracts signed within each department).
-- Display the start and end dates of each salary contract (call the relevant fields salary_from_date and salary_to_date, respectively).
-- Display the first and last date in which an employee has been a manager, according to the data provided in the dept_manager table (call the relevant fields dept_manager_from_date and dept_manager_to_date, respectively).


select d.dept_no,
		d.dept_name,
        dm.emp_no,
        rank()over w as department_salary_ranking,
        s.salary,
        s.from_date as salary_from_date  ,
        s.to_date as salary_to_date,
        dm.from_date as dept_manager_from_date,
        dm.to_date as dept_manager_to_date
from dept_manager dm 
join salaries s on dm.emp_no = s.emp_no
join departments d on dm.dept_no = d.dept_no
window w as (partition by dm.emp_no order by s.salary desc);

-- some of the obtained salary values may have been taken from periods when these people had occupied different positions in the business
-- there are too many records
-- see the 110022 start date is > than dept_manager_to_date
-- use 'AND' in s.salary on statement

select d.dept_no,
		d.dept_name,
        dm.emp_no,
        rank()over w as department_salary_ranking,
        s.salary,
        s.from_date as salary_from_date  ,
        s.to_date as salary_to_date,
        dm.from_date as dept_manager_from_date,
        dm.to_date as dept_manager_to_date
from dept_manager dm 
join salaries s on dm.emp_no = s.emp_no
and s.from_date between dm.from_date and dm.to_date
and s.to_date between dm.from_date and dm.to_date
join departments d on dm.dept_no = d.dept_no
window w as (partition by dm.emp_no order by s.salary desc);


# Exercise #1:
-- Write a query that ranks the salary values in descending order of all contracts signed by
-- employees numbered between 10500 and 10600 inclusive. Let equal salary values for one and
-- the same employee bear the same rank. Also, allow gaps in the ranks obtained for their
-- subsequent rows.

-- Use a join on the “employees” and “salaries” tables to obtain the desired result.

select e.emp_no,
		s.salary,
        rank()over w as rank_num
from employees e
join salaries s on e.emp_no = s.emp_no 
where e.emp_no between 10500 and 10600
window w as (partition by e.emp_no order by salary desc);


# Exercise #2:
-- Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:
-- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.
-- contracts that have been signed at least 4 full-years after the date when the given employee was hired in the company for the first time.
-- In addition, let equal salary values of a certain employee bear the same rank. Do not allow gaps in the ranks obtained for their subsequent rows.
-- Use a join on the “employees” and “salaries” tables to obtain the desired result.

select e.emp_no,
		s.salary,
        dense_rank()over w as dense_rank_rum,
        e.hire_date as employees_hire_date,
        s.from_date as employees_from_date,
        s.to_date as employeees_to_date
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no between 10500 and 10600  
window w as (partition by e.emp_no order by s.salary) ;

-- USE this one
SELECT

    e.emp_no,

    DENSE_RANK() OVER w as employee_salary_ranking,

    s.salary,

    e.hire_date,

    s.from_date,

    (YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start

FROM

employees e

JOIN

    salaries s ON s.emp_no = e.emp_no

    AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5

WHERE e.emp_no BETWEEN 10500 AND 10600

WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);




