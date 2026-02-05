#MySQL Common Table Expressions - Introduction

#In SQL, every query–and sometimes part of a query or subquery–produces a result or a temporary dataset.

#A Common Table Expression (CTE) is a tool for obtaining such temporary result sets that exist within 
#the execution of a given query

-- In other words, their temporary result set cannot be referred to in a query other than the
--  one they've been created.


#Question: 
-- How many salary contracts signed by female employees have been valued
 -- above the all-time average contract salary value of the company?

#Dataset #1: a list of all contracts signed by female employees from the company's history

#Dataset #2: a single all-time average value

-- To obtain the answer, you need two data sets,Only. Then could you compare each value from the
-- former subset to the single value.

USE employees;

SELECT 
    AVG(salary) AS avg_salary
FROM
    salaries;
    
# "task, you won't necessarily need to store that single value in a separate data table
-- that can later join the relevant subset from the salary table. 
-- Instead you can use a CTE to obtain and work with the all time average value within the execution scope of a query."

#"In other words, you can use a single query to make the required comparison between each relevant contract salary value
-- and the all time average."


#"How can this be done? You first need to use a WITH clause followed by the name of the CTE.
-- For simplicity, let's call the given common table expression CTE. Next, use the AS keyword
-- before placing the query just ran to obtain the all-time average contract salary value in
-- parentheses. Technically, you have the subquery part of the CTE in these parentheses (or the
-- subclause of the WITH clause). This part of the CTE produces its result set; moreover,
-- remember that you won't need to use the statement terminator before closing the parentheses."

WITH cte_name AS (SELECT ... FROM...) = the subquery part of the CTE  = the subclause of the WITH clause -> produces the result set of the CTE
SELECT
 ...									
 FROM 
	cte_name...;


#"Now that we finished specifying the common table expression we name cte, we could for
-- example refer to it in an INSERT, UPDATE, or DELETE statement. This time, however, [we] will
-- use a SELECT statement, since it's probably the type of statement you'll mostly use in
-- combination with CTEs."

#"Having chosen the type of statement after specifying the CTE, we can designate our data
-- sources in the FROM clause. Doing this before completing the relevant field list of the select
-- statement will help us stay focused on how CTS work behind the scenes."

FROM
    salaries s
    JOIN
    employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
    CROSS JOIN
    cte c;


with cte as(
select avg(salary) as avg_salary from salaries)
select
sum(case when s.salary > c.avg_salary then 1 else 0 end) as No_f_salaries_above_avg,
count(s.salary) as Total_no_salary_contracts
from salaries
join employees e on s.emp_no = e.emp_no and gender = 'f'
cross join 
cte c;

#"We must clear any doubts about the data set we will be working with first, 
-- so let's not rush into adding the field list of the select statement,
-- because if we only have the CTE in the from clause, we'll obtain a single all-time average value." 

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT
    *
FROM
    cte;

#"Then if we join this output to the data from the salaries table by using S. And C. As aliases.
-- We'll have the average value added in a separate column to every record from the salaries table."

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT
    *
FROM
    salaries s
        JOIN
    cte c;

#"Finally, joining this data with the subset of the employees table will reduce the same content to only the female workers
-- , adding their first and last names, birthdates, gender, and hire dates to the result set. 
-- Remember that MySQL interprets a JOIN used without an ON keyword as a CROSS JOIN."

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT
    *
FROM
    salaries s
        JOIN 
        employees e on s.emp_no = e.emp_no and gender = 'f'
        join
    cte c;


#"Now we're ready to focus on creating the field list of our select statement. 
-- We need to count the number of those contracts from the data set."
-- We have defined whose salary values are lower than the company average
-- One way to do that is to use a sum function whose arguments should be a case statement providing the value of one.
-- If the salary value from the salaries table is higher than the average salary value obtained by the CTE, [then one], and zero [otherwise].

WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT
    SUM(CASE
        WHEN s.salary > c.avg_salary THEN 1
        ELSE 0
    END) AS no_f_salaries_above_avg
FROM
    salaries s
    JOIN
    employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
    CROSS JOIN cte c;  


#"First, a good practice would be to add the total number of salary contracts to our output,
-- since the all-time average value has been based on that number. 
-- To do so, we can use the COUNT aggregate function and assign an alias
-- of 'total number of salary contracts' to the relevant field.
-- Execute now; we can better understand the proportion of the total number of contracts signed by women
-- and valued higher than the average. "


WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT
    SUM(CASE
        WHEN s.salary > c.avg_salary THEN 1
        ELSE 0
    END) AS no_f_salaries_above_avg,
    count(s.salary) as total_no_f_contracts
FROM
    salaries s
    JOIN
    employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
    CROSS JOIN cte c; 

#Secondly, if you still have doubts about the purpose of using C.T.E.s, 
-- remember that the same output can be obtained if we move the sub clause 
-- of our C.T.E. to a sub query in the outer select statement.
-- We can join the temporary results set obtained by the sub query with the salaries
-- and employees tables as usual to obtain the desired output.


SELECT
    SUM(CASE
        WHEN s.salary > a.avg_salary THEN 1
        ELSE 0
    END) AS no_f_salaries_above_avg,
    count(s.salary) as total_no_f_contracts
FROM
    salaries s
    JOIN
    employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
    CROSS JOIN (
SELECT AVG(salary) AS avg_salary FROM salaries) a; 



