-- GROUP BY: 
SELECT 
    emp_no,
    round(avg(salary),0) AS salary,	-- Grabs the highest value found
    min(from_date) AS from_date,	-- Grabs the earliest date found
    MAX(to_date) AS to_date			-- Grabs the latest date found
FROM
    salaries
GROUP BY emp_no ;

-- PARTITION BY:
select emp_no,
		salary, 
        row_number()over(partition by emp_no order by salary desc) as row_num
from salaries;

# USE of both GROUP BY & PARTITION BY in an same query
-- ROW_NUMBER RANKING WINDOW FUNCTION inside an subquery , of 'WINDOW' key word.
select a.emp_no,
max(salary)
from(select emp_no,
		salary,
        row_number()over w as row_num
        from salaries
        window w as (partition by emp_no order by salary desc)) as a
group by emp_no;

-- ROW_NUMBER RANKING WINDOW FUNCTION inside an subquery, 'DIRECT' method.

select a.emp_no,
max(salary) as max_salary
from(select emp_no,
		salary,
        row_number()over(partition by emp_no order by salary desc) as row_num
        from salaries
         ) as a
group by emp_no;


-- USE of 'WHERE CLAUSE'  
# Why to use where clause if we want highest value we can get that with group by max function
-- Because what if we may sometimes wants to obtain different values from the partition
-- That is we may not always be interested in highest or lowest values
select a.emp_no,
max(salary)
from(select emp_no,
		salary,
        row_number()over w as row_num
        from salaries
        window w as (partition by emp_no order by salary desc)) as a
where a.row_num = 1 -- can change the row_num ,suppose if we want 2nd highest, 8th highest, 11 highest salary anyone within partition range
group by a.emp_no;


select a.emp_no,
		min(salary)as min_salary
        from(select emp_no,
		salary,
        row_number()over()as row_num
        from salaries
        window w as (partition by emp_no order by salary )) as a 		-- WINDOW MEDTHOD
group by emp_no
order by emp_no;
        

select a.emp_no,
		min(salary)as min_salary
        from(select emp_no,
		salary,
        row_number()over(partition by emp_no order by salary) as row_num    -- DIRECT METHOD
        from salaries) as a
group by emp_no
order by emp_no;


select a.emp_no,
		min(salary)as min_salary
        from(select emp_no,
		salary                                      -- withot window function
        from salaries) as a
group by emp_no
order by emp_no;



select a.emp_no, salary as min_salary
from(select emp_no,
			salary,
            row_number()over w as row_num
            from salaries                                                        
            window w as(partition by emp_no order by salary)) as a  -- WITHOUT USE OF GROUP BY CLAUSE , as ranking is done by asc that means 1st rank is lowest
where a.row_num = 1                                  
order by emp_no asc;



select a.emp_no, min(salary) as min_salary
from(select emp_no,
			salary,
            row_number()over w as row_num        
            from salaries                                   
            window w as(partition by emp_no order by salary)) as a
where row_num = 2                                                        -- where clause use case
group by emp_no
order by emp_no asc
;





