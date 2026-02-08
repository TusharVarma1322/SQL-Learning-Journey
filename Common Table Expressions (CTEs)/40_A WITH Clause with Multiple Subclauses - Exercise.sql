#  "A WITH Clause with Multiple Subclauses - Exercise"

# Exercise #1: Use two common table expressions and a SUM() function in the SELECT 
--             statement of a query to obtain the number of male employees whose highest salaries have
--             been below the all-time average.

select avg(salary) as avg_salary from salaries; -- 'ALL TIME AVERAGE SALARY'

select e.emp_no, max(s.salary) as m_emps_highest_salaries -- 'MALE EMPLOYEES HIGHEST SALARIES'
from employees e
join salaries s on e.emp_no = s.emp_no and gender = 'm'
group by e.emp_no;

with cte1 as (select avg(salary) as avg_salary from salaries)
,
cte2 as(select e.emp_no, max(s.salary) as m_emps_highest_salaries 
from employees e
join salaries s on e.emp_no = s.emp_no and gender = 'm'
group by e.emp_no
)
select sum(case 
			when c2.m_emps_highest_salaries < c1.avg_salary then 1
            else 0
            end) as m_emps_highest_salaries_below_average
		
from employees e
join cte2 c2 on e.emp_no = c2.emp_no
cross join cte1 c1;


#Exercise #2: Use two common table expressions and a COUNT() function in the SELECT
 --           statement of a query to obtain the number of male employees whose highest salaries have
 --           been below the all-time average.

SELECT 
    AVG(salary) AS avg_salary
FROM
    salaries;

SELECT 
    e.emp_no, MAX(s.salary) AS highest_m_emp_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no AND gender = 'm'
GROUP BY e.emp_no
ORDER BY e.emp_no ASC;

with cte1 as (SELECT 
    AVG(salary) AS avg_salary
FROM
    salaries),
    cte2 as(SELECT 
    e.emp_no, MAX(s.salary) AS highest_m_emp_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no AND gender = 'm'
GROUP BY e.emp_no
ORDER BY e.emp_no ASC)
select count(case
				when c2.highest_m_emp_salary < c1.avg_salary then c2.highest_m_emp_salary
                else null 
                end) as highest_m_employees_salary_below_avg
from employees e
join cte2 c2 on e.emp_no = c2.emp_no
cross join cte1 c1;

#Exercise #3: Does the result from the previous exercise change if you used the Common Table 
--            Expression (CTE) for the male employees' highest salaries in a FROM clause, as opposed to in a join?

with cte1 as (SELECT 
    AVG(salary) AS avg_salary
FROM
    salaries) 
select sum(case
			when a.highest_m_emp_salary < c1.avg_salary then 1 
            else 0 
            end) as m_emp_highest_salary_below_avg_salary
from employees e 
join (SELECT 
    e.emp_no, MAX(s.salary) AS highest_m_emp_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no and gender = 'm'
GROUP BY e.emp_no
ORDER BY e.emp_no) as a on e.emp_no = a.emp_no               # what i tried
cross join 
cte1 c1;


WITH cte_avg_salary AS (

SELECT AVG(salary) AS avg_salary FROM salaries

),

cte_m_highest_salary AS (                                    # what was asked in Q3 

SELECT s.emp_no, MAX(s.salary) AS max_salary

FROM salaries s JOIN employees e ON e.emp_no = s.emp_no AND e.gender = 'M'

GROUP BY s.emp_no

)

SELECT

COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS max_salary

FROM cte_m_highest_salary c2

JOIN cte_avg_salary c1

