-- My_SQL Session is an series of information exchange interactions, or a Dialogue, between a computer and a user
# In our case that would be dialogue between MY_SQL Server and and a Client application like MY_SQL Workbench
# A session begins at certain poitn in time and terminates at another, later point
# STEP 1: SET UP A CONNECTION
# STEP 2: ESTABLISH A CONNETION
# STEP 3: A WORKBECH INTERFACE WILL OPEN IMMEDIATELY!
# <START> SESSION <END>
# STEP 4: END A CONNECTION
-- THERE ARE CERTAIN SQL OBJECTS THAT ARE VALID FOR SPECIFIC SESSION ONLY
# This means if you using an SQL objects during a specific connection for a periad of time and then you end that connection,you will 'Lose' all the data contained or created by these sql objects.
-- "Setion variable is a vairable exists only fot the session in which you are operating"
-- It is defined on our server, and it lives there
-- It is 'Visible' to the connection being used only
-- @ - indicates we are creating a MY_SQL session variable

set @v_avg_salary=3;
select @v_avg_salary;