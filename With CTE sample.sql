DECLARE @ResultVar date,
DECLARE @EMPLOYEEID int,

	
	;WITH CTEQuery (Date) AS (
		SELECT TOP (@TOP) Date 
		FROM TimeSheetTable
	  WHERE DATE>=@DATE AND EmployeeId = @EMPLOYEEID
	  ORDER BY Date ASC
	)
	SELECT @ResultVar = MAX(Date) 
	FROM CTEQuery