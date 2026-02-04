# In fact, aggregate window functions are nothing but window functions involving the use of my SQL aggregate functions.

# NOTE: "We must be very careful when utilizing aggregate functions"
-- Examples:
-- e.g. SUM()
-- AVG()


# "Whether or not the aggregate functions will relate to the window function we are implementing, 
# depends entirely on 'the way we organize our data' and on 'the syntax' we employ"


# "you have to be specific about whether you are applying an aggregate function on certain 
# groups of values or if you would like to apply it on data partitions."

# "In the first scenario you'll need to use the group by clause to refer to the values of a certain table column."
# "In the second you'll need an over clause potentially including partition by or a window clause with a window specification."


Create a MySQL query that will extract the following information about all currently 
employed workers registered in the dept_emp table:

their employee number

the department they are working in

the salary they are currently being paid (=the salary value specified in their latest contract)

the all-time average salary paid in the department the employee is currently working in
 (=use a window function to create a field named average_salary_per_department);


# NOTE : for the last part of the task you need to use a window function to create a field named average salary per department.

use employees;

SELECT SYSDATE();

SELECT 
    *
FROM
    salaries
WHERE
    to_date > SYSDATE();

# can't rely on above query to obtain the desired data, we risk falling into the following trap 
-- "What if an employee had signed an indefinite duration contract on date X, 
-- and then signed a new, differently valued indefinite duration contract two years from X?"

# "More precisely, we have to be specific by using the max function on the from
# date field and the relevant group by clause to guarantee that we will only obtain 
# an employee's latest contract, which will also guarantee that we will not retrieve any duplicate records Moreover"


-- once we involve the use of an aggregate function, we want to make sure we comply with my SQL only full group by mode.
-- Otherwise we risk getting error. 1055 if we just added a max function to our field list and a group by clause at the end of the query.


SELECT 
    emp_no, salary, MAX(from_date), to_date
FROM
    salaries
WHERE
    to_date > SYSDATE()
GROUP BY emp_no;

# "See, therefore, we'll need to incorporate the essence of this query into a subquery of a new
# larger query and then relate it to the rest of the data in the salaries table. This is the correct
# approach to ensuring that only currently employed workers will be taken into account.
# Of course, we mustn't forget to add the condition that the values of the to_date column of
# the salaries table should be greater than the current date, as designated by the SYSDATE function."
 
 
 -- Finally, we must specify that we want the values from the from dates as obtained by the inner and outer queries to coincide execute .
 
 SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MAX(from_date) as from_date
    FROM
        salaries
    WHERE
        to_date > SYSDATE()
    GROUP BY emp_no) as s1 on s.emp_no = s1.emp_no
WHERE
    s.to_date > SYSDATE()
        AND s.from_date = s1.from_date;
        
        
# Exercise #1:

-- Create a query that upon execution returns a result set containing the employee numbers, 
-- contract salary values, start, and end dates of the first ever contracts that each employee
-- signed for the company.

-- To obtain the desired output, refer to the data stored in the "salaries" table.
SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MIN(from_date) AS from_date,min(to_date) as to_date
    FROM
        salaries
    GROUP BY emp_no) AS s1 ON s.emp_no = s1.emp_no
WHERE
   s.from_date = s1.from_date
   and s.to_date = s1.to_date;


SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, min(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) AS s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date;
        




SELECT * FROM 	dept_emp LIMIT 1000;

SELECT * FROM dept_emp WHERE emp_no = 10010 order by from_date;

SELECT * FROM dept_emp WHERE emp_no = 10018 order by from_date;

SELECT * FROM salaries WHERE emp_no = 10010 order by from_date;
# "An employee might have changed departments without having had their salary adjusted, or vice-versa."

-- "Is this a potential problem for the solution of our task? Yes it is. Since we risk displaying 
-- not the last department where an employee has worked in while displaying their latest
-- salary at the same time. Not only that, but obtaining the wrong department would also 
-- mean using incorrect salary values when estimating the average salary per department
-- values in the final column of our output."


-- our task asked at the beginning 
SELECT 
    de1.emp_no, de.dept_no, de.from_date, de.to_date
FROM
   dept_emp de
        JOIN
    (SELECT 
        emp_no, MAX(from_date) as from_date
    FROM
        dept_emp
    WHERE
        to_date > SYSDATE()
    GROUP BY emp_no) as de1 on de.emp_no = de1.emp_no
WHERE
    de.to_date > SYSDATE()
        AND de.from_date = de1.from_date;


-- whole query 
select de2.emp_no ,d.dept_name, s2.salary, avg(s2.salary) over w as avg_salary_per_dept
from (SELECT 
    de1.emp_no, de.dept_no, de.from_date, de.to_date
FROM
   dept_emp de
        JOIN
    (SELECT 
        emp_no, MAX(from_date) as from_date
    FROM
        dept_emp
    WHERE
        to_date > SYSDATE()
    GROUP BY emp_no) as de1 on de.emp_no = de1.emp_no
WHERE
    de.to_date > SYSDATE()
        AND de.from_date = de1.from_date) as de2
        join( SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MAX(from_date) as from_date
    FROM
        salaries
    WHERE
        to_date > SYSDATE()
    GROUP BY emp_no) as s1 on s.emp_no = s1.emp_no
WHERE
    s.to_date > SYSDATE()
        AND s.from_date = s1.from_date) as s2 on de2.emp_no = s2.emp_no
        join 
        departments d on d.dept_no = de2.dept_no
        group by de2.emp_no, d.dept_name
        window w as (partition by de2.dept_no)
        order by de2.emp_no;
               

# Exercise #1:
-- Consider the employees' contracts that have been signed after the 1st of January 2000 and terminated 
-- before the 1st of January 2002 (as registered in the "dept_emp" table).
-- Create a MySQL query that will extract the following information about these employees:
-- Their employee number
-- The salary values of the latest contracts they have signed during the suggested time period

-- The department they have been working in (as specified in the latest contract they've signed during the suggested time period)
-- Use a window function to create a fourth field containing the average salary paid in the department the employee was last working in during the suggested time period.
-- Name that field "average_salary_per_department".
#Note1: This exercise is not related neither to the query you created nor to the output you obtained
-- while solving the exercises after the previous lecture.
#Note2: Now
-- we are asking you to practically create the same query as the one we worked on during the video lecture;
-- the only difference being to refer to contracts that have been valid within the period between the 1st of January 2000 and the 1st of January 2002.
#Note3: We invite you solve this task after assuming that the "to_date" values
--  stored in the "salaries" and "dept_emp" tables are greater than the "from_date" values stored in these same tables.
-- If you doubt that, you could include a couple of lines in your code to ensure that this is the case anyway!

-- Hint: If you've worked correctly, you should obtain an output containing 200 rows.

select de2.emp_no, d.dept_name, s2.salary, avg(s2.salary)  over w as avg_salary
from(SELECT 
    de.emp_no, de.dept_no, de.from_date, de.to_date
FROM
    dept_emp de
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        dept_emp
    WHERE
         from_date > '2000-01-01'
         and  to_date <'2002-01-01'
    GROUP BY emp_no) de1 ON de.emp_no = de1.emp_no
        AND de.from_date = de1.from_date
        ORDER BY de.emp_no, de.dept_no) as de2 
join
(SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) AS s1 ON s.emp_no = s1.emp_no
     WHERE
         s.to_date <'2002-01-01'
         and s.from_date > '2000-01-01'
         and s.from_date = s1.from_date) as s2 on s2.emp_no = de2.emp_no
	join 
    departments d on d.dept_no = de2.dept_no
    group by de2.emp_no , d.dept_name
    window w as (partition by de2.dept_no)
    order by de2.emp_no, salary;
    
    

    
    
    
    
    
    