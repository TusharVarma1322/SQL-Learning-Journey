# USE Deterministic, no sql, or reads sql data
# Error Code: 1418. This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)	0.032 sec
delimiter $$
create function f_emp_avg_salary(f_avg_salary integer)returns decimal(10,2)
deterministic
begin
declare v_avg_salary decimal(10,2);
select avg(s.salary) 
into v_avg_salary
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no= f_avg_salary;
return v_avg_salary;
end$$
delimiter ;


# to call the fuctions use select statement
select f_emp_avg_salary(11300);


delimiter $$
create function emp_info (p_first_name varchar(255),p_last_name varchar(255)) returns decimal(10,2)
deterministic
begin

declare v_max_from_date date;
declare v_salary decimal(10,2);

select max(from_date) into v_max_from_date
from employees e
join salaries s on e.emp_no = s.emp_no
where e.first_name = p_first_name and e.last_name = p_last_name ;

select s.salary  into v_salary
from employees e
join salaries s on e.emp_no = s.emp_no
where e.first_name = p_first_name and e.last_name = p_last_name 
and v_max_from_date = v_salary ;


return v_salary;

end$$

select emp_info('aruna','journel');

drop function EM;

























