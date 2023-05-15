--CONTINUING NCR REPORTS
DECLARE @LANG NVARCHAR(50)
SET @LANG = '<?=LANG>'
SELECT  DISTINCT ISNULL(LF.ID,0) AS 'Process ID'
		,CASE WHEN FRM.txtReportNo IS NULL THEN FRM.docReportId ELSE FRM.txtReportNo END as 'Report No'
		,FRM.txtCompany as 'Company'
		,(SELECT CONCAT(VALUE1TR , ' / ',  VALUE1EN , ' / ',  VALUE1RU) FROM SQTABLE WITH(NOLOCK) WHERE ID = FRM.mtlProject) as 'Project'
		,FRM.mtlChief_TEXT as 'Responsible Personnel'
		,txtLocation AS 'Project Location'
		,txtLocationMoreInfo AS 'Location Detail'
		,(SELECT CONCAT(VALUE1TR , ' / ',  VALUE1EN , ' / ',  VALUE1RU) FROM SQTABLE WITH(NOLOCK) WHERE ID = FRM.mtlNcrUnit) as 'Non Conforming Unit'
		,(SELECT CONCAT(VALUE1TR , ' / ',  VALUE1EN , ' / ',  VALUE1RU) FROM SQTABLE WITH(NOLOCK) WHERE ID = FRM.mtlActivity) as 'Activity'
		,CASE WHEN FRM.mtlMinMaj ='1' THEN N'Minör / Minor / Минор' WHEN FRM.mtlMinMaj ='2' THEN  N'Majör / Major / Мажор' ELSE '' END as 'Minor / Major'
		,FRM.txtNcrExplained as 'NCR Detail'
		,FRM.txtNcrRootCause as 'Root Cause of Nonconformity'
		,FRM.txtSuggestedAction as 'Suggested Action'
		,FRM.txtCorrectiveActionExplained as 'Corrective Action Explanation'
		,FRM.txtReportDate as 'Report Date'
		,FRM.txtPlannedFinishedDate as 'Planned Closing Date'
		,FRM.txtUnitClosingDate as 'Closing Date'
		,CASE WHEN txtUnitClosingDate IS NULL OR txtUnitClosingDate =''  THEN CASE WHEN  DATEDIFF(day, txtPlannedFinishedDate, GetDate()) >0 THEN DATEDIFF(day, txtPlannedFinishedDate, GetDate()) 
																				   ELSE '' END
			  ELSE Case When DATEDIFF(day, txtPlannedFinishedDate, txtUnitClosingDate) >0 THEN DATEDIFF(day, txtPlannedFinishedDate, txtUnitClosingDate)  
						ELSE '' END END  as 'Out of Day'
		,CASE WHEN LF.STATUS = '1' THEN N'Açık / Open / Открытым' 
			  WHEN LF.STATUS = '24' THEN N'Kapalı / Closed / закрыто'  END AS 'Mark of Completion'
					,(SELECT SUM(CONVERT(decimal(18,2),REPLACE((md.txtCostEffect),',','.')))
			  FROM [E_Pon003NCR_Form_dtExpenseType] dt WITH(NOLOCK)
			  LEFT JOIN [E_Pon003NCR_MdlExpenseType] MD WITH(NOLOCK) ON MD.ID = DT.DOCUMENTID
			  WHERE dt.FORMID =FRM.ID)AS 'Cost Effect'
			  ,(SELECT SUM(CONVERT(decimal(18,2),REPLACE((md.txtTimeEffect),',','.')))
			  FROM [E_Pon003NCR_Form_dtExpenseType] dt WITH(NOLOCK)
			  LEFT JOIN [E_Pon003NCR_MdlExpenseType] MD WITH(NOLOCK) ON MD.ID = DT.DOCUMENTID
			  WHERE dt.FORMID =FRM.ID)AS 'Time Effect'
			 ,CASE WHEN LF.STATUS = '1' THEN 'Başladı' 
			  WHEN LF.STATUS = '28' THEN N'Yeni Kayıt / New Record / Новая запись'
			  WHEN LF.STATUS = '29' THEN N'Birim İşlemleri / Unit Actions / Действия подразделения'
			  WHEN LF.STATUS = '30' THEN N'Birim Kayıt Kapatma / Unit Record Closing / Закрытие записи в подразделении'
			  ELSE '' END AS 'Status'
		,CONCAT(OS.FIRSTNAME,' ',OS.LASTNAME) AS 'Where Is the Process(if Open)'
		,FRM.txtFillerStaff as 'NCR Starter'
		,FRM.cmbQaQcChief_TEXT as 'QA/QC Chief'
		,FRM.mtlManager_TEXT as 'QA Manager'
		,FRM.mtlTechChief_TEXT as 'Technical Office Chief'
		,D.CREATEDATE
		--,FRM.txtUnitClosingDate as 'Closing Date'
  FROM [dbo].[MAINTABLE] FRM WITH(NOLOCK)
 INNER JOIN TABLE2 D  WITH (NOLOCK)  ON FRM.ID=D.ID
 INNER JOIN TABLE3 FD WITH (NOLOCK)  ON D.ID=FD.FILEPROFILEID
 INNER JOIN TABLE4 LF WITH (NOLOCK)  ON FD.PROCESSID=LF.ID 
  INNER JOIN TABLE5 STS ON STS.STATUS = LF.STATUS AND LF.FLOWVERSION=STS.VERSION AND STS.PROCESS='Pon003NCR' AND LF.PROCESS = 'Pon003NCR'
  LEFT JOIN TABLE6 FR WITH (NOLOCK) ON LF.ID  = FR.PROCESSID AND FR.EVENTTEXT!='?' AND FR.USERID IS NOT NULL AND LF.FLOWSTEP = FR.STEP AND FR.EVENTTEXT<>'?' AND REQUESTTYPE <> 7 --AND FR.REQUESTTYPE = 1 
  LEFT JOIN TABLE7 OS WITH (NOLOCK) ON FR.USERID = OS.ID 
WHERE D.DELETED=0 AND LF.DELETED=0 AND LF.FLOWSTEP>0 AND LF.STATUS !=28  AND LF.STATUS >24 and FRM.mtlNcrType = '5562'


UNION 

SELECT  DISTINCT ISNULL(LF.ID,0) AS 'Process ID'
		,CASE WHEN FRM.txtReportNo IS NULL THEN FRM.docReportId ELSE FRM.txtReportNo END as 'Report No'
		,FRM.txtCompany as 'Company'
		,(SELECT CONCAT(VALUE1TR , ' / ',  VALUE1EN , ' / ',  VALUE1RU) FROM SQTABLE WITH(NOLOCK) WHERE ID = FRM.mtlProject) as 'Project'
		,FRM.mtlChief_TEXT as 'Responsible Personnel'
		,txtLocation AS 'Project Location'
		,txtLocationMoreInfo AS 'Location Detail'
		,(SELECT CONCAT(VALUE1TR , ' / ',  VALUE1EN , ' / ',  VALUE1RU) FROM SQTABLE WITH(NOLOCK) WHERE ID = FRM.mtlNcrUnit) as 'Non Conforming Unit'
		,(SELECT CONCAT(VALUE1TR , ' / ',  VALUE1EN , ' / ',  VALUE1RU) FROM SQTABLE WITH(NOLOCK) WHERE ID = FRM.mtlActivity) as 'Activity'
		,CASE WHEN FRM.mtlMinMaj ='1' THEN N'Minör / Minor / Минор' WHEN FRM.mtlMinMaj ='2' THEN  N'Majör / Major / Мажор' ELSE '' END as 'Minor / Major'
		,FRM.txtNcrExplained as 'NCR Detail'
		,FRM.txtNcrRootCause as 'Root Cause of Nonconformity'
		,FRM.txtSuggestedAction as 'Suggested Action'
		,FRM.txtCorrectiveActionExplained as 'Corrective Action Explanation'
		,FRM.txtReportDate as 'Report Date'
		,FRM.txtPlannedFinishedDate as 'Planned Closing Date'
		,FRM.txtUnitClosingDate as 'Closing Date'
		,CASE WHEN txtUnitClosingDate IS NULL OR txtUnitClosingDate =''  THEN CASE WHEN  DATEDIFF(day, txtPlannedFinishedDate, GetDate()) >0 THEN DATEDIFF(day, txtPlannedFinishedDate, GetDate()) 
																				   ELSE '' END
			  ELSE Case When DATEDIFF(day, txtPlannedFinishedDate, txtUnitClosingDate) >0 THEN DATEDIFF(day, txtPlannedFinishedDate, txtUnitClosingDate)  
						ELSE '' END END  as 'Out of Day'
		,CASE WHEN LF.STATUS = '1' THEN N'Açık / Open / Открытым' 
			  WHEN LF.STATUS = '24' THEN N'Kapalı / Closed / закрыто'  END AS 'Mark of Completion'
					,(SELECT SUM(CONVERT(decimal(18,2),REPLACE((md.txtCostEffect),',','.')))
			  FROM [E_Pon003NCR_Form_dtExpenseType] dt WITH(NOLOCK)
			  LEFT JOIN [E_Pon003NCR_MdlExpenseType] MD WITH(NOLOCK) ON MD.ID = DT.DOCUMENTID
			  WHERE dt.FORMID =FRM.ID)AS 'Cost Effect'
			  ,(SELECT SUM(CONVERT(decimal(18,2),REPLACE((md.txtTimeEffect),',','.')))
			  FROM [E_Pon003NCR_Form_dtExpenseType] dt WITH(NOLOCK)
			  LEFT JOIN [E_Pon003NCR_MdlExpenseType] MD WITH(NOLOCK) ON MD.ID = DT.DOCUMENTID
			  WHERE dt.FORMID =FRM.ID)AS 'Time Effect'
			 ,CASE WHEN LF.STATUS = '1' THEN 'Başladı' 
			  WHEN LF.STATUS = '28' THEN N'Yeni Kayıt / New Record / Новая запись'
			  WHEN LF.STATUS = '29' THEN N'Birim İşlemleri / Unit Actions / Действия подразделения'
			  WHEN LF.STATUS = '30' THEN N'Birim Kayıt Kapatma / Unit Record Closing / Закрытие записи в подразделении'
			  ELSE '' END AS 'Status'
		,CONCAT(OS.FIRSTNAME,' ',OS.LASTNAME) AS 'Where Is the Process(if Open)'
		,FRM.txtFillerStaff as 'NCR Starter'
		,FRM.cmbQaQcChief_TEXT as 'QA/QC Chief'
		,FRM.mtlManager_TEXT as 'QA Manager'
		,FRM.mtlTechChief_TEXT as 'Technical Office Chief'
		,D.CREATEDATE
  FROM [dbo].[MAINTABLE] FRM WITH(NOLOCK)
 LEFT JOIN TABLE2 D  WITH (NOLOCK)  ON FRM.ID=D.ID
 LEFT JOIN TABLE3 FD WITH (NOLOCK)  ON D.ID=FD.FILEPROFILEID
 LEFT JOIN TABLE4 LF WITH (NOLOCK)  ON FD.PROCESSID=LF.ID 
  LEFT JOIN TABLE5 STS ON STS.STATUS = LF.STATUS AND LF.FLOWVERSION=STS.VERSION AND STS.PROCESS='Pon003NCR' AND LF.PROCESS = 'Pon003NCR'
  LEFT JOIN TABLE6 FR WITH (NOLOCK) ON LF.ID  = FR.PROCESSID AND FR.EVENTTEXT!='?' AND FR.USERID IS NOT NULL AND LF.FLOWSTEP = FR.STEP AND FR.EVENTTEXT<>'?' AND REQUESTTYPE <> 7 --AND FR.REQUESTTYPE = 1 
  LEFT JOIN TABLE7 OS WITH (NOLOCK) ON FR.USERID = OS.ID 
WHERE (mtlSituation_TEXT = 'Kapalı' OR mtlSituation_TEXT = 'Gecikmeli Kapalı') and FRM.mtlNcrType = '5562'
ORDER BY D.CREATEDATE DESC