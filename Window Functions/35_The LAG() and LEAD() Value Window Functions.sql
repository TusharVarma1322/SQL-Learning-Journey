# "VALUE WINDOW FUNCTIONS: LAG() & LEAD()"
# "As opposed to ranking window functions, value window functions return a value that can be found in the database."

# Write a query extracting the follwing information for you:
-- The salary values from all contracts that employee 10001 had ever signed while working for the company (in ascending order).
-- A column showing the previous salary value from our ordered list.
-- A column showing the next salary value from our ordered list.
-- A column displaying the difference between the current and previous salary of a given record from the list.
-- A column displaying the difference between the next and current salary of a given record from the list.


-- Therefore, to solve the given task, we would like to obtain a result set that consists of
-- six columns, starting with the employee number and salary fields and then concluding with four
-- columns that are all derivatives of the salary field.
#Please note that in this lecture we won't order the salaries chronologically by the dates when the respective contracts were signed.
#by saying "previous" or "next" salary, we only refer to their relevant values contained in the "salary" field

SELECT 
    *
FROM
    salaries
LIMIT 10;

-- 1) To solve the given task, we will stick to the syntax including the use of the WINDOW clause
-- 2) We do not need to partition the relevant data anymore (= we can skip using the PARTITION BY clause)


# LAG() returns the value from a specified field of a record that 'precedes' the current row
# 'precedes' = the value that Lags the current value
SELECT
    ...,
    LAG(column_name) OVER () AS ...
FROM
	...;

# LEAD() returns the value from a specified field of a record that 'follows' the current row
#  'follows' = the value that Leads the current value

SELECT
    ...,
    LEAD(column_name) OVER () AS ...
FROM
	...;
  
  
-- Then in the next two fields in our output we need to display two differences.
-- The difference between the employee's current salary and their previous salary as well as the difference between their next salary and their current salary
-- Fortunately, my SQL allows quite an intuitive syntax for such situations to obtain the desired values.
# the qeury
select emp_no,
		salary,
        lag(salary) over w as previous_salary,
        lead(salary) over w as next_salary,
        salary - lag(salary) over w as diff_previous_salary, -- "We can use a mathematical expression in our field list directly!"
		lead(salary) over w - salary as diff_next_salary
from salaries
where emp_no = 10001
window w as (order by salary);



-- Exercise #1
# Write a query that can extract the following information from the "employees" database:
-- the salary values (in ascending order) of the contracts signed by all employees numbered between 10500 and 10600 inclusive
-- a column showing the previous salary from the given ordered list
-- a column showing the subsequent salary from the given ordered list
-- a column displaying the difference between the current salary of a certain employee and their previous salary
-- a column displaying the difference between the next salary of a certain employee and their current salary

# Limit the output to salary values higher than $80,000 only.
# Also, to obtain a meaningful result, partition the data by employee number.

select emp_no,
		salary,
        lag(salary) over w as previous_salary,
        lead(salary) over w as next_salary,
        salary - lag(salary) over w as diff_between_current_salary,
		lead(salary) over w - salary as diff_between_next_salary
from salaries  
where emp_no between 10500 and 10600 and salary > 80000
window w as (partition by emp_no order by salary);

-- Exercise #2
# The MySQL LAG() and LEAD() value window functions can have a second argument, 
# designating how many rows/steps back (for LAG()) or forth (for LEAD()) we'd like to refer to with respect to a given record.
# With that in mind, create a query whose result set contains data arranged by the salary values associated to each employee number (in ascending order).
# Let the output contain the following six columns:
-- the employee number
-- the salary value of an employee's contract (i.e. which we'll consider as the employee's current salary)
-- the employee's previous salary
-- the employee's contract salary value preceding their previous salary
-- the employee's next salary
-- the employee's contract salary value subsequent to their next salary

# Restrict the output to the first 1000 records you can obtain.

select emp_no,
		salary,
        lag(salary) over w as previou_salary,
        lag(salary) over w - lag(salary) over w as preceding_previous_salary,
        lead(salary) over w as next_salary,
        lead(salary) over w - lead(salary) over w as subsequent_next_salary
from salaries 
window w as (partition by emp_no order by salary )
limit 1000;

#LAG(..., 2) is what gets you the "preceding previous" (2 steps backward / in the past).
#LEAD(..., 2) gets you the "subsequent to next" (2 steps forward / in the future).
-- use this
SELECT

emp_no,

    salary,

    LAG(salary) OVER w AS previous_salary,

LAG(salary, 2) OVER w AS 1_before_previous_salary,

LEAD(salary) OVER w AS next_salary,

    LEAD(salary, 2) OVER w AS 1_after_next_salary

FROM

salaries

WINDOW w AS (PARTITION BY emp_no ORDER BY salary)

LIMIT 1000

#The 3 Arguments of LAG/LEAD
#You can actually pass up to three arguments to these functions, though usually, we only see the first one.

-- "LAG(column_name, offset, default_value)"

1. Column Name: The value you want to retrieve (e.g., salary).
2. Offset (The one you noticed): How many rows to jump.
 -- >If you omit this, it defaults to 1.
-- >If you write 2, it jumps 2 rows.
-- >If you write 12, it jumps 12 rows (great for Year-Over-Year monthly comparisons!).
3. Default Value (Optional): What to return if the function goes "off the edge" of the partition.
-- >Usually, this returns NULL (as seen in the previous exercise).
-- >However, you can specify 0 or 'No Record' instead of NULL.



















