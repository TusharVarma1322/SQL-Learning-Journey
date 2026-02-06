# 'CTEs Exercises'


#Exercise #1:

-- Use a CTE (a Common Table Expression) and a SUM() function in the SELECT statement 
-- in a query to find out how many salary contracts signed by male employees had a salary
-- value below or equal to the all-time company average. In this task, a salary contract
-- is defined as any record in the salaries table.

select avg(salary) as all_time_avg_salary from salaries ;

with cte as(select avg(salary) as avg_salary from salaries)
select 
sum(case 
	when s.salary <= c.avg_salary then 1 else 0 end) as all_time_salart_contract_m_emp,
count(s.salary) as total_no_salaries
from salaries s
join employees e on e.emp_no = s.emp_no and e.gender ='M'
cross join
cte c;

#Exercise #2:

-- Use a CTE (a Common Table Expression) and at least one COUNT() function in the SELECT statement 
-- of a query to determine how many salary contracts signed by male employees had a salary value below or
-- equal to the all-time company salary average. In this task, a salary contract is defined as any record
-- in the salaries table.

with cte as(select avg(salary) as avg_salary from salaries)
select count(case 
		when s.salary < c.avg_salary then s.salary else null end)as all_time_average_m_emp_count,
		count(s.salary) as total_no_salary_count
from salaries s 
join employees e on e.emp_no = s.emp_no and e.gender ='m'
cross join
cte c;



#Exercise #3:

-- Use MySQL joins (and don’t use a Common Table Expression) in a query
-- to find out how many male employees have never signed a contract
-- with a salary value higher than or equal to the all-time company salary average
-- (i.e. to obtain the same result as in the previous exercise).

select
sum(case when s.salary <= a.avg_salary then 1 else 0 end ) as sum_of_m_emp
from salaries s 
join employees e  on e.emp_no = s.emp_no and e.gender = 'm'
cross join
(select avg(salary) as avg_salary from salaries) as a;


#Exercise #4:

-- Use a cross join in a query to find out how many male employees have never signed a contract
-- with a salary value higher than or equal to the all-time company salary average 
-- (i.e. to obtain the same result as in the previous exercise).


WITH cte_avg AS (
    SELECT AVG(salary) AS avg_salary FROM salaries
),
cte_max_salaries AS (
    SELECT 
        e.emp_no, 
        MAX(s.salary) AS max_salary
    FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE e.gender = 'M'
    GROUP BY e.emp_no
)
SELECT 
    COUNT(m.emp_no) AS no_m_emp_never_signed_high_contract
FROM cte_max_salaries m
CROSS JOIN cte_avg a
WHERE m.max_salary < a.avg_salary;