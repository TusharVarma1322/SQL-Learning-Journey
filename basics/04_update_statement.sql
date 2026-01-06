UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31'
WHERE
    emp_no = 999901;

SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999901;

-- In MySQL, "Autocommit" is turned on by default. This means that every single SQL statement (like your UPDATE) is treated as its own complete transaction and is saved permanently the instant it executes.
# if you won't turn of autocommit ,even after using commit on original data you won't rollback after update statement.
-- U have to 'mannually set' commit now cause autocommit is "turned off"
set autocommit = 0;

SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;

commit;

UPDATE departments_dup 
SET 
    dept_no = 'd011',
    dept_name = 'Quality Control';

rollback;

SELECT 
    *
FROM
    departments
ORDER BY dept_no DESC;

-- dont forget to use where or else you'll see the consequenses of whole data change
UPDATE departments 
SET dept_name = 'Data Analysis'
where dept_no = 'd010';














