# Lecture Summary: Using Multiple Subclauses in a WITH Clause
# This lecture demonstrates that Common Table Expressions (CTEs) can utilize multiple subclauses within a single WITH clause.
# To illustrate this technique, the session focuses on answering a specific data query:

# "How many female employees' highest contract salary values were higher than the all-time company salary average across all genders?"

-- To solve this, the query is structured using two distinct subclauses:

-- Subclause #1: A CTE designed to compute the all-time company salary average.

-- Subclause #2: A CTE designed to obtain a list containing the highest contract salary values for all female employees.

-- The final task filters these results to identify only those cases where an individual’s peak salary exceeded the company-wide average.


# "To dissect the assignment, we'll use one sub-clause of our WITH clause to represent the CTE computing the all-time average 
# and another to obtain a list containing the highest contract salary values of all female employees who have worked in the company.
-- Then we'll compare each salary value we retrieved from the second CTE to the all-time average obtained by the first CTE 
-- and count the number of occurrences when a salary value is higher than that average."

with cte1 as(select avg(salary) avg_salary from salaries),
cte2 as (select max(salary) as max_salary
from salaries s
join employees e on e.emp_no = s.emp_no and gender = 'f')
select sum(case 
			when c1.avg_salary < c2.max_salary then 1  else 0 end ) as highest_f_avg_salary,
		count(s.salary) as total_f_contracts
from salaries s
join employees e on e.emp_no = s.emp_no and gender = 'f'
cross join cte1 c1
cross join cte2 c2;
 
 
#"So let's get things going well. Stick to a step by step approach first,

-- preparing the select statements that will use within the sub clause.

-- The all time average can be obtained by executing this straight forward select statement

-- employing the average aggregate function, the value obtained approximate."

SELECT 

    AVG(salary) avg_salary
    
FROM

    salaries;

-- "Then we need a second SELECT statement to obtain the highest contract salary values of all
-- female employees who have worked in the company. We can do this by joining the salaries and
-- employees tables and using the MAX aggregate function in the field list.

-- Furthermore, remember to add a condition stipulating that we are only interested in data about
-- female employees. As a reminder, when we use an inner join, adding a condition to the ON
-- clause that is not related to the matching columns of the tables can do the same job as adding
-- that condition in the query's WHERE clause."

SELECT 
    s.emp_no, MAX(salary) AS max_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'
GROUP BY s.emp_no;

SELECT 
    s.emp_no, MAX(s.salary) AS max_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no
WHERE
    e.gender = 'f'
GROUP BY s.emp_no
;

with cte1 as(SELECT 

    AVG(salary) avg_salary
    
FROM

    salaries),
cte2 as (SELECT 
    s.emp_no, MAX(s.salary) AS max_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'
GROUP BY s.emp_no)
select sum(case 
			when c2.max_salary  < c1.avg_salary then 1  else 0 end ) as highest_f_avg_salary
from employees e
join cte2 c2 on c2.emp_no = e.emp_no
cross join cte1 c1
;
