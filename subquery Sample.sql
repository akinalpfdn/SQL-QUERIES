--An example query with mutliple subqueries
DECLARE @LANG NVARCHAR(50), @LOGONUSER NVARCHAR(150), @REGION NVARCHAR(50), @PROJECT NVARCHAR (50)
SET @LANG = '<?=LANG>'
SET @LOGONUSER ='<?=LOGONUSER>'
SET @REGION = ''
SET @PROJECT = ''
SELECT CMP.txtBlockName,
	   SUM(CONVERT(int,txtCapacity)) txtCapacity
	   ,(SELECT COUNT(*) 
		FROM [SECONDTABLENAME] FRM 
		INNER JOIN MAINTABLENAME CMP2 ON CMP2.ID = FRM.cmbCampRoom 
		WHERE CMP2.txtBlockName = CMP.txtBlockName) AS used
		,SUM(CONVERT(int,txtCapacity)) - (SELECT COUNT(*) 
										FROM [SECONDTABLENAME] FRM 
										INNER JOIN MAINTABLENAME CMP2 ON CMP2.ID = FRM.cmbCampRoom 
										WHERE CMP2.txtBlockName = CMP.txtBlockName) free
		,(SELECT VALUE1TR FROM TbPon000LookupValues WHERE ID = mtlCampType) mtlCampType_TEXT
		 ,mtlCampType
  FROM MAINTABLENAME CMP WITH(NOLOCK) 
  WHERE txtCampName IS NOT NULL AND CMP.mtlProject IN ('<?=PROJECT>')  AND CMP.ProjectRegion IN ('<?=REGION>') AND CMP.ProjectRegion in ( select [Val] from AUTHTABLE where USERID= @LOGONUSER  AND AUTHID=11)
  GROUP BY CMP.txtBlockName,mtlCampType
  ORDER BY mtlCampType DESC