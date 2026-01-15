SELECT 
    *
FROM
    dept_emp;
    
    SELECT 
    emp_no, COUNT(emp_no) AS num
FROM
    dept_emp
GROUP BY emp_no
HAVING num > 1;

# 'Create view' could suffice, but the "Or Replace" ascertains that the code we are about to write will be executed ...
# ... even if we already have a view with the same name.
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;

SELECT 
    emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
    dept_emp
GROUP BY emp_no;


CREATE OR REPLACE VIEW V_avg_salary_managers AS
    SELECT 
        ROUND(AVG(s.salary), 2) AS avg_salary_managers
    FROM
        dept_manager dm
            JOIN
        salaries s ON dm.emp_no = s.emp_no
;
















