
# Use of SQL Window Functions Syntax

select emp_no,
		salary,
        row_number()over w as row_num
        from salaries
		window w as (partition by emp_no order by salary desc);
        
        
select emp_no,
		first_name,
        row_number()over w as row_num
        from employees
        window w as(partition by first_name order by emp_no asc)
       ;
        