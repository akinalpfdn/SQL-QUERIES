ALTER DATABASE DATABASENAME SET TRUSTWORTHY ON; 
CREATE ASSEMBLY AlfAuthHelperNew FROM'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Binn\DllName.dll' WITH PERMISSION_SET = UNSAFE-- ('C:/TEST.dll'w is incorrect)
 --GRANT UNSAFE ASSEMBLY TO [DLLNAME]
 


CREATE FUNCTION dbo.FUNCTIONNAME 
(   
  @dcStr as nvarchar(200)  
  ,@userName as nvarchar(200)
  ,@operation as int
)   
RETURNS nvarchar(200)  
 AS EXTERNAL NAME DLLNAME.[NAMESPACE.CLASSNAME].FUNCTIONNAME  

 CREATE FUNCTION dbo.FUNCTIONNAME   
(   
  @enStr as nvarchar(200)  
  ,@userName as nvarchar(200)
  ,@operation as int
)   
RETURNS nvarchar(200)  
 AS EXTERNAL NAME DLLNAME.[NAMESPACE.CLASSNAME].FUNCTIONNAME