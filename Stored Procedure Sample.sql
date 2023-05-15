USE [EBA]
GO
/****** Object:  StoredProcedure [dbo].[sp016GetMtlId]    Script Date: 15/05/2023 10:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akınalp FİDAN
-- Create date: <Create Date,,>
-- Description:	A PROCEDURE THAT GIVE MTL VALUES' ID DYNAMICALLY
-- =============================================
ALTER PROCEDURE [dbo].[sp016GetMtlId]
	-- Add the parameters for the stored procedure here
	@LANGVALUE  NVARCHAR(1000),@FORM  NVARCHAR(1000), @COLUMNNAME  NVARCHAR(1000), @FORMID NVARCHAR(1000) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @SQL NVARCHAR(MAX),  @value int,@Parm nvarchar(50),  @WQUERY NVARCHAR(MAX)--, @returnValue int
	-- Add the T-SQL statements to compute the return value here
	if @FORMID IS NULL
	BEGIN
		if @FORM = 'FrmPersonnel'
		BEGIN
			SET @WQUERY = 'WHERE  '+ @COLUMNNAME+' IS NULL AND LEN('+ @COLUMNNAME+'_TEXT) > 0 '
		END
		ELSE
		BEGIN
			SET @WQUERY = 'WHERE  txtPersonnelID IS NULL '
		END
		SET @SQL = N'UPDATE E_ProjectName_'+ @FORM+'  
		SET '+ @COLUMNNAME+' =(SELECT [dbo].[FNGETLOOKUPID]('+ @COLUMNNAME+'_TEXT,(SELECT TOP(1)  TYPE
																				FROM ValuesTable WITH (NOLOCK)
																				WHERE ID= (Select TOP(1) '+ @COLUMNNAME+' 
																							FROM E_ProjectName_'+@FORM+' FRM WITH(NOLOCK)
																							WHERE '+ @COLUMNNAME+' >0
																							ORDER BY FRM.ID DESC))))  '+@WQUERY
		SET @Parm = '@value int output'
		EXEC sp_executesql @SQL 
	END
	ELSE
	BEGIN
		SET @SQL = N'UPDATE E_ProjectName_'+ @FORM+'  
		SET '+ @COLUMNNAME+' =(SELECT [dbo].[FNGETLOOKUPID]('+ @COLUMNNAME+'_TEXT,(SELECT TOP(1)  TYPE
																				FROM ValuesTable WITH (NOLOCK)
																				WHERE ID= (Select TOP(1) '+ @COLUMNNAME+' 
																							FROM E_ProjectName_'+@FORM+' FRM WITH(NOLOCK)
																							WHERE '+ @COLUMNNAME+' >0
																							ORDER BY FRM.ID DESC)))) 
							 WHERE ID='''+@FORMID+''''

		SET @Parm = '@value int output'
		EXEC sp_executesql @SQL 
	END

END
