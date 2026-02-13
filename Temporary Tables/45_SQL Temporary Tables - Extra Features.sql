use employees ;

drop TABLE IF exists f_highest_salaries;

create temporary table f_highest_salaries
SELECT 
    s.emp_no, MAX(s.salary) AS f_highest_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'  
GROUP BY s.emp_no
ORDER BY s.emp_no ASC
limit 10;

select* from f_highest_salaries;

# When a temporary table is used, it is locked-for-use

-- = it can be invoked only once

#  In other words, when the select statement referring to the temporary tables executed,
-- And so we cannot use this tool in self joins nor with a union or union all
-- operators in any of these attempts, we would encounter an air message stating that
-- my "SQL can't reopen table F_one."
-- "It should now be clear that we cannot invoke a temporary table twice within a query."



# "Is there a workaround? In a way, there is, and it requires using a common table expression instead 
-- of directly creating a second virtual table and the self join or using the union or union all operators
-- In other words, we can have the same select statement we use for creating the f highest salaries 
-- temporary table as a sub clause of the with statement in a query for simplicity; let's name the common table expression CTE
-- Then outside the WITH statement, we can join F highest salaries and ct, as we would have ideally joined to virtual tables based on F highest salaries."
with cte as (SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'  
GROUP BY s.emp_no
ORDER BY s.emp_no ASC
limit 10) select * from f_highest_salaries join cte c;


with cte as (SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM
    salaries s                                                   -- After executing the query, we can observe the retrieved results and 
        JOIN                                                     -- confirm that we have obtained an output referring to using a self-join;
    employees e ON e.emp_no = s.emp_no AND gender = 'f'          -- analogously, we can apply the same trick when working with a union or
GROUP BY s.emp_no												 -- even better a union all statement.
ORDER BY s.emp_no ASC
limit 10) select * from f_highest_salaries union all select * from cte c;

#  But why did we say just a minute ago that CTEs can act as a substitute for self joints or union
-- statements? Only in a way. The reason is that if we try to imitate using a self join or union
-- operators to combine data from a table containing data that varies upon the moment the table was
-- created or filled with information, then CTEs will not help.


# TASK: Create a temporary table called 'dates', which contains the following three DATETIME values:

-- The current date and time

-- A month earlier than the current date and time

-- A year later than the current date and time


# "We will use the well known now function to obtain the first value, but we'll use the date sub function
-- for the 2nd and 3rd values which takes a starting date or date time value as the first argument. Then,
-- as a second argument after using the keyword interval, we can designate a unit value in a specified time
-- interval such as day, month or year to indicate how many units of that time interval we'd like to retrieve
-- the date time value to differ from the one we provided in the first argument for instance to obtain a date
-- and time a month earlier than the current ones we can use now as a function for acquiring the current date and 
-- time, right interval and then specify month as a time interval of interest. Then there is one peculiarity to be
-- careful about the value we need to insert here is one although we want to go back a month earlier. The reason is
-- that this function is programmed to read the designated value as the number of intervals to be subtracted out of
-- the date. To be modified In the sameway to determine the value a year later from the current date and time. We need
-- to use date sub with the now function and interval -1 year as its arguments. Let's not forget that. We wanted 
-- store the output in a temporary table called dates to do that. We can write the relevant name and keywords on top of 
-- these expressions and run the query to create the temporary object."


create temporary table dates
select
now() as current_date_and_time,
date_sub(now(),interval 1 month) as a_month_earlier,
date_sub(now(),interval -1 year) as a_year_later;

select * from dates;

# We can easily prove that using a self join or a union all operator won't work.

SELECT 
    *
FROM
    dates d1
        JOIN
    dates d2;

SELECT 
    *
FROM
    dates d1 
UNION SELECT 
    *
FROM
    dates d2;
    
# "Let's try out the workaround. Use the same select statement we use for creating the dates 
-- temporary table as a sub clause of the with statement. In a query for simplicity, let's name 
-- the common table expression. CTE once again next outside the with statement join dates and C.T.E
-- As we would have ideally joined to virtual tables based on dates observing the output We acquired
-- the date and time values as desired. 

with cte as(select
now() as current_date_and_time,
date_sub(now(),interval 1 month) as a_month_earlier,
date_sub(now(),interval -1 year) as a_year_later)
select * from dates d1 join cte c;




# In the same way we can use a union operator. Once again we can
-- use the relevant select statement in the sub clause of a with clause and then unify dates and CTE.
-- In this case we will organize the output values vertically. We've reached the point where we can
-- clarify why CTE can act as a substitute for self joins or union statements only in a way by observing our output.

with cte as(select
now() as current_date_and_time,
date_sub(now(),interval 1 month) as a_month_earlier,
date_sub(now(),interval -1 year) as a_year_later)
select * from dates d1 union select * from cte c;




-- Error Code: 1137. Can't reopen table: 'd1'. If we wanted to use data sets that don't change over time, such as
-- highest salaries, common table expressions would have acted as a perfect substitute for self joins and union
-- statements to keep working with the employees database as before. Let's conclude the lesson by dropping the 
-- highest salaries and dates tables. After we've done this, you can execute the classical select statements written above to


drop table f_highest_salaries;

drop table dates;