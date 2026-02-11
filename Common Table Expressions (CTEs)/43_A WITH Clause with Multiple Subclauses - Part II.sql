# A WITH Clause with Multiple Subclauses - Part II

-- "you cannot use the aliases in other expressions at the same query level"

-- the count function will count the number of return values only.

 # "How many female employees' highest contract salary values were higher than the all-time company salary average across all genders?"


with cte1 as(SELECT 

    AVG(salary) avg_salary
    
FROM

    salaries),
    
cte2 as (SELECT 

    s.emp_no, MAX(s.salary) AS max_salary
    
FROM
    salaries s
    
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'
    
GROUP BY s.emp_no)

select sum(case 

			when c2.max_salary  > c1.avg_salary then 1  else 0 end ) as highest_f_avg_salary,
            count(e.emp_no) as totat_no_f_emps
            
from employees e

join cte2 c2 on c2.emp_no = e.emp_no

cross join cte1 c1;


-- We can also use 'COUNT()' function in place of sum 
-- "the count function will count the number of return values only. Its argument must again
-- be a case statement but instead of returning the values of one or zero it must return a 
-- value which should be the highest salary value of the female employees obtained by the
-- second ct and a null value otherwise."


with cte1 as(SELECT 

    AVG(salary) avg_salary
    
FROM

    salaries),
    
cte2 as (SELECT 

    s.emp_no, MAX(s.salary) AS max_salary
    
FROM
    salaries s
    
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'
    
GROUP BY s.emp_no)

select count(case 

			when c2.max_salary  > c1.avg_salary then max_salary  else null end ) as highest_f_avg_salary,
            
            count(e.emp_no) as totat_no_f_emps
            
from employees e

join cte2 c2 on c2.emp_no = e.emp_no

cross join cte1 c1;


-- " But instead of guessing if this is true, we can try to obtain the relevant percentage 
-- value. To do that, we need to take the two expressions returning the number of
-- highest salary contracts and the total number of contracts respectively and divide 
-- the former by the latter. "

with cte1 as(SELECT 

    AVG(salary) avg_salary
    
FROM

    salaries),
    
cte2 as (SELECT 

    s.emp_no, MAX(s.salary) AS max_salary
    
FROM
    salaries s
    
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'
    
GROUP BY s.emp_no)

select sum(case 

			when c2.max_salary  > c1.avg_salary then 1  else 0 end ) as highest_f_avg_salary,
            
            count(e.emp_no) as totat_no_f_emps,
		
        sum(case 

			when c2.max_salary  > c1.avg_salary then 1  else 0 end )/ count(e.emp_no) *100 -- "Please remember in this line of code you must
																							-- refer to the whole sum and count expressions
                                                                                            -- not their aliases."
            
 --            			"you cannot use the aliases in other expressions at the same query level"
																							-- "So you won't be able to use the highest salaries,
                                                                                            -- above average, or total number of female contracts
                                                                                            -- in the outer select statement field. Now we'll multiply
                                                                                            -- the obtained value by 100."
from employees e

join cte2 c2 on c2.emp_no = e.emp_no

cross join cte1 c1;


-- "There is, however, a way to display the obtained percentage value better.
-- We can use the expression in the third field as the first argument of a 'round'
-- function and provide the value of two as its second argument to indicate we would
-- only like to have two digits after the decimal symbol in the final output."

with cte1 as(SELECT 

    AVG(salary) avg_salary
    
FROM

    salaries),
    
cte2 as (SELECT 

    s.emp_no, MAX(s.salary) AS max_salary
    
FROM
    salaries s
    
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'
    
GROUP BY s.emp_no)

select sum(case 

			when c2.max_salary  > c1.avg_salary then 1  else 0 end ) as highest_f_avg_salary,
            
            count(e.emp_no) as totat_no_f_emps,
		
        round(sum(case 

			when c2.max_salary  > c1.avg_salary then 1  else 0 end )/ count(e.emp_no) *100 , 2)
from employees e

join cte2 c2 on c2.emp_no = e.emp_no

cross join cte1 c1;

-- "We typically want to add the percentage symbol to the right to improve 
-- the obtained value further; to do that, we can use the same entire expression
-- as the first argument of a concatenate function, whose second argument will 
-- be a string containing the percentage field."

with cte1 as(SELECT 

    AVG(salary) avg_salary
    
FROM

    salaries),
    
cte2 as (SELECT 

    s.emp_no, MAX(s.salary) AS max_salary
    
FROM
    salaries s
    
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'
    
GROUP BY s.emp_no)

select sum(case 

			when c2.max_salary  > c1.avg_salary then 1  else 0 end ) as highest_f_avg_salary,
            
            count(e.emp_no) as totat_no_f_emps,
		
        concat(round(sum(case 

			when c2.max_salary  > c1.avg_salary then 1  else 0 end )/ count(e.emp_no) *100 , 2) ,'%') as 'percentage %'
from employees e

join cte2 c2 on c2.emp_no = e.emp_no

cross join cte1 c1;




