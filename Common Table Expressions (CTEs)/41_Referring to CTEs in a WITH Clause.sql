# Referring to CTEs in a WITH Clause

-- We can use multiple CTEs in a query, referencing them numerous times

-- → We can refer to a CTE defined earlier within a WITH clause

-- → We cannot refer to one that has been defined after

-- → "the second CTE in a query can reference the first one, but this is not true vice versa"


# Task: 
-- retrieve the highest contract salary values of all employees hired in 2000 or later



SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';


with emp_hired_from_jan_2000 as(SELECT 
    *
FROM
    employees e
WHERE
    hire_date > '2000-01-01'),
    
highest_contract_salary_values as 
(select s.emp_no , max(s.salary)

 from salaries s
 
 join emp_hired_from_jan_2000 e on s.emp_no = e.emp_no
 
 group by s.emp_no)
 
select * 
from highest_contract_salary_values;


# NOTE:         "→ We cannot refer to one that has been defined after"
-- e.g. see below

with highest_contract_salary_values as 
(select s.emp_no , max(s.salary)

 from salaries s
 
 join emp_hired_from_jan_2000 e on s.emp_no = e.emp_no
 
 group by s.emp_no),
 emp_hired_from_jan_2000 as(SELECT 
    *
FROM
    employees e
WHERE
    hire_date > '2000-01-01')
 
select * 
from highest_contract_salary_value



# MySQL Common Table Expressions (CTEs) Summary Notes:
 -- → They are a tool providing temporary result sets that exist within the execution of a given query

--  → They are written in the WITH clause of a query

--  → A CTE can contain multiple subclauses (subqueries of the CTE)

--  → A CTE can be referenced multiple times within a query

--  → We can refer to a common table expression defined earlier within a given WITH clause.
--    We cannot refer to one that has been defined after.




