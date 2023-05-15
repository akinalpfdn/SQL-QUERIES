USE [EBA]
GO
/****** Object:  UserDefinedFunction [dbo].[FNPON035GETPAYMENTDATE]    Script Date: 15/05/2023 10:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		AKINALP FIDAN
-- Create date: 22.11.2022
-- Description:	TIMESHEETTEN PERSONELIN SON IZIN HAKEDISINI CEKMEK ICIN KULLANILIR
-- =============================================
ALTER FUNCTION [dbo].[FNPON035GETPAYMENTDATE]
(
	-- Add the parameters for the function here
	@DATE  date,	@EMPLOYEEID  INT, @TOP INT
)
RETURNS date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar date

	
	;WITH CTEQuery (Date) AS (
		SELECT TOP (@TOP) Date 
		FROM TimeSheetTable
	  WHERE DATE>=@DATE AND txtEmployeeId = @EMPLOYEEID
	  ORDER BY Date ASC
	)
	SELECT @ResultVar = MAX(Date) 
	FROM CTEQuery

	-- Return the result of the function
	RETURN @ResultVar

END
