use employees;

drop procedure if exists select_employees;

# NON-PARAMACTRIC PROCEDURES
delimiter $$
create procedure select_employees()
begin 
	select * from employees
	limit 1000;
end $$
delimiter ;

# 3 ways to check results
call employees.select_employees();
call select_employees();
-- use lighting symbol in stored_procedures inside schemas section
-- also you can use wrench icon to see the code and make more purpose full correction whenever more necessary


# Another way to create procedure is by 'left clicking' the previous stored procedure -> go to create stored procedure -> write the query and hit apply 

-- TO DROP AN PROCEDURE 
drop procedure select_employees;
-- Also you can use left click and select drop stored procedure

delimiter $$
create procedure avg_salary_employees()
begin
	select round(avg(e.emp_no),2) as avg_salary
    from employees e
    join salaries s on e.emp_no = s.emp_no;
end $$
delimiter ;


select round(avg(e.emp_no),2) as avg_salary
    from employees e
    join salaries s on e.emp_no = s.emp_no;


call employees.avg_salary_employees();


# create stored procedures with input parameters

delimiter $$
use employees $$
create procedure salary_employees (in p_emp_no integer)
begin 
	select e.first_name,e.last_name,s.salary, s.from_date,s.to_date
    from employees e
    join salaries s on e.emp_no = s.emp_no
    where e.emp_no = p_emp_no;
end $$
delimiter ;

# We can also use aggregate fuction in stored input procedures
# due to full_group_by_mode use mentioned columns in select = group by
# Without group by 'Stored Procedure Input' might run but won't provide promised output
 delimiter $$
use employees $$
create procedure emp_avg_salary (in p_emp_no integer)
begin 
	select e.first_name,e.last_name, AVG(s.salary) AS avg_salary
    from employees e
    join salaries s on e.emp_no = s.emp_no
    where e.emp_no = p_emp_no
	GROUP BY e.first_name,e.last_name;
end $$
delimiter ;

call emp_avg_salary(11300); 

drop procedure emp_avg_salary;

SELECT 
    e.first_name,e.last_name, AVG(s.salary) AS avg_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.first_name,e.last_name
 ;

delimiter $$
create procedure emp_avg_salary_out (in p_emp_no integer ,out p_avg_salary decimal(10,2))
begin
select avg(s.salary) as avg_salary
into p_avg_salary from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end$$
delimiter ;



select avg(s.salary) as avg_salary
 from employees e
join salaries s on e.emp_no = s.emp_no;


call emp_avg_salary_out(11300);

# subquery can also be used inside stored procedure
delimiter $$
create procedure last_dept(in p_emp_no integer)
begin 
select e.emp_no,d.dept_no,d.dept_name
from employees e
join dept_emp de on e.emp_no=de.emp_no
join departments d on de.dept_no= d.dept_no
where e.emp_no = p_emp_no
and de.from_date = (select max(from_date)from dept_emp where emp_no = p_emp_no );
end $$
delimiter ;




















