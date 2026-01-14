SELECT 
    a.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no ASC) AS a 
UNION SELECT 
    b.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no >= 10021
    GROUP BY e.emp_no
    ORDER BY e.emp_no ASC
    LIMIT 20) AS b 
UNION SELECT 
    c.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no ASC) AS c 
UNION SELECT 
    d.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no ASC) AS d
;
    
    
  # excersice
  
  drop table if exists emp_manager;
create table emp_manager
(emp_no int (11) not null,
dept_no char (4) null,
manager_no int(11) not null
) ;


insert into emp_manager
select
u.*
from (SELECT 
    a.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no ASC) AS a 
UNION SELECT 
    b.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no >= 10021
    GROUP BY e.emp_no
    ORDER BY e.emp_no ASC
    LIMIT 20) AS b 
UNION SELECT 
    c.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no ASC) AS c 
UNION SELECT 
    d.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no ASC) AS d) as u;


select * from emp_manager;






