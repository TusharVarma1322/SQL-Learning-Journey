USE EMPLOYEES;

select emp_no,
		salary,
        row_number()over w as row_num
        from salaries
        where emp_no = 11839
        window w as (partition by emp_no order by salary desc);
        
# What if some of the salaries values were identical ?
# = what if an employee has signed two or more contracts at same value, Albeit related to different periods ?

select emp_no,
count(salary)-count(distinct salary) as diff
from salaries
group by emp_no
having diff > 0
order by emp_no;


select*
from salaries
where emp_no= 11839;


select emp_no,
		salary,
        rank()over w as rank_num
        from salaries
        where emp_no = 11839
        window w as (partition by emp_no order by salary desc);

-- what rank values are assigned to the records subsequent to the records,
-- with an identical value?
-- Simple words see what rank values are assigned to the 5 th , 6 th and uptill  12 th value
# "This means that the rank window function counts each record from the given output separately."
# "Thus two records containing identical salary values will augment the rank of their"
# "subsequent record by the value of two,"
# "Analytically speaking, When using RANK the focus is on the 'number of values' we have in our output.
-- If there were not just two but three records with salary value of $89,814, the next record would have been assigned a value of 6.
-- Since that would have been the sixth record in the list we'd obtained.


#  " DENSE RANK"
-- "What if you wanted to focus rather on the ranking of the salary values itself,"
-- "Then you'd like the fifth record to be ranked as number four,"
-- "If that's the case. The ranking window function you need is dense rank "
-- "You can see after the identical values of 3 we have 4 not 5 , And last value has been '11' NOT '12' "
select emp_no,
		salary,
        dense_rank()over w as dense_rank_num
        from salaries
        where emp_no = 11839
        window w as (partition by emp_no order by salary desc);

# Summary:
-- Rule:

-- "- RANK() and DENSE_RANK() are only useful when applied on ordered partitions (=partitions defined by the use of the ORDER BY clause)"


# Exercise #1:
-- Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.
-- Order and display the obtained salary values from highest to lowest.
select emp_no,
		salary,
        row_number()over w as row_num
from salaries
		where emp_no = 10560
        window w as (order by salary desc);


# Exercise #2:
-- Write a query that upon execution, displays the number of salary contracts that each manager has ever signed while working in the company.
select dm.emp_no,
		salary,
        row_number()over w as row_num
from salaries s 
join dept_manager dm on s.emp_no = dm.emp_no
window w as (partition by dm.emp_no order by s.salary);


# Exercise #3:
-- Write a query that upon execution retrieves a result set containing all salary values that
-- employee 10560 has ever signed a contract for. Use a window function to rank all salary 
-- values from highest to lowest in a way that equal salary values bear the same rank and that gaps in 
-- the obtained ranks for subsequent rows are allowed.

select emp_no,
		salary,
        rank()over w as rank_num
from salaries
		where emp_no = 10560
        window w as (order by salary desc);
	

# Exercise #4:
-- Write a query that upon execution retrieves a result set containing all salary values that
-- employee 10560 has ever signed a contract for. Use a window function to rank all salary values
-- from highest to lowest in a way that equal salary values bear the same rank and that gaps in t
-- he obtained ranks for subsequent rows are not allowed.

select emp_no,
		salary,
        dense_rank()over w as dense_rank_num
from salaries
		where emp_no = 10560
		window w as (order by salary desc);












