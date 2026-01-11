# REMOVE THE DUPLICATES FROM THE TWO TABLES

delete from dept_manager_dup
where emp_no = '110228';

delete from departments_dup
where dept_no = 'd009';

insert into dept_manager_dup
values('110228','d003','1992-03-21','9999-01-01');

insert into departments_dup
values('d009','Customer Service');


SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON d.dept_no = m.dept_no
group by m.emp_no,m.dept_no,d.dept_name
order by m.emp_no desc;


-- Order in which tables are 'Join' matters in left join 
-- the correct way to do that is to retrive first selection from the first table you have set in the join syntax
-- but with one major exception: The Right Join.
-- The rule isn't actually "Select the first table." The real rule is "Select the Anchor Table first."

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON d.dept_no = m.dept_no
group by m.emp_no,m.dept_no,d.dept_name
order by m.emp_no ;

-- the correct way to do that is to retrive first selection from the first table you have set in the join syntax
-- In select , from and Order by
SELECT 
    d.dept_no, m.emp_no, d.dept_name 
FROM
    departments_dup d
        LEFT JOIN
    dept_manager_dup m ON d.dept_no = m.dept_no
order by d.dept_no ;

-- use where to retrive the null values
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON d.dept_no = m.dept_no
WHERE
    d.dept_name IS NULL
ORDER BY m.dept_no;


SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, m.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager m ON e.emp_no = m.emp_no
WHERE
    e.last_name = 'markovitch'
ORDER BY m.dept_no DESC , e.emp_no ;


-- Right Joins 
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON d.dept_no = m.dept_no
ORDER BY dept_no;

-- We can run a 'Left Join' and a 'Right Join' with inverted tables order , we will obtain the same output ...

SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
  departments_dup d  
        left JOIN
    dept_manager_dup m ON d.dept_no = m.dept_no
ORDER BY dept_no;



