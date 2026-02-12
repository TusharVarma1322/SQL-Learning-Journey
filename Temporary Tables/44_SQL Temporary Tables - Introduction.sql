 # MySQL Temporary Tables
# hold temporary result sets during a MySQL session

-- used “at the back” when executing, for example, ALTER TABLE or SELECT DISTINCT statements.

-- they could be beneficial if we need to refer to a specific result set 'multiple times' in our analysis - which is what we typically do in a single MySQL session.

-- 																				↓

-- particularly convenient when our default database is vast (we can refer to the given temporary table directly at a lower query cost).


# "ephemeral" data handling:

-- Each query (or subquery) in SQL produces a temporary dataset.

-- Only the data in our default database is permanent, unless we drop some of its tables or the database itself.

-- We can use JOINs to combine data from multiple regular tables.

-- We can also employ subqueries to create temporary result sets and reuse them for further computations and manipulations.

-- MySQL window functions – their partitions can be used to run a specific window function.

-- MySQL Common Table Expressions (CTEs) can also hold temporary result sets.



# Task: Obtain a list containing the highest contract salary values signed by all female employees who have worked in the company

use employees;

SELECT 
    s.emp_no, MAX(s.salary) AS f_highest_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'     -- "So imagine you will need to refer to this list later in our MySQL session or,
                                                            --  conceptually speaking, later in your work."
GROUP BY s.emp_no
ORDER BY s.emp_no ASC;

# In that case, we can avoid referring to the permanent salaries and employees
-- tables each time we need such a reference, as this might be costly in terms
-- of computational time.
# In certain situations, instead we can store the output we just obtained in a temporary table.
# We can achieve this by adding CREATE TEMPORARY TABLE on the top of the query and assigning a temporary table name.


CREATE TEMPORARY TABLE temporary_table_name
SELECT
    ...
FROM
    ...
;

create temporary table f_highest_salaries
SELECT 
    s.emp_no, MAX(s.salary) AS f_highest_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'  
GROUP BY s.emp_no
ORDER BY s.emp_no ASC;


SELECT                               -- Furthermore, remember that a temporary table can be used like any other table from
      *                              -- the default database during the MySQL session it has been created in. Therefore, we
 FROM                                -- can be more specific when referring to it.
      f_highest_salaries;

  
SELECT 
    *
FROM
    f_highest_salaries                # "temporary tables can be referenced in queries that are a lot more complex"
WHERE
    emp_no <= 10010;

# MySQL Temporary Tables
-- Can be used like any other table from the default database during the MySQL session it has been created in.

-- Can be dropped (deleted manually if no longer needed).

-- Are valid only within the scope of a MySQL session and not beyond (they are automatically deleted when the connection is closed).

drop table f_highest_salaries;

select * from f_highest_salaries;

-- TRY RECONNECT USING THE ICON 'RECONNECT TO DBMS' and you can see temporary table won't work as it's an new session and temporary table was in previous session

# Exercise #1:
-- Store the highest contract salary values of all male employees in a
-- temporary table called male_max_salaries.

CREATE TEMPORARY TABLE male_max_salaries
SELECT 
    s.emp_no, MAX(s.salary) AS m_highest_salaries
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'm'
GROUP BY s.emp_no
ORDER BY s.emp_no ASC;

select * from male_max_salaries;


# Exercise #2:
 -- Write a query that, upon execution, allows you to check the result set 
 -- contained in the male_max_salaries temporary table you created in the 
 -- previous exercise.

select * from male_max_salaries;



