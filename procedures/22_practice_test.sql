select*
from employees 
where year(hire_date)='2000'
order by first_name asc;

select e.gender,d.dept_name ,avg(s.salary)as avg_salary
from employees e
join salaries s on e.emp_no = s.emp_no
join dept_emp de on s.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
group by e.gender,d.dept_name
order by avg_salary asc;

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