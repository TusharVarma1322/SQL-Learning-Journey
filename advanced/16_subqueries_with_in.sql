# A subquery may return a single value (a scaler) , a single row , a single column , or an enrire table
-- you can have more than one Subquery in your outer query
-- it is possible to nest inner query within other inner queries
-- In that case the sql will rum the inner most query first, then each subsequent query, until it runs the outermost query last
-- sql engine starts by running inner query
-- then it uses it's returned output,which is intermediate ,to execute the outer query

SELECT 
    *
FROM
    dept_manager dm;
    
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no in(SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
SELECT 
            dm.emp_no
        FROM
            dept_manager dm;
            

 --   Step 1: The Inner Query (The "Filter")
-- First, the database runs only the part inside the parentheses:
-- SQL
-- SELECT dm.emp_no FROM dept_manager dm
-- What happens:
-- The database goes to the dept_manager table.
-- It grabs all the emp_no values.
-- It creates a temporary, invisible list of numbers.
-- Result in memory: Let's say the result is just three IDs: [110022, 110039, 110085].

-- Step 2: The Substitution
-- Now, conceptually, the SQL engine rewrites your original query. It replaces the inner subquery with that list of numbers it just found.
-- Your query now looks like this to the engine:
-- SQL
-- SELECT e.first_name, e.last_name
-- FROM employees e
-- WHERE e.emp_no IN (110022, 110039, 110085);

-- Step 3: The Outer Query (The "Fetcher")
-- Now the outer query runs against the employees table.
-- What happens:
-- The engine looks at the first row of the employees table.
-- It looks at the WHERE clause: Does this employee's emp_no exist in my list (110022, 110039, 110085)?
-- If NO: It skips that row.
-- If YES: It grabs the first_name and last_name from the employees table (not the manager table) and adds it to the final result.
-- The "Aha!" Moment
-- You asked: "dept_manager have no data about first_name and last_name how did it the query run?"
-- Answer: The dept_manager table never needed the names.
-- The Inner Query just said: "Here is a list of ID numbers who are managers."
-- The Outer Query said: "Okay, I will look through my employees table (which does have names). If I find anyone with an ID on that list, I will show you their name."
    
    
SELECT 
            *
        FROM
            dept_manager dm
WHERE
    dm.emp_no  in (SELECT 
    e.emp_no
FROM
    employees e
  where e.hire_date  between '1990-01-01' and '1995-01-01');
    


-- EXISTS returns LOGIC (A Boolean)
-- This is the tricky part. Even if you write SELECT * inside an EXISTS clause,
-- the database does not actually create a table or select columns. It ignores the columns entirely.
-- Your Code: WHERE EXISTS (SELECT * FROM titles ...)
-- What the database sees: It sees a switch flipping On or Off.

-- Plaintext

-- TRUE
-- (or FALSE)
-- The Logic: It doesn't fetch data. It just checks: "Does any row exist that matches this criteria?" As soon as it finds one match,
-- it stops looking, shouts "TRUE!", and moves on.

   SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            dm.emp_no
        FROM
            dept_manager dm
        WHERE
            e.emp_no = dm.emp_no)
order by e.emp_no asc; 


# use 'AND' Operator 
SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            t.emp_no
        FROM
            titles t
        WHERE
            e.emp_no = t.emp_no and title = 'assistant engineer' )
ORDER BY e.emp_no ASC;

 -- ┌─────────────────────────────────────────────────────────────┐
-- │                                                             │
-- │   You understood EXISTS correctly!                          │
-- │                                                             │
-- │   Key insight you got:                                       │
-- │   • EXISTS = row by row checking                            │
-- │   • IN = list-based checking                                │
-- │                                                             │
-- │   The confusion about "e.emp_no = dm.emp_no":                │
-- │   • This is CORRELATION                                     │
-- │   • It passes current row's value to inner query            │
-- │   • Does NOT create a whole table                           │
-- │                                                             │
-- └─────────────────────────────────────────────────────────────┘





    
