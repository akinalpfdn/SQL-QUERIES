SELECT SUBSTRING(
        (
            SELECT CONCAT(',''',[Val],'''')  AS [text()]
            FROM dbo.TABLENAME ST1
			WITH(NOLOCK) where USERID= 'afidan' 
            FOR XML PATH (''), TYPE
        ).value('text()[1]','nvarchar(max)'), 1, 1000)