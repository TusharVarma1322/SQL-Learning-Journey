# Exercise 1:

-- Considering the salary contracts signed by female employees in the company, how
-- many have been signed for a value below the average? Store the output in a column
-- named no_f_salaries_below_avg. In a second column named total_no_of_salary_contracts,
-- provide the total number of contracts signed by all employees in the company.

-- Use the salary column from the salaries table and the gender column from 
-- the employees table. Match the two tables on the employee number column
-- (emp_no).



WITH cte AS (
    SELECT AVG(salary) AS avg_salary FROM salaries
),
cte2 AS (
    SELECT COUNT(salary) AS total_no_of_salary_contracts FROM salaries
)
SELECT
    SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_f_salaries_below_avg,
    (SELECT total_no_of_salary_contracts FROM cte2) AS total_no_of_salary_contracts
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
JOIN cte c;


# Exercise 2:
-- Considering the salary contracts signed by male employees in the company, how
-- many have been signed for a value above the average? Store the output in a column
-- named no_m_salaries_above_avg. In a second column named total_no_of_salary_contracts,
-- provide the total number of contracts signed by all employees in the company.

-- Use the salary column from the salaries table and the gender column from the employees table.
-- Match the two tables on the employee number column (emp_no).


with cte1 as ( select avg(salary) as avg_salary from salaries ),
cte2 as (select count(e.emp_no) as total_no_of_salary from salaries s join employees e on s.emp_no = e.emp_no )
select sum(case
			when s.salary < c1.avg_salary then 1 else 0 end),
		(select total_no_of_salary from cte2) as total_no_of_salary_contracts
        from salaries s
        join employees e on e.emp_no = s.emp_no and e.gender= 'm'
        cross join cte1 c1;

# Exercise 3:
-- How many women (employees.gender = 'F') in the company have their 
-- highest salary contract below the company average? Store your output in a
-- column named highest_f_salaries_below_total_avg.

-- Use the salary column from the salaries table and the gender
-- column from the employees table. Match the two tables on the employee
-- number column (emp_no).

with cte1 as(select avg(salary) as avg_salary from salaries),
cte2 as(select emp_no , max(salary) as max_salary from salaries group by emp_no)
select sum(case
			when c2.max_salary < c1.avg_salary then 1 else 0
            end) as highest_f_salaries_below_total_avg
from employees e 
join cte2 c2 on e.emp_no = c2.emp_no and e.gender = 'f'
cross join cte1 c1;
select emp_no , max(salary) as max_salary from salaries group by emp_no;