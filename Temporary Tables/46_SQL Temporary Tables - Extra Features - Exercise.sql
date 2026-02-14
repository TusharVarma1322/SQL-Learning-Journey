# Exercise #1:
-- Create a temporary table called dates containing the following three columns:
-- one displaying the current date and time,
-- another one displaying two months earlier than the current date and time, and a
-- third column displaying two years later than the current date and time.

create temporary table dates
select 
now() as a_current_date_time,
date_sub(now(),interval 2 month) as 2_months_earlier_from_current_time,
date_sub(now(),interval -2 year) as 2_years_later_from_current_time;


# Exercise #2:
-- Write a query that, upon execution, allows you to check the result set contained in
-- the dates temporary table you created in the previous exercise.


SELECT 
    *
FROM
    dates;

# Exercise #3:
-- Create a query joining the result sets from the dates temporary table you created during
-- the previous lecture with a new Common Table Expression (CTE) containing the same columns.
-- Let all columns in the result set appear on the same row.


with cte as(select 
now() as a_current_date_time,
date_sub(now(),interval 2 month) as 2_months_earlier_from_current_time,
date_sub(now(),interval -2 year) as 2_years_later_from_current_time)
select * from dates d1 join cte c;

# Exercise #4:
-- Again, create a query joining the result sets from the dates temporary table you created 
-- the previous lecture with a new Common Table Expression (CTE) containing the same columns. 
-- This time, combine the two sets vertically.

with cte as(select 
now() as a_current_date_time,
date_sub(now(),interval 2 month) as 2_months_earlier_from_current_time,
date_sub(now(),interval -2 year) as 2_years_later_from_current_time)
select * from dates d1 union all select * from cte c;


# Exercise #5:
-- Drop the male_max_salaries and dates temporary tables you recently created.

drop temporary table dates;