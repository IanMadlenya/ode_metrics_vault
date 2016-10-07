USE [ODE_Metrics_Vault]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_DD_Columns]
AS

WITH hStable	AS (SELECT * FROM [ODE_Metrics_Vault].[hub].[h_DV_Source_Table])
,sStable		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_DV_Source_Table] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
,hColumn		AS (SELECT * FROM [ODE_Metrics_Vault].[hub].[h_DV_Column])
,sColumn		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_DV_Column] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0  AND release_number != 1)
,sDDColumn		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_Column_DataDictionary] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
,lTable_col		AS (SELECT l.* FROM [ODE_Metrics_Vault].[lnk].[l_Column_Source] l 
					JOIN [ODE_Metrics_Vault].[sat].[s_Link_Column_Source] s
					ON l.l_Column_Source_key = s.l_Column_Source_key  WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
,lSat_Col		AS (SELECT l.* FROM [ODE_Metrics_Vault].[lnk].[l_Satellite_Column] l 
					JOIN [ODE_Metrics_Vault].[sat].[s_Link_Satellite_Column] s
					ON l.l_Satellite_Column_key = s.l_Satellite_Column_key  WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
,hSat			AS (SELECT * FROM [ODE_Metrics_Vault].[hub].[h_DV_Satellite])
,sSat			AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_DV_Satellite])
,sColInt		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_Column_Integrity] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)

SELECT DISTINCT 
  sStable.source_table_name	AS SourceTableName
, CASE WHEN sStable.is_retired = 0 THEN 'Current' WHEN sStable.is_retired IS NULL THEN 'N/A' Else 'Retired' END AS SourceTableFlag
, sSat.satellite_name		AS SatelliteName
, CASE WHEN sSat.is_retired = 0 THEN 'Current' WHEN sSat.is_retired IS NULL THEN 'N/A' Else 'Retired' END AS SatelliteCurrentFlag
, hColumn.column_key		AS ColumnKey
, sColumn.column_name		AS ColumnName
, sColumn.column_type		AS ColumnType
, sColumn.column_length		AS ColumnLength
, sDDColumn.[Description]	AS ColumnShortDesc
, sDDColumn.[BusinessRule]	AS ColumnLongDesc
, sColInt.[MinValue]
, sColInt.[MaxValue]
, sColInt.[DomainCount]
, sColInt.[NullCount]
, sColInt.[BlankCount]
, sColInt.[MinLength]
, sColInt.[MaxLength]
, CASE WHEN sColumn.is_retired = 0 THEN 'Current' Else 'Retired' END AS ColumnCurrentFlag
FROM hColumn
JOIN sColumn			ON hColumn.h_DV_Column_key = sColumn.h_DV_Column_key
LEFT JOIN sDDColumn		ON hColumn.h_DV_Column_key = sDDColumn.h_DV_Column_key
LEFT JOIN lTable_col	ON hColumn.h_DV_Column_key = lTable_col.h_DV_Column_key
LEFT JOIN hStable		ON lTable_col.h_DV_Source_Table_key = hStable.h_DV_Source_Table_key
LEFT JOIN sStable		ON hStable.h_DV_Source_Table_key = sStable.h_DV_Source_Table_key
LEFT JOIN lSat_Col		ON hColumn.h_DV_Column_key = lSat_Col.h_DV_Column_key
LEFT JOIN hSat			ON lSat_Col.h_DV_Satellite_key = hSat.h_DV_Satellite_key
LEFT JOIN sSat			ON hSat.h_DV_Satellite_key = sSat.h_DV_Satellite_key
LEFT JOIN sColInt		ON sColInt.h_DV_Column_key = hColumn.h_DV_Column_key



GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_DD_Links]
AS

WITH hLink	AS (SELECT * FROM [ODE_Metrics_Vault].[hub].[h_DV_Link])
,sLink		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_DV_Link]  WHERE [dv_row_is_current] = 1 and [dv_is_tombstone] = 0 and release_number != 1)
,sLinkInt	AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_Link_Integrity] WHERE [dv_row_is_current] = 1 and [dv_is_tombstone] = 0)
,sDDLink	AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_Link_DataDictionary] WHERE [dv_row_is_current] = 1 and [dv_is_tombstone] = 0)
,hRank		AS (SELECT h_DV_Link_key, h.h_DV_Hub_key, h.[hub_name], i.[TotalRowCount],
					RANK() OVER(ORDER BY h_DV_Link_key,l.h_DV_Hub_key ) AS RankRank
				FROM [ODE_Metrics_Vault].[lnk].[l_Hub_Link_Column] l
				JOIN [ODE_Metrics_Vault].[sat].[s_Link_Hub_Link_Column] s ON l.l_Hub_Link_Column_key = s.l_Hub_Link_Column_key
				LEFT JOIN [ODE_Metrics_Vault].[sat].[s_DV_Hub] h  ON l.h_DV_Hub_key = h.h_DV_Hub_key
				LEFT JOIN [ODE_Metrics_Vault].[sat].[s_Hub_Integrity] i ON l.h_DV_Hub_key = i.h_DV_Hub_key
				WHERE s.dv_row_is_current = 1 AND s.dv_is_tombstone = 0
					AND h.dv_row_is_current = 1 AND h.dv_is_tombstone = 0
					AND i.dv_row_is_current = 1 AND i.dv_is_tombstone = 0)

SELECT hLink.link_key	AS LinkKey
, sLink.link_name		AS LinkName
, sDDLink.[Description] AS LinkShortDesc
, sDDLink.BusinessRule	AS LinkLongDesc
, CASE WHEN sLink.is_retired = 0 THEN 'Current' ELSE 'Retired' END AS LinkCurrentFlag
, sLinkInt.TotalRowCount AS LinkRowCount
, h1.hub_name			AS Hub1Name
, h1.TotalRowCount		AS Hub1RowCount
, h2.hub_name			AS Hub2Name
, h2.TotalRowCount		AS Hub2RowCount
, h3.hub_name			AS Hub3Name
, h3.TotalRowCount		AS Hub3RowCount
, h4.hub_name			AS Hub4Name
, h4.TotalRowCount		AS Hub4RowCount
FROM hLink
JOIN sLink
	ON hLink.h_DV_Link_key = sLink.h_DV_Link_key
LEFT JOIN hRank h1
	ON hLink.h_DV_Link_key = h1.h_DV_Link_key
	AND h1.RankRank = 1
LEFT JOIN hRank h2
	ON hLink.h_DV_Link_key = h2.h_DV_Link_key
	AND h2.RankRank = 2
LEFT JOIN hRank h3
	ON hLink.h_DV_Link_key = h3.h_DV_Link_key
	AND h2.RankRank = 3
LEFT JOIN hRank h4
	ON hLink.h_DV_Link_key = h3.h_DV_Link_key
	AND h2.RankRank = 4
LEFT JOIN sLinkInt
	ON hLink.h_DV_Link_key = sLinkInt.h_DV_Link_key
LEFT JOIN sDDLink
	ON hLink.h_DV_Link_key = sDDLink.h_DV_Link_key


GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_DD_Table]
AS

WITH hStable	AS (SELECT * FROM [ODE_Metrics_Vault].[hub].[h_DV_Source_Table])
,sStable		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_DV_Source_Table] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0 and release_number != 1)
,sDDStable		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_SourceTable_DataDictionary] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
,hHub			AS (SELECT * FROM [ODE_Metrics_Vault].[hub].[h_DV_Hub])
,sHub			AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_DV_Hub] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
,sDDHub			AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_Hub_DataDictionary] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
,hSat			AS (SELECT * FROM [ODE_Metrics_Vault].[hub].[h_DV_Satellite])
,lColumn_Source AS (SELECT l.* FROM [ODE_Metrics_Vault].[lnk].[l_Column_Source] l
					JOIN [ODE_Metrics_Vault].[sat].[s_Link_Column_Source] s 
					ON l.l_Column_Source_key = s.l_Column_Source_key WHERE s.dv_row_is_current = 1 AND s.dv_is_tombstone = 0)
,hDV_Column		AS (SELECT * FROM [ODE_Metrics_Vault].[hub].[h_DV_Column]) 
,lSat_Column	AS (SELECT l.* FROM [ODE_Metrics_Vault].[lnk].[l_Satellite_Column] l
					JOIN [ODE_Metrics_Vault].[sat].[s_Link_Satellite_Column] s 
					ON l.l_Satellite_Column_key = s.l_Satellite_Column_key WHERE s.dv_row_is_current = 1 AND s.dv_is_tombstone = 0)
,lHub_Sat		AS (SELECT l.* FROM [ODE_Metrics_Vault].[lnk].[l_Hub_Satellite] l
					JOIN [ODE_Metrics_Vault].[sat].[s_Link_Hub_Satellite] s 
					ON l.l_Hub_Satellite_key = s.l_Hub_Satellite_key WHERE s.dv_row_is_current = 1 AND s.dv_is_tombstone = 0)
,sSatDD			AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_Satellite_DataDictionary] WHERE dv_row_is_current = 1 AND dv_is_tombstone = 0)
,sSatellite		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_DV_Satellite] WHERE dv_row_is_current = 1 AND dv_is_tombstone = 0)
,sHubInt		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_Hub_Integrity]  WHERE dv_row_is_current = 1 AND dv_is_tombstone = 0)
,sSatInt		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_Satellite_Integrity]  WHERE dv_row_is_current = 1 AND dv_is_tombstone = 0)


SELECT DISTINCT 
  hStable.source_table_key		AS SourceTableKey
, sStable.[source_table_name]	AS SourceTableName
, sDDStable.[ShortDescription]	AS SourceTableShortDesc
, sDDStable.[LongDescription]	AS SourceTableLongDesc
, CASE WHEN sStable.is_retired = 0 Then 'Current' ELSE 'Retired' END AS SourceTableFlag
, hHub.hub_key					AS HubKey
, sHub.[hub_name]				AS HubName
, sDDHub.[Description]			AS HubShortDesc
, sDDHub.[BusinessRule]			AS HubLongDesc
, CASE WHEN sHub.is_retired = 0 Then 'Current' WHEN sHub.is_retired is null then 'N/A' ELSE 'Retired' END AS HubCurrentFlag
, sHubInt.TotalRowCount			AS HubTotalRowCount
, hSat.satellite_key			AS SatelliteKey
, sSatellite.[satellite_name]	AS SatelliteName
, sSatDD.[Description]			AS SatelliteShortDesc
, sSatDD.[BusinessRule]			AS SatelliteLongDesc
, CASE WHEN sSatellite.is_retired = 0 Then 'Current' WHEN sSatellite.is_retired IS NULL then 'N/A' ELSE 'Retired' END AS SatelliteCurrentFlag
, sSatInt.TotalRowCount			AS SatelliteTotalRowCount
, sSatInt.CurrentRowCount		AS SatelliteCurrentRowCount
, sSatInt.VersionedRowCount		AS SatelliteVersionedRowCount
, sSatInt.TombstoneRowCount		AS SatelliteTombstoneRowCount
FROM hStable
INNER JOIN sStable			ON sStable.h_DV_Source_Table_key = hStable.h_DV_Source_Table_key
LEFT JOIN lColumn_Source	ON lColumn_Source.h_DV_Source_Table_key = hStable.h_DV_Source_Table_key
LEFT JOIN hDV_Column		ON hDV_Column.h_DV_Column_key = lColumn_Source.h_DV_Column_key
INNER JOIN lSat_Column		ON lSat_Column.h_DV_Column_key = hDV_Column.h_DV_Column_key
INNER JOIN hSat				ON hSat.h_DV_Satellite_key = lSat_Column.h_DV_Satellite_key
LEFT JOIN lHub_Sat			ON lHub_Sat.h_DV_Satellite_key = hSat.h_DV_Satellite_key
LEFT JOIN hHub				ON hHub.h_DV_Hub_key = lHub_Sat.h_DV_Hub_key
LEFT JOIN sDDStable			ON sDDStable.h_DV_Source_Table_key = hStable.h_DV_Source_Table_key
LEFT JOIN sSatDD			ON sSatDD.h_DV_Satellite_key = hSat.h_DV_Satellite_key
LEFT JOIN sDDHub			ON sDDHub.h_DV_Hub_key = hHub.h_DV_Hub_key
LEFT JOIN sSatellite		ON sSatellite.h_DV_Satellite_key = hSat.h_DV_Satellite_key
LEFT JOIN sHub				ON sHub.h_DV_Hub_key = hHub.h_DV_Hub_key
LEFT JOIN sHubInt			ON sHubInt.h_DV_Hub_key = hHub.h_DV_Hub_key
LEFT JOIN sSatInt			ON sSatInt.h_DV_Satellite_key = hSat.h_DV_Satellite_key



GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_Hub_Row_Increase]
AS
SELECT curnt.RunDate
, DATENAME(dw,curnt.RunDate) AS DayOfWeek
, curnt.[HubName]
, curnt.[SourceTableName]
, curnt.[TotalRowCount]
, curnt.[TotalRowCount] - prev.[TotalRowCount] AS RowsAddedSinceLastRun
FROM [ODE_Metrics_Vault].[sat].[s_Hub_Integrity] curnt
LEFT JOIN [ODE_Metrics_Vault].[sat].[s_Hub_Integrity] prev
ON curnt.HubKey = prev.HubKey
AND curnt.RunDate > prev.RunDate
AND NOT EXISTS (SELECT HubKey FROM [ODE_Metrics_Vault].[sat].[s_Hub_Integrity] subQuer
				WHERE subQuer.HubKey = curnt.HubKey 
					AND curnt.RunDate > subQuer.RunDate
					AND prev.RunDate < subQuer.RunDate)

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_Runtime_Exception]
as
WITH hRun	AS (SELECT * FROM [ODE_Metrics_Vault].[hub].[h_DV_Schedule_Run])
, sRun		AS (SELECT * FROM [ODE_Metrics_Vault].[sat].[s_DV_Schedule_Run] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
, hExc		AS (SELECT * FROM [ODE_Metrics_Vault].[RawHub].[h_DV_Exception])
, sExc		AS (SELECT * FROM [ODE_Metrics_Vault].[RawSat].[s_DV_Exception] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
, sSever	AS (SELECT * FROM [ODE_Metrics_Vault].[RawSat].[s_log4_Severity] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)

SELECT sRun.run_status
, cast(sRun.run_start_datetime AS datetime) AS ScheduleRunStart
, cast(sRun.run_end_datetime AS datetime) AS ScheduleRunEnd
, sExc.SystemDate AS ErrorDate
, ErrorContext
, ErrorProcedure
, ErrorLine
, ErrorMessage
, DatabaseName
, sSever.[SeverityName] AS ErrorSeverity
FROM hRun
JOIN sRun ON hRun.h_DV_Schedule_Run_key = sRun.h_DV_Schedule_Run_key
JOIN sExc ON sExc.SystemDate >= cast(sRun.[run_start_datetime] AS datetime)
  AND cast(sRun.[run_end_datetime] AS datetime) > = sExc.SystemDate
LEFT JOIN sSever ON sExc.ErrorSeverity = sSever.[SeverityId]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE VIEW [dbo].[vw_Satellite_Row_Increase]
  AS
  SELECT curnt.RunDate
  , DATENAME(dw,curnt.RunDate) AS DayOfWeek
  , curnt.[SatelliteName]
  , curnt.CurrentRowCount, curnt.[TotalRowCount]
  , curnt.CurrentRowCount - prev.CurrentRowCount AS RowsAddedSinceLastRun
  FROM [ODE_Metrics_Vault].[sat].[s_Satellite_Integrity] curnt
  LEFT JOIN [ODE_Metrics_Vault].[sat].[s_Satellite_Integrity] prev
			ON curnt.SatelliteKey = prev.SatelliteKey
			AND curnt.RunDate > prev.RunDate
			AND NOT EXISTS 
			(SELECT SatelliteKey FROM [ODE_Metrics_Vault].[sat].[s_Satellite_Integrity] subQuer
			WHERE subQuer.SatelliteKey = curnt.SatelliteKey 
				AND curnt.RunDate > subQuer.RunDate
				AND prev.RunDate < subQuer.RunDate)

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_Satellite_Run_Stats]
AS
WITH hSat			AS (SELECT *	FROM [ODE_Metrics_Vault].[Hub].[h_DV_Satellite]) 
, sSat				AS (SELECT *	FROM [ODE_Metrics_Vault].[sat].[s_DV_Satellite] WHERE [dv_row_is_current] = 1 AND [dv_is_tombstone] = 0)
, sSatCounts		AS (SELECT *	FROM [ODE_Metrics_Vault].[Sat].[s_Satellite_Integrity])
, sSatRun			AS (SELECT *	FROM [ODE_Metrics_Vault].[sat].[s_DV_Run_Manifest])
, lSatCol			AS (SELECT l.*	FROM [ODE_Metrics_Vault].[lnk].[l_Satellite_Column] l JOIN [ODE_Metrics_Vault].[sat].[s_Link_Satellite_Column] s
							ON l.l_Satellite_Column_key = s.l_Satellite_Column_key
							WHERE [dv_row_is_current] = 1  AND [dv_is_tombstone] = 0)
, lColumnSource		AS (SELECT l.*	FROM [ODE_Metrics_Vault].[lnk].[l_Column_Source] l JOIN [ODE_Metrics_Vault].[sat].[s_Link_Column_Source] s
							ON l.l_Column_Source_key = s.l_Column_Source_key WHERE [dv_row_is_current] = 1  AND [dv_is_tombstone] = 0)
,lSourceManifest	AS (SELECT l.*	FROM [ODE_Metrics_Vault].[lnk].[l_Manifest_Source] l JOIN [ODE_Metrics_Vault].[sat].[s_Link_Manifest_Source] s
							ON l.l_Manifest_Source_key = s.l_Manifest_Source_key WHERE [dv_row_is_current] = 1  AND [dv_is_tombstone] = 0)

SELECT DISTINCT
sSat.satellite_name AS SatelliteName
, sSatRun.source_table_name AS SourceTable
, sSatRun.start_datetime
, sSatRun.completed_datetime
, DATEDIFF(Second,sSatRun.start_datetime,sSatRun.completed_datetime) AS RunTimeSecond
, sSatRun.run_status
, sSatRun.source_table_load_type
, sSatCounts.CurrentRowCount
, sSatCounts.TotalRowCount
, sSatCounts.TombstoneRowCount
, sSatCounts.VersionedRowCount
 FROM hSat 
INNER JOIN sSat				ON hSat.h_DV_Satellite_key = sSat.h_DV_Satellite_key
LEFT JOIN lSatCol			ON hSat.h_DV_Satellite_key = lSatCol.h_DV_Satellite_key
LEFT JOIN lColumnSource		ON lColumnSource.h_DV_Column_key = lSatCol.h_DV_Column_key
LEFT JOIN lSourceManifest	ON lColumnSource.h_DV_Source_Table_key = lSourceManifest.h_DV_Source_Table_key
LEFT JOIN sSatRun			ON lSourceManifest.h_DV_Run_Manifest_key = sSatRun.h_DV_Run_Manifest_key
LEFT JOIN sSatCounts		ON sSatCounts.h_DV_Satellite_key = hSat.h_DV_Satellite_key
							AND cast(sSatCounts.RunDate AS date) = cast(sSatRun.start_datetime AS date)


GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_Satellite_Stats]
AS

WITH hSat		AS (SELECT *	FROM [ODE_Metrics_Vault].[hub].[h_DV_Satellite])
,hColumn		AS (SELECT *	FROM [ODE_Metrics_Vault].[Hub].[h_DV_Column])
,sSat			AS (SELECT *	FROM [ODE_Metrics_Vault].[sat].[s_DV_Satellite] WHERE dv_row_is_current = 1 AND dv_is_tombstone = 0 AND release_number != 1)
,sColumn_Integrity AS (SELECT *	FROM [ODE_Metrics_Vault].[Sat].[s_Column_Integrity] WHERE dv_row_is_current = 1 AND dv_is_tombstone = 0)
, lSat_Column	AS (SELECT l.*	FROM [ODE_Metrics_Vault].[Lnk].[l_Satellite_Column] l
					JOIN [ODE_Metrics_Vault].[Sat].[s_Link_Satellite_Column] s 
					ON l.l_Satellite_Column_key = s.l_Satellite_Column_key WHERE s.dv_row_is_current = 1 AND s.dv_is_tombstone = 0)
, sSatIntegrity AS (SELECT *	FROM [ODE_Metrics_Vault].[Sat].[s_Satellite_Integrity] WHERE dv_row_is_current = 1 AND dv_is_tombstone = 0)
, sColumn		AS (SELECT *	FROM [ODE_Metrics_Vault].[sat].[s_DV_Column] WHERE dv_row_is_current = 1 AND dv_is_tombstone = 0)


SELECT 
sSat.[satellite_name] AS SatelliteName
, sSatIntegrity.[RunDate] AS DateTimeStamp
, sSatIntegrity.[CurrentRowCount]
, sColumn.[column_name] AS ColumnName
, sColumn.column_type As ColumnType
, sColumn_Integrity.[MaxLength]
, sColumn_Integrity.[MinLength]
, sColumn_Integrity.[BlankCount]
, sColumn_Integrity.[NullCount]
, sColumn_Integrity.[DomainCount]
, sColumn_Integrity.[MaxValue]
, sColumn_Integrity.[MinValue]

FROM hSat
INNER JOIN sSat				ON sSat.h_DV_Satellite_key = hSat.h_DV_Satellite_key
LEFT JOIN lSat_Column		ON lSat_Column.h_DV_Satellite_key = hSat.h_DV_Satellite_key
LEFT JOIN hColumn			ON hColumn.h_DV_Column_key = lSat_Column.h_DV_Column_key
LEFT JOIN sColumn_Integrity	ON sColumn_Integrity.h_DV_Column_key = hColumn.h_DV_Column_key
LEFT JOIN sSatIntegrity		ON sSatIntegrity.h_DV_Satellite_key = hSat.h_DV_Satellite_key
LEFT JOIN sColumn			ON hColumn.h_DV_Column_key = sColumn.h_DV_Column_key


GO
