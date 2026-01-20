-- there are two types of global variable - max_connection and sql_mode
-- global variable used to set how many user can access the workbeanch
set global max_connections = 1000;

set @@global.max_connections =1;


-- SQL_mode is both user defined and system variable . can be used in session or global variable.
# sql_mode help you adjust workbench setting
set session sql_mode ='strict_trans_tables';

set global sql_mode ='strict_trans_tables';