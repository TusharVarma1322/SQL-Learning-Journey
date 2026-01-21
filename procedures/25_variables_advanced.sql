delimiter $$
create procedure emp_avg_salary (in p_emp_no integer,out p_avg_salary decimal(10,2))
begin 
	select avg(s.salary) as avg_salary
    into p_avg_salary from employees e
    join salaries s on e.emp_no	= s.emp_no
    where e.emp_no= p_emp_no;
end$$
delimiter ;

# THIS IS HOW TO SET VARIABLES IN MY SQL TO CALL THEM OUT
set @V_avg_variable = 0;
call emp_avg_salary_out(11300,@v_avg_variable);
select @v_avg_variable;



DELIMITER $$
CREATE PROCEDURE EMP_INFO (IN P_FIRST_NAME VARCHAR(255),IN P_LAST_NAME VARCHAR(255),OUT P_EMP_NO INTEGER)
BEGIN 
	SELECT E.EMP_NO
    INTO P_EMP_NO FROM EMPLOYEES E
    WHERE E.FIRST_NAME = P_FIRST_NAME AND E.LAST_NAME = P_LAST_NAME;
END $$
DELIMITER ;

SELECT * FROM employees;

drop procedure EMP_INFO;

delimiter $$
create procedure emp_info (in p_first_name varchar(255),in p_last_name varchar(255),out p_emp_no integer)
begin
	select e.emp_no
    into p_emp_no from employees e
    where e.first_name = p_first_name and e.last_name = p_last_name ;
end $$
delimiter ;
    
    
    
# That is mathematically impossible in a list of existing employees. If a name exists in the table, the count is at least 1. 
# you'll see nothing
    SELECT first_name, last_name, COUNT(emp_no) as id_count
FROM employees
GROUP BY first_name, last_name
HAVING COUNT(emp_no) < 1;
    
    
SELECT 
    first_name, last_name, COUNT(emp_no) AS id_count
FROM
    employees
GROUP BY first_name , last_name
HAVING COUNT(emp_no) < 2;
    
    
    
set @v_emp_no = 0;
call emp_info('aruna','journel',@v_emp_no) ;
select @v_emp_no ;
    
    
    
    
    