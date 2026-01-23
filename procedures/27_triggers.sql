# but you should remember this rule for the future: You cannot roll back a transaction if you have run a CREATE or DROP command in the middle of it.
set autocommit = 0;
use employees;
commit;

delimiter $$
create trigger before_salary_insert
before insert on salaries
for each row
begin
	if new.salary < 0 then
    set new.salary = 0;
    end if;
end $$
delimiter ;

insert into salaries values (10001,90212,'1984-05-21','1989-02-12') ;

insert into salaries values (10001,-90212,'1989-05-21','1999-12-21');
select * from salaries;

delimiter $$
create trigger before_salary_update
before update on salaries
for each row
begin
	 if new.salary < 0 then
     set new.salary = old.salary;
     end if;
end$$
delimiter ;

update salaries
set salary = 89745
where emp_no = 999901 and to_date = '1998-06-08';

update salaries
set salary = -465444
where emp_no = 999901 and to_date ='1998-06-08';



select * from salaries where emp_no = 999901;


# Just like system varaibles we have system fuctions which tells us data about the moment of execution of certain query

select sysdate();

select date_format(sysdate(),'%y-%m-%d') as today;


drop trigger salary_promotion_dept;
delimiter $$
create trigger salary_promotion_dept
after insert on dept_manager
for each row
begin

declare v_promotion_salary int;
	
    select max(salary)
	into v_promotion_salary from salaries
	where emp_no =  new.emp_no;
         
         if v_promotion_salary is not null then
         update salaries
         set to_date = sysdate()
         where to_date = new.to_date and from_date = new.from_date;
        
         insert into salaries 
         values (new.emp_no, v_promotion_salary+20000, new.from_date, new.to_date);
	end if;
end$$
delimiter ;

insert into dept_manager values(111534,'d009',date_format(sysdate(),'%y-%m-%d'),'9999-01-01');

select * from dept_manager where emp_no = 111534  ;





select * from employees_dup ;

# wrong methods
-- use of same table , make infinite loop in trigger .
-- use of after , as use of before when set defualt value.
-- before doesn't require update set , use set directly.
delimiter $$
create trigger check_hire_date
after insert on employees
for each row
begin 
	declare v_current_date date;
    
    select max(hire_date) 
    into v_current_date from employees
    where hire_date = new.hire_date;
    
    if v_current_date is not null then
    update employees
    set new.hire_date =date_format(sysdate(),'%Y-%m-%d')
    where hire_date = new.hire_date and birth_date = new.birth_date;
    
    insert into employees
    values(new.emp_no,new.birth_date,new.first_name,new.last_name,new.gender,new.hire_date);
    

	end if;
end$$
delimiter ;
# Above method is wrong learn from it

# To get the date in the format yyyy-mm-dd (specifically with a 4-digit year), you need to change the lowercase %y to an uppercase %Y.Here is the corrected code (assuming you are using MySQL):SQLDATE_FORMAT(SYSDATE(), '%Y-%m-%d')
# The Key DifferenceIn MySQL date formatting, case sensitivity matters:%y (Lowercase): Returns a 2-digit year (e.g., "26").%Y (Uppercase): Returns a 4-digit year (e.g., "2026").
# Breakdown of the SpecifiersSpecifierDescriptionExample Output%YYear, numeric, 4 digits2026%mMonth, numeric (00..12)01%dDay of the month, numeric (00..31)07
select date_format(sysdate(),'%Y-%m-%d');


set autocommit =0;
use employees ;
commit;

delimiter $$
create trigger check_currrent_date
before insert on employees_dup
for each row
begin
	if new.hire_date > date_format(sysdate(),'%Y-%m-%d') then
    set new.hire_date = date_format(sysdate(),'%Y-%m-%d');
    end if;
end$$
delimiter ;

insert into employees_dup values (10001, '1990-01-01', 'John', 'Doe', 'M', '2030-01-01');


SELECT  

    *  

FROM  

    employees_dup

ORDER BY emp_no DESC;

rollback;