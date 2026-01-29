-- USE of row_number ranking window function
select emp_no,
		salary,
        row_number()over(partition by emp_no order by salary)as row_num
        from salaries;
        
 select emp_no,
		salary,
        row_number()over( order by salary desc)as row_num
        from salaries ;

-- if you don't provide partition by sql optimizer will assume single partition of the dataset 
 select emp_no,
		salary,
        row_number()over()as row_num
        from salaries ;
        
-- multiple application of row_number ranking window function
select emp_no,
		salary,
        row_number()over()as row_num,
        row_number()over(partition by emp_no order by salary asc)as row_num1,
        row_number()over(partition by emp_no order by salary desc)as row_num2,
        row_number()over(order by salary)as row_num3
        from salaries;
        
-- However above mention query can be run,but Professionally use only columns which make sense according to requirements
select emp_no,
		salary,
        # row_number()over()as row_num,
        row_number()over(partition by emp_no order by salary asc)as row_num1,
        row_number()over(partition by emp_no order by salary desc)as row_num2
       # row_number()over(order by salary)as row_num3
        from salaries;


select emp_no,
		dept_no,
        row_number()over(order by emp_no ) as row_num
        from dept_manager;
        
select emp_no,
		first_name,
        last_name,
        row_number()over(partition by first_name order by last_name asc ) as row_num
        from employees;
        
        
select emp_no,
		first_name,
        last_name,
        row_number()over w as row_num
        from employees
        window w as (partition by first_name order by emp_no asc );