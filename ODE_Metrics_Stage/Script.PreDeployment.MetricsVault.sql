/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--Set up Metrics Vault database

IF (DB_ID(N'ODE_Metrics_Vault') IS NOT NULL) 
BEGIN
    ALTER DATABASE [ODE_Metrics_Vault]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [ODE_Metrics_Vault];
END
GO
CREATE DATABASE [ODE_Metrics_Vault] COLLATE SQL_Latin1_General_CP1_CI_AS
GO

USE [ODE_Metrics_Vault]
GO

CREATE SCHEMA [hub]
AUTHORIZATION dbo
GO

CREATE SCHEMA [sat]
AUTHORIZATION dbo
GO

CREATE SCHEMA [lnk]
AUTHORIZATION dbo
GO

CREATE SCHEMA [RawHub]
AUTHORIZATION dbo
GO

CREATE SCHEMA [RawSat]
AUTHORIZATION dbo
GO

CREATE SCHEMA [RawLnk]
AUTHORIZATION dbo
GO


--Populate ODE_Config with Metrics Vault configuration data

USE [$(ODE_Config)]
GO

--Set up a release number

SET IDENTITY_INSERT [dv_release].[dv_release_master] ON 

GO
INSERT [dv_release].[dv_release_master] ([release_key], [release_number], [release_description], [reference_number], [reference_source], [build_number], [build_date], [build_server], [release_built_by], [release_start_datetime], [release_complete_datetime], [release_count], [version_number], [updated_by], [updated_datetime]) VALUES (-1, 1, N'Metrics vault settings', N'N/A', N'N/A', 1, CAST(N'2016-09-09T03:45:11.0406345+00:00' AS DateTimeOffset), NULL, N'dbo', NULL, NULL, 0, 1, N'sa', CAST(N'2016-09-09T03:45:11.0436349+00:00' AS DateTimeOffset))
GO

SET IDENTITY_INSERT [dv_release].[dv_release_master] OFF
GO

INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 1, 1, N'Header', N'SET IDENTITY_INSERT [dv_release].[dv_release_master] ON; MERGE INTO [dv_release].[dv_release_master] AS trgt USING	(VALUES (-1,1,''Metrics vault settings'',''N/A'',''N/A'',4,''Nov  3 2016  1:04:06.4048139AM +00:00'',''ABC123'',''dbo'',''Nov  3 2016  1:04:06.4048139AM +00:00'')
			) AS src([release_key],[release_number],[release_description],[reference_number],[reference_source],[build_number],[build_date],[build_server],[release_built_by],[updated_datetime])
	ON
		trgt.[release_key] = src.[release_key]
	WHEN MATCHED THEN
		UPDATE SET
			[release_number] = src.[release_number]
		, [release_description] = src.[release_description]
		, [reference_number] = src.[reference_number]
		, [reference_source] = src.[reference_source]
		, [build_number] = src.[build_number]
		, [build_date] = src.[build_date]
		, [build_server] = src.[build_server]
		, [release_built_by] = src.[release_built_by]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([release_key],[release_number],[release_description],[reference_number],[reference_source],[build_number],[build_date],[build_server],[release_built_by],[updated_datetime])
		VALUES ([release_key],[release_number],[release_description],[reference_number],[reference_source],[build_number],[build_date],[build_server],[release_built_by],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dv_release].[dv_release_master] OFF;', 1)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 2, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_source_system] ON; MERGE INTO [dbo].[dv_source_system] AS trgt USING	(VALUES (-101,''MetricsVault'',''ODE_Metrics_Stage'',0,-1)
			) AS src([source_system_key],[source_system_name],[timevault_name],[is_retired],[release_key])
	ON
		trgt.[source_system_key] = src.[source_system_key]
	WHEN MATCHED THEN
		UPDATE SET
			[source_system_name] = src.[source_system_name]
		, [timevault_name] = src.[timevault_name]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([source_system_key],[source_system_name],[timevault_name],[is_retired],[release_key])
		VALUES ([source_system_key],[source_system_name],[timevault_name],[is_retired],[release_key])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_source_system] OFF;', 1)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 3, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_source_table] ON; MERGE INTO [dbo].[dv_source_table] AS trgt USING	(VALUES (-1038,-101,''Stage'',''Link_Satellite_Column_Function'',''Full'',''Stage'',''usp_Link_Satellite_Column_Function'',0,-1),
		(-1037,-101,''Stage'',''DV_Reference_Function'',''Full'',''Stage'',''usp_DV_Reference_Function'',0,-1),
		(-1036,-101,''stage'',''Link_Satellite_Column_Satellite'',''Full'',''stage'',''usp_Link_Satellite_Column_Satellite'',0,-1),
		(-1035,-101,''stage'',''Link_Column_Satellite_Column'',''Full'',''stage'',''usp_Link_Column_Satellite_Column'',0,-1),
		(-1034,-101,''stage'',''DV_Source_Table'',''Full'',''stage'',''usp_DV_Source_Table'',0,-1),
		(-139,-101,''stage'',''log4_Severity'',''Full'',''stage'',''usp_log4_Severity'',0,-1),
		(-138,-101,''stage'',''SourceTable_DataDictionary'',''Delta'',NULL,NULL,0,-1),
		(-137,-101,''stage'',''HubKey_DataDictionary'',''Delta'',NULL,NULL,0,-1),
		(-136,-101,''stage'',''Column_DataDictionary'',''Delta'',NULL,NULL,0,-1),
		(-135,-101,''stage'',''Link_DataDictionary'',''Delta'',NULL,NULL,0,-1),
		(-134,-101,''stage'',''Satellite_DataDictionary'',''Delta'',NULL,NULL,0,-1),
		(-133,-101,''stage'',''Hub_DataDictionary'',''Delta'',NULL,NULL,0,-1),
		(-132,-101,''stage'',''Column_Integrity'',''Delta'',''stage'',''usp_Column_Integrity'',0,-1),
		(-131,-101,''stage'',''Hub_Integrity'',''Full'',''stage'',''usp_Hub_Integrity'',0,-1),
		(-130,-101,''stage'',''Link_Integrity'',''Full'',''stage'',''usp_Link_Integrity'',0,-1),
		(-129,-101,''stage'',''Satellite_Integrity'',''Full'',''stage'',''usp_Satellite_Integrity'',0,-1),
		(-128,-101,''stage'',''Link_Journal_Exception'',''Full'',''stage'',''usp_Link_Journal_Exception'',0,-1),
		(-127,-101,''stage'',''Link_Table_Schedule'',''Full'',''stage'',''usp_Link_Table_Schedule'',0,-1),
		(-126,-101,''stage'',''Link_Run_Manifest'',''Full'',''stage'',''usp_Link_Run_Manifest'',0,-1),
		(-125,-101,''stage'',''Link_Manifest_Source'',''Full'',''stage'',''usp_Link_Manifest_Source'',0,-1),
		(-124,-101,''stage'',''Link_Column_Source'',''Full'',''stage'',''usp_Link_Column_Source'',0,-1),
		(-122,-101,''stage'',''Link_Link_Satellite'',''Full'',''stage'',''usp_Link_Link_Satellite'',0,-1),
		(-121,-101,''stage'',''Link_Hub_Link_Column'',''Full'',''stage'',''usp_Link_Hub_Link_Column'',0,-1),
		(-120,-101,''stage'',''Link_Hub_Column_Key'',''Full'',''stage'',''usp_Link_Hub_Column_Key'',0,-1),
		(-119,-101,''stage'',''Link_Hub_Satellite'',''Full'',''stage'',''usp_Link_Hub_Satellite'',0,-1),
		(-118,-101,''stage'',''DV_Journal'',''Full'',''stage'',''usp_DV_Journal'',0,-1),
		(-117,-101,''stage'',''DV_Exception'',''Full'',''stage'',''usp_DV_Exception'',0,-1),
		(-116,-101,''stage'',''DV_Schedule_Hierarchy'',''Full'',''stage'',''usp_DV_Schedule_Hierarchy'',0,-1),
		(-115,-101,''stage'',''DV_Schedule_Table'',''Full'',''stage'',''usp_DV_Schedule_Table'',0,-1),
		(-114,-101,''stage'',''DV_Schedule'',''Full'',''stage'',''usp_DV_Schedule'',0,-1),
		(-113,-101,''stage'',''DV_Source_System'',''Full'',''stage'',''usp_DV_Source_System'',0,-1),
		(-112,-101,''stage'',''DV_Satellite_Column'',''Full'',''stage'',''usp_DV_Satellite_Column'',0,-1),
		(-111,-101,''stage'',''DV_Hub_Link'',''Full'',''stage'',''usp_DV_Hub_Link'',0,-1),
		(-110,-101,''stage'',''DV_Hub_Column'',''Full'',''stage'',''usp_DV_Hub_Column'',0,-1),
		(-109,-101,''stage'',''DV_Hub_Key'',''Full'',''stage'',''usp_DV_Hub_Key'',0,-1),
		(-108,-101,''stage'',''DV_Run_Manifest'',''Full'',''stage'',''usp_DV_Run_Manifest'',0,-1),
		(-107,-101,''stage'',''DV_Schedule_Run'',''Full'',''stage'',''usp_DV_Schedule_Run'',0,-1),
		(-106,-101,''stage'',''DV_Column'',''Full'',''stage'',''usp_DV_Column'',0,-1),
		(-105,-101,''stage'',''DV_Source_Table_Raw'',''Full'',''stage'',''usp_DV_Source_Table_Raw'',0,-1),
		(-104,-101,''stage'',''DV_Release'',''Full'',''stage'',''usp_DV_Release'',0,-1),
		(-103,-101,''stage'',''DV_Satellite'',''Full'',''stage'',''usp_DV_Satellite'',0,-1),
		(-102,-101,''stage'',''DV_Link'',''Full'',''stage'',''usp_DV_Link'',0,-1),
		(-101,-101,''stage'',''DV_Hub'',''Full'',''stage'',''usp_DV_Hub'',0,-1)
			) AS src([source_table_key],[system_key],[source_table_schema],[source_table_name],[source_table_load_type],[source_procedure_schema],[source_procedure_name],[is_retired],[release_key])
	ON
		trgt.[source_table_key] = src.[source_table_key]
	WHEN MATCHED THEN
		UPDATE SET
			[system_key] = src.[system_key]
		, [source_table_schema] = src.[source_table_schema]
		, [source_table_name] = src.[source_table_name]
		, [source_table_load_type] = src.[source_table_load_type]
		, [source_procedure_schema] = src.[source_procedure_schema]
		, [source_procedure_name] = src.[source_procedure_name]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([source_table_key],[system_key],[source_table_schema],[source_table_name],[source_table_load_type],[source_procedure_schema],[source_procedure_name],[is_retired],[release_key])
		VALUES ([source_table_key],[system_key],[source_table_schema],[source_table_name],[source_table_load_type],[source_procedure_schema],[source_procedure_name],[is_retired],[release_key])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_source_table] OFF;', 43)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 4, 1, N'Table', N'SET IDENTITY_INSERT [dv_scheduler].[dv_schedule] ON; MERGE INTO [dv_scheduler].[dv_schedule] AS trgt USING	(VALUES (-1,''Metrics_Vault'',''Intergity checks for the metrics vault'',''Daily'',0,-1,''Aug 29 2016  9:54:15.7453873PM +00:00'')
			) AS src([schedule_key],[schedule_name],[schedule_description],[schedule_frequency],[is_cancelled],[release_key],[updated_datetime])
	ON
		trgt.[schedule_key] = src.[schedule_key]
	WHEN MATCHED THEN
		UPDATE SET
			[schedule_name] = src.[schedule_name]
		, [schedule_description] = src.[schedule_description]
		, [schedule_frequency] = src.[schedule_frequency]
		, [is_cancelled] = src.[is_cancelled]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([schedule_key],[schedule_name],[schedule_description],[schedule_frequency],[is_cancelled],[release_key],[updated_datetime])
		VALUES ([schedule_key],[schedule_name],[schedule_description],[schedule_frequency],[is_cancelled],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dv_scheduler].[dv_schedule] OFF;', 1)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 5, 1, N'Table', N'SET IDENTITY_INSERT [dv_scheduler].[dv_source_table_hierarchy] ON; MERGE INTO [dv_scheduler].[dv_source_table_hierarchy] AS trgt USING	(VALUES (-1026,-1038,-112,0,-1),
		(-1025,-1036,-112,0,-1),
		(-1024,-1035,-106,0,-1),
		(-1023,-1034,-113,0,-1),
		(-1022,-1034,-105,0,-1),
		(-27,-138,-105,0,-1),
		(-26,-137,-109,0,-1),
		(-25,-136,-112,0,-1),
		(-24,-135,-102,0,-1),
		(-23,-134,-103,0,-1),
		(-22,-133,-101,0,-1),
		(-21,-129,-103,0,-1),
		(-20,-127,-115,0,-1),
		(-18,-126,-108,0,-1),
		(-17,-125,-108,0,-1),
		(-16,-122,-103,0,-1),
		(-15,-128,-118,0,-1),
		(-14,-130,-102,0,-1),
		(-13,-119,-103,0,-1),
		(-12,-121,-112,0,-1),
		(-11,-121,-103,0,-1),
		(-10,-121,-111,0,-1),
		(-9,-121,-109,0,-1),
		(-8,-121,-110,0,-1),
		(-7,-120,-110,0,-1),
		(-6,-120,-109,0,-1),
		(-5,-124,-106,0,-1),
		(-4,-131,-101,0,-1),
		(-3,-112,-103,0,-1),
		(-2,-110,-101,0,-1),
		(-1,-132,-112,0,-1)
			) AS src([source_table_hierarchy_key],[source_table_key],[prior_table_key],[is_cancelled],[release_key])
	ON
		trgt.[source_table_hierarchy_key] = src.[source_table_hierarchy_key]
	WHEN MATCHED THEN
		UPDATE SET
			[source_table_key] = src.[source_table_key]
		, [prior_table_key] = src.[prior_table_key]
		, [is_cancelled] = src.[is_cancelled]
		, [release_key] = src.[release_key]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([source_table_hierarchy_key],[source_table_key],[prior_table_key],[is_cancelled],[release_key])
		VALUES ([source_table_hierarchy_key],[source_table_key],[prior_table_key],[is_cancelled],[release_key])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dv_scheduler].[dv_source_table_hierarchy] OFF;', 31)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 6, 1, N'Table', N'SET IDENTITY_INSERT [dv_scheduler].[dv_schedule_source_table] ON; MERGE INTO [dv_scheduler].[dv_schedule_source_table] AS trgt USING	(VALUES (-1039,-1,-1038,''Full'',''Low'',''001'',0,-1,''Nov  2 2016 10:32:49.7542601PM +00:00''),
		(-1038,-1,-1037,''Full'',''Low'',''001'',0,-1,''Nov  2 2016  9:58:24.6384406PM +00:00''),
		(-1037,-1,-1036,''Full'',''Low'',''001'',0,-1,''Nov  2 2016  3:30:56.6431427AM +00:00''),
		(-1036,-1,-1035,''Full'',''Low'',''001'',0,-1,''Nov  2 2016  3:30:44.1591296AM +00:00''),
		(-1035,-1,-1034,''Full'',''Low'',''001'',0,-1,''Sep  9 2016  2:23:33.2386354AM +00:00''),
		(-40,-1,-138,''Delta'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-39,-1,-137,''Delta'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-38,-1,-136,''Delta'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-37,-1,-135,''Delta'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-36,-1,-134,''Delta'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-35,-1,-133,''Delta'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-34,-1,-129,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-33,-1,-127,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-31,-1,-126,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-30,-1,-125,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-29,-1,-122,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-28,-1,-128,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-27,-1,-109,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:34:49.1687075AM +00:00''),
		(-26,-1,-104,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:34:49.1687075AM +00:00''),
		(-25,-1,-130,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-23,-1,-119,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:39:39.5213827AM +00:00''),
		(-22,-1,-121,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-21,-1,-120,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-20,-1,-124,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-19,-1,-131,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-18,-1,-105,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:34:49.1687075AM +00:00''),
		(-17,-1,-113,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:39:39.5213827AM +00:00''),
		(-16,-1,-115,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:39:39.5213827AM +00:00''),
		(-15,-1,-107,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:34:49.1687075AM +00:00''),
		(-13,-1,-116,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:39:39.5213827AM +00:00''),
		(-12,-1,-114,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:39:39.5213827AM +00:00''),
		(-11,-1,-112,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:39:39.5213827AM +00:00''),
		(-10,-1,-103,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:34:49.1687075AM +00:00''),
		(-9,-1,-108,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:34:49.1687075AM +00:00''),
		(-8,-1,-102,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:34:49.1687075AM +00:00''),
		(-7,-1,-118,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:39:39.5213827AM +00:00''),
		(-6,-1,-111,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:39:39.5213827AM +00:00''),
		(-5,-1,-110,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00''),
		(-4,-1,-101,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:34:49.1687075AM +00:00''),
		(-3,-1,-117,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:39:39.5213827AM +00:00''),
		(-2,-1,-106,''Full'',''Low'',''001'',0,-1,''Sep  7 2016  2:34:49.1687075AM +00:00''),
		(-1,-1,-132,''Delta'',''Low'',''001'',0,-1,''Sep  7 2016  2:41:31.6282453AM +00:00'')
			) AS src([schedule_source_table_key],[schedule_key],[source_table_key],[source_table_load_type],[priority],[queue],[is_cancelled],[release_key],[updated_datetime])
	ON
		trgt.[schedule_source_table_key] = src.[schedule_source_table_key]
	WHEN MATCHED THEN
		UPDATE SET
			[schedule_key] = src.[schedule_key]
		, [source_table_key] = src.[source_table_key]
		, [source_table_load_type] = src.[source_table_load_type]
		, [priority] = src.[priority]
		, [queue] = src.[queue]
		, [is_cancelled] = src.[is_cancelled]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([schedule_source_table_key],[schedule_key],[source_table_key],[source_table_load_type],[priority],[queue],[is_cancelled],[release_key],[updated_datetime])
		VALUES ([schedule_source_table_key],[schedule_key],[source_table_key],[source_table_load_type],[priority],[queue],[is_cancelled],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dv_scheduler].[dv_schedule_source_table] OFF;', 42)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 7, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_hub] ON; MERGE INTO [dbo].[dv_hub] AS trgt USING	(VALUES (-120,''DV_Reference_Function'',''h120'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Nov  2 2016  9:52:46.2856489PM +00:00''),
		(-119,''Severity'',''h119'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016 12:22:21.7737501AM +00:00''),
		(-118,''DV_Journal'',''h118'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016 12:20:54.4319759AM +00:00''),
		(-117,''DV_Exception'',''h117'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016 12:20:17.2609974AM +00:00''),
		(-116,''DV_Schedule_Hierarchy'',''h116'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016 12:19:39.9805802AM +00:00''),
		(-115,''DV_Schedule_Table'',''h115'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016 12:19:00.2940035AM +00:00''),
		(-114,''DV_Schedule'',''h114'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016 12:18:18.9980678AM +00:00''),
		(-113,''DV_Source_System'',''h113'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016 12:17:34.1397171AM +00:00''),
		(-112,''DV_Satellite_Column'',''h112'',''hub'',''ODE_Metrics_Vault'',0,-1,''Nov  2 2016  1:20:52.2239768AM +00:00''),
		(-111,''DV_Hub_Link'',''h111'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016 12:15:25.1583345AM +00:00''),
		(-110,''DV_Hub_Column'',''h110'',''RawHub'',''ODE_Metrics_Vault'',0,-1,''Sep  6 2016 11:48:57.1168092PM +00:00''),
		(-109,''DV_Hub_Key'',''h109'',''hub'',''ODE_Metrics_Vault'',0,-1,''Sep  6 2016 11:46:46.4479326PM +00:00''),
		(-108,''DV_Run_Manifest'',''h108'',''hub'',''ODE_Metrics_Vault'',0,-1,''Sep  6 2016 11:45:59.5115207PM +00:00''),
		(-107,''DV_Schedule_Run'',''h107'',''hub'',''ODE_Metrics_Vault'',0,-1,''Sep  6 2016 11:45:09.8095424PM +00:00''),
		(-106,''DV_Column'',''h106'',''hub'',''ODE_Metrics_Vault'',0,-1,''Sep  6 2016 11:44:24.2325358PM +00:00''),
		(-105,''DV_Source_Table'',''h105'',''hub'',''ODE_Metrics_Vault'',0,-1,''Sep  6 2016 11:43:29.2806204PM +00:00''),
		(-104,''DV_Release'',''h104'',''hub'',''ODE_Metrics_Vault'',0,-1,''Sep  6 2016 11:42:36.7662275PM +00:00''),
		(-103,''DV_Satellite'',''h103'',''hub'',''ODE_Metrics_Vault'',0,-1,''Sep  6 2016 11:41:22.4085428PM +00:00''),
		(-102,''DV_Link'',''h102'',''hub'',''ODE_Metrics_Vault'',0,-1,''Sep  6 2016 11:40:14.9257182PM +00:00''),
		(-101,''DV_Hub'',''h101'',''hub'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016 12:24:07.9119653AM +00:00'')
			) AS src([hub_key],[hub_name],[hub_abbreviation],[hub_schema],[hub_database],[is_retired],[release_key],[updated_datetime])
	ON
		trgt.[hub_key] = src.[hub_key]
	WHEN MATCHED THEN
		UPDATE SET
			[hub_name] = src.[hub_name]
		, [hub_abbreviation] = src.[hub_abbreviation]
		, [hub_schema] = src.[hub_schema]
		, [hub_database] = src.[hub_database]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([hub_key],[hub_name],[hub_abbreviation],[hub_schema],[hub_database],[is_retired],[release_key],[updated_datetime])
		VALUES ([hub_key],[hub_name],[hub_abbreviation],[hub_schema],[hub_database],[is_retired],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_hub] OFF;', 20)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 8, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_hub_key_column] ON; MERGE INTO [dbo].[dv_hub_key_column] AS trgt USING	(VALUES (-120,-120,''ref_function_key'',''varchar'',30,0,0,NULL,1,-1,''Nov  2 2016  9:59:28.4027823PM +00:00''),
		(-119,-119,''SeverityID'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-118,-118,''JournalID'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-117,-117,''ExceptionID'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-116,-116,''schedule_hierarchy_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-115,-115,''schedule_table_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-114,-114,''schedule_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-113,-113,''source_system_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-112,-112,''satellite_col_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-111,-111,''hub_link_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-110,-110,''hub_column_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-109,-109,''hub_key_column_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-108,-108,''run_manifest_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-107,-107,''run_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-106,-106,''column_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-105,-105,''source_table_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-104,-104,''release_number'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-103,-103,''satellite_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-102,-102,''link_key'',''int'',4,10,0,NULL,1,-1,''Nov  2 2016 10:03:55.9288120PM +00:00''),
		(-101,-101,''hub_key'',''int'',4,10,0,NULL,1,-1,''Sep  7 2016  2:56:17.2640325AM +00:00'')
			) AS src([hub_key_column_key],[hub_key],[hub_key_column_name],[hub_key_column_type],[hub_key_column_length],[hub_key_column_precision],[hub_key_column_scale],[hub_key_Collation_Name],[hub_key_ordinal_position],[release_key],[updated_datetime])
	ON
		trgt.[hub_key_column_key] = src.[hub_key_column_key]
	WHEN MATCHED THEN
		UPDATE SET
			[hub_key] = src.[hub_key]
		, [hub_key_column_name] = src.[hub_key_column_name]
		, [hub_key_column_type] = src.[hub_key_column_type]
		, [hub_key_column_length] = src.[hub_key_column_length]
		, [hub_key_column_precision] = src.[hub_key_column_precision]
		, [hub_key_column_scale] = src.[hub_key_column_scale]
		, [hub_key_Collation_Name] = src.[hub_key_Collation_Name]
		, [hub_key_ordinal_position] = src.[hub_key_ordinal_position]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([hub_key_column_key],[hub_key],[hub_key_column_name],[hub_key_column_type],[hub_key_column_length],[hub_key_column_precision],[hub_key_column_scale],[hub_key_Collation_Name],[hub_key_ordinal_position],[release_key],[updated_datetime])
		VALUES ([hub_key_column_key],[hub_key],[hub_key_column_name],[hub_key_column_type],[hub_key_column_length],[hub_key_column_precision],[hub_key_column_scale],[hub_key_Collation_Name],[hub_key_ordinal_position],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_hub_key_column] OFF;', 20)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 9, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_link] ON; MERGE INTO [dbo].[dv_link] AS trgt USING	(VALUES (-113,''Satellite_Column_Function'',''L113'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Nov  2 2016 10:31:30.9901891PM +00:00''),
		(-112,''Satellite_Column_Satellite'',''L112'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Nov  2 2016  3:05:20.8460569AM +00:00''),
		(-111,''Column_Satellite_Column'',''L111'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Nov  2 2016  3:04:36.5348976AM +00:00''),
		(-110,''Journal_Exception'',''L110'',''RawLnk'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016  3:10:38.5097822AM +00:00''),
		(-109,''Table_Schedule'',''L109'',''RawLnk'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016  3:10:38.5097822AM +00:00''),
		(-108,''Run_Manifest'',''L108'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016  3:10:38.5097822AM +00:00''),
		(-107,''Manifest_Source'',''L107'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016  3:10:38.5097822AM +00:00''),
		(-106,''Column_Source'',''L106'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016  3:10:38.5097822AM +00:00''),
		(-104,''Link_Satellite'',''L104'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016  3:10:38.5097822AM +00:00''),
		(-103,''Hub_Link_Column'',''L103'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016  3:10:38.5097822AM +00:00''),
		(-102,''Hub_Column_Key'',''L102'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016  3:10:38.5097822AM +00:00''),
		(-101,''Hub_Satellite'',''L101'',''lnk'',''ODE_Metrics_Vault'',0,-1,''Sep  7 2016  3:10:38.5097822AM +00:00'')
			) AS src([link_key],[link_name],[link_abbreviation],[link_schema],[link_database],[is_retired],[release_key],[updated_datetime])
	ON
		trgt.[link_key] = src.[link_key]
	WHEN MATCHED THEN
		UPDATE SET
			[link_name] = src.[link_name]
		, [link_abbreviation] = src.[link_abbreviation]
		, [link_schema] = src.[link_schema]
		, [link_database] = src.[link_database]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([link_key],[link_name],[link_abbreviation],[link_schema],[link_database],[is_retired],[release_key],[updated_datetime])
		VALUES ([link_key],[link_name],[link_abbreviation],[link_schema],[link_database],[is_retired],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_link] OFF;', 12)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 10, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_hub_link] ON; MERGE INTO [dbo].[dv_hub_link] AS trgt USING	(VALUES (-130,-113,-112,-1,''Nov  2 2016 10:30:29.3351567PM +00:00''),
		(-129,-113,-120,-1,''Nov  2 2016 10:30:29.3351567PM +00:00''),
		(-128,-112,-103,-1,''Nov  2 2016  3:08:18.8093708AM +00:00''),
		(-127,-112,-112,-1,''Nov  2 2016  3:08:05.3723157AM +00:00''),
		(-126,-111,-112,-1,''Nov  2 2016  3:07:53.3882862AM +00:00''),
		(-125,-111,-106,-1,''Nov  2 2016  3:07:38.2012635AM +00:00''),
		(-124,-110,-118,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-123,-110,-117,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-122,-109,-115,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-121,-109,-114,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-120,-109,-105,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-119,-108,-107,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-118,-108,-108,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-117,-107,-108,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-116,-107,-105,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-115,-106,-105,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-114,-106,-106,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-111,-104,-103,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-110,-104,-102,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-109,-103,-102,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-108,-103,-106,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-107,-103,-109,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-106,-103,-101,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-105,-102,-106,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-104,-102,-109,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-103,-102,-101,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-102,-101,-103,-1,''Sep  7 2016  3:12:49.6161363AM +00:00''),
		(-101,-101,-101,-1,''Sep  7 2016  3:12:49.6161363AM +00:00'')
			) AS src([hub_link_key],[link_key],[hub_key],[release_key],[updated_datetime])
	ON
		trgt.[hub_link_key] = src.[hub_link_key]
	WHEN MATCHED THEN
		UPDATE SET
			[link_key] = src.[link_key]
		, [hub_key] = src.[hub_key]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([hub_link_key],[link_key],[hub_key],[release_key],[updated_datetime])
		VALUES ([hub_link_key],[link_key],[hub_key],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_hub_link] OFF;', 28)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 11, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_satellite] ON; MERGE INTO [dbo].[dv_satellite] AS trgt USING	(VALUES (-1039,0,-113,''L'',''Link_Satellite_Column_Function'',''s164'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Nov  2 2016 10:32:16.3799242PM +00:00''),
		(-1038,-120,0,''H'',''DV_Reference_Function'',''s163'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Nov  2 2016  9:56:16.1253311PM +00:00''),
		(-1037,0,-112,''L'',''Link_Satellite_Column_Satellite'',''S162'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Nov  2 2016  3:11:32.5847573AM +00:00''),
		(-1036,0,-111,''L'',''Link_Column_Satellite_Column'',''S161'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Nov  2 2016  3:11:05.9605465AM +00:00''),
		(-1035,-105,0,''H'',''DV_Source_Table'',''s160'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  2:12:03.2336303AM +00:00''),
		(-139,-105,0,''H'',''SourceTable_DataDictionary'',''s159'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-138,-109,0,''H'',''HubKey_DataDictionary'',''s158'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-137,-112,0,''H'',''Column_DataDictionary'',''s157'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Nov  3 2016 12:07:18.1433841AM +00:00''),
		(-136,-102,0,''H'',''Link_DataDictionary'',''s156'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-135,-103,0,''H'',''Satellite_DataDictionary'',''s155'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-134,-101,0,''H'',''Hub_DataDictionary'',''s154'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-133,0,-101,''L'',''Link_Hub_Satellite'',''s153'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-132,-112,0,''H'',''Satellite_Column_Integrity'',''s132'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Nov  2 2016 11:06:27.0585481PM +00:00''),
		(-131,-101,0,''H'',''Hub_Integrity'',''s131'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-130,-102,0,''H'',''Link_Integrity'',''s130'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-129,-103,0,''H'',''Satellite_Integrity'',''s129'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-128,0,-110,''L'',''Link_Journal_Exception'',''s128'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-127,0,-109,''L'',''Link_Table_Schedule'',''s127'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-126,0,-108,''L'',''Link_Run_Manifest'',''s126'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-125,0,-107,''L'',''Link_Manifest_Source'',''s125'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-124,0,-106,''L'',''Link_Column_Source'',''s124'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-122,0,-104,''L'',''Link_Link_Satellite'',''s122'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-121,0,-103,''L'',''Link_Hub_Link_Column'',''s121'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-120,0,-102,''L'',''Link_Hub_Column_Key'',''s120'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-119,-119,0,''H'',''log4_Severity'',''s139'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-118,-118,0,''H'',''DV_Journal'',''s118'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-117,-117,0,''H'',''DV_Exception'',''s117'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-116,-116,0,''H'',''DV_Schedule_Hierarchy'',''s116'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-115,-115,0,''H'',''DV_Schedule_Table'',''s115'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-114,-114,0,''H'',''DV_Schedule'',''s114'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-113,-113,0,''H'',''DV_Source_System'',''s113'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-112,-112,0,''H'',''DV_Satellite_Column'',''s112'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Nov  2 2016  1:20:01.8817948AM +00:00''),
		(-111,-111,0,''H'',''DV_Hub_Link'',''s111'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-110,-110,0,''H'',''DV_Hub_Column'',''s110'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  7 2016  3:24:42.3028503AM +00:00''),
		(-109,-109,0,''H'',''DV_Hub_Key'',''s109'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  1:52:18.8596479AM +00:00''),
		(-108,-108,0,''H'',''DV_Run_Manifest'',''s108'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  1:52:18.8596479AM +00:00''),
		(-107,-107,0,''H'',''DV_Schedule_Run'',''s107'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  1:52:18.8596479AM +00:00''),
		(-106,-106,0,''H'',''DV_Column'',''s106'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  1:52:18.8596479AM +00:00''),
		(-105,-105,0,''H'',''DV_Source_Table_Raw'',''s105'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  2:11:51.2596303AM +00:00''),
		(-104,-104,0,''H'',''DV_Release'',''s104'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  1:52:18.8596479AM +00:00''),
		(-103,-103,0,''H'',''DV_Satellite'',''s103'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  1:52:18.8596479AM +00:00''),
		(-102,-102,0,''H'',''DV_Link'',''s102'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  1:52:18.8596479AM +00:00''),
		(-101,-101,0,''H'',''DV_Hub'',''s101'',''sat'',''ODE_Metrics_Vault'',0,0,0,-1,''Sep  9 2016  1:52:18.8596479AM +00:00'')
			) AS src([satellite_key],[hub_key],[link_key],[link_hub_satellite_flag],[satellite_name],[satellite_abbreviation],[satellite_schema],[satellite_database],[duplicate_removal_threshold],[is_columnstore],[is_retired],[release_key],[updated_datetime])
	ON
		trgt.[satellite_key] = src.[satellite_key]
	WHEN MATCHED THEN
		UPDATE SET
			[hub_key] = src.[hub_key]
		, [link_key] = src.[link_key]
		, [link_hub_satellite_flag] = src.[link_hub_satellite_flag]
		, [satellite_name] = src.[satellite_name]
		, [satellite_abbreviation] = src.[satellite_abbreviation]
		, [satellite_schema] = src.[satellite_schema]
		, [satellite_database] = src.[satellite_database]
		, [duplicate_removal_threshold] = src.[duplicate_removal_threshold]
		, [is_columnstore] = src.[is_columnstore]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([satellite_key],[hub_key],[link_key],[link_hub_satellite_flag],[satellite_name],[satellite_abbreviation],[satellite_schema],[satellite_database],[duplicate_removal_threshold],[is_columnstore],[is_retired],[release_key],[updated_datetime])
		VALUES ([satellite_key],[hub_key],[link_key],[link_hub_satellite_flag],[satellite_name],[satellite_abbreviation],[satellite_schema],[satellite_database],[duplicate_removal_threshold],[is_columnstore],[is_retired],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_satellite] OFF;', 43)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 12, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_satellite_column] ON; MERGE INTO [dbo].[dv_satellite_column] AS trgt USING	(VALUES (-1335,-1039,''satellite_col_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016 10:29:25.2739183PM +00:00''),
		(-1334,-1039,''ref_function_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016 10:29:25.2739183PM +00:00''),
		(-1332,-1038,''version_number'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:36.7331249PM +00:00''),
		(-1331,-1038,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:36.7331249PM +00:00''),
		(-1330,-1038,''updated_by'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:36.7331249PM +00:00''),
		(-1329,-1038,''release_number'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:36.7331249PM +00:00''),
		(-1328,-1038,''release_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:36.7331249PM +00:00''),
		(-1327,-1038,''ref_function_name'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:36.7331249PM +00:00''),
		(-1326,-1038,''ref_function_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:36.7331249PM +00:00''),
		(-1325,-1038,''ref_function'',''nvarchar'',8000,0,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:36.7331249PM +00:00''),
		(-1323,-1038,''is_retired'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:36.7331249PM +00:00''),
		(-1322,-1037,''satellite_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1321,-1037,''satellite_col_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1320,-1036,''column_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1319,-1036,''satellite_col_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1318,-106,''satellite_col_key'',''int'',4,10,0,NULL,21,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1317,-112,''func_ordinal_position'',''int'',4,10,0,NULL,18,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1316,-112,''func_arguments'',''nvarchar'',512,0,0,NULL,17,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1315,-112,''ref_function_key'',''int'',4,10,0,NULL,16,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1314,-112,''satellite_ordinal_position'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1313,-112,''collation_name'',''varchar'',128,0,0,NULL,14,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1312,-112,''column_scale'',''int'',4,10,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1311,-112,''column_precision'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1310,-112,''column_length'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1309,-112,''column_type'',''varchar'',30,0,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1308,-112,''column_name'',''varchar'',128,0,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1306,-1035,''updated_by'',''varchar'',30,0,0,NULL,18,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1305,-1035,''update_date_time'',''datetimeoffset'',10,34,7,NULL,17,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1304,-1035,''timevault_name'',''varchar'',50,0,0,NULL,16,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1303,-1035,''source_table_schema'',''varchar'',128,0,0,NULL,15,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1302,-1035,''source_table_name'',''varchar'',128,0,0,NULL,14,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1301,-1035,''source_table_load_type'',''varchar'',50,0,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1300,-1035,''source_table_key'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1299,-1035,''source_system_release_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1298,-1035,''source_system_release_key'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1297,-1035,''source_system_name'',''varchar'',50,0,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1296,-1035,''source_system_key'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1295,-1035,''source_system_is_retired'',''bit'',1,1,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1294,-1035,''source_procedure_schema'',''varchar'',128,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1293,-1035,''source_procedure_name'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1292,-1035,''release_number'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1291,-1035,''release_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1290,-1035,''metrics_stage_run_time'',''datetimeoffset'',10,34,7,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1289,-1035,''is_retired'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1288,-105,''release_key'',''int'',4,10,0,NULL,14,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1287,-113,''release_key'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1286,-115,''release_key'',''int'',4,10,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1285,-116,''release_key'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1284,-114,''release_key'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1283,-112,''release_key'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1282,-111,''release_key'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1281,-110,''release_key'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1280,-102,''release_key'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1279,-109,''release_key'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1278,-103,''release_key'',''int'',4,10,0,NULL,17,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1277,-101,''release_key'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1276,-106,''release_key'',''int'',4,10,0,NULL,20,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1275,-119,''SeverityName'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1274,-119,''SeverityId'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-291,-139,''source_table_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-290,-139,''ShortDescription'',''varchar'',255,0,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-289,-139,''LongDescription'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-288,-138,''hub_key_column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-287,-138,''Description'',''varchar'',255,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-286,-138,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-285,-137,''Description'',''varchar'',255,0,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-284,-137,''column_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-283,-137,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-282,-136,''link_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-281,-136,''Description'',''varchar'',255,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-280,-136,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-279,-135,''satellite_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-278,-135,''Description'',''varchar'',255,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-277,-135,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-276,-134,''hub_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-275,-134,''Description'',''varchar'',255,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-274,-134,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-273,-132,''MaxLength'',''bigint'',8,19,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-272,-132,''MinLength'',''bigint'',8,19,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-271,-132,''BlankCount'',''bigint'',8,19,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-270,-132,''NullCount'',''bigint'',8,19,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-269,-132,''DomainCount'',''bigint'',8,19,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-268,-132,''MaxValue'',''varchar'',8000,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-267,-132,''MinValue'',''varchar'',8000,0,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-266,-132,''ColumnName'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-265,-132,''ColumnKey'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-257,-131,''TotalRowCount'',''bigint'',8,19,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-256,-131,''SourceTableName'',''varchar'',128,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-255,-131,''SourceTableKey'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-254,-131,''SourceSystemName'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-253,-131,''RunDate'',''datetimeoffset'',10,34,7,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-252,-131,''HubName'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-251,-131,''HubKey'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-250,-130,''TotalRowCount'',''bigint'',8,19,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-249,-130,''SourceTableName'',''varchar'',128,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-248,-130,''SourceTableKey'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-247,-130,''SourceSystemName'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-246,-130,''RunDate'',''datetimeoffset'',10,34,7,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-245,-130,''LinkName'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-244,-130,''LinkKey'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-243,-129,''VersionedRowCount'',''bigint'',8,19,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-242,-129,''TotalRowCount'',''bigint'',8,19,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-241,-129,''TombstoneRowCount'',''bigint'',8,19,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-240,-129,''SatelliteName'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-239,-129,''SatelliteKey'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-238,-129,''RunDate'',''datetimeoffset'',10,34,7,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-237,-129,''CurrentRowCount'',''bigint'',8,19,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-236,-128,''JournalId'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-235,-128,''ExceptionId'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-234,-127,''source_table_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-233,-127,''schedule_table_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-232,-127,''schedule_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-231,-126,''run_manifest_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-230,-126,''run_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-229,-125,''source_table_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-228,-125,''run_manifest_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-227,-124,''source_table_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-226,-124,''column_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-223,-122,''satellite_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-222,-122,''link_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-221,-121,''link_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-220,-121,''hub_key_column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-219,-121,''hub_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-218,-121,''column_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-217,-120,''hub_key_column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-216,-120,''hub_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-215,-120,''column_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-214,-133,''satellite_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-213,-133,''hub_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-212,-118,''UtcDate'',''datetime'',8,23,3,NULL,21,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-211,-118,''Task'',''varchar'',128,0,0,NULL,20,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-210,-118,''SystemDate'',''datetime'',8,23,3,NULL,19,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-209,-118,''StepInFunction'',''varchar'',128,0,0,NULL,18,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-208,-118,''SeverityId'',''int'',4,10,0,NULL,17,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-207,-118,''SessionLoginTime'',''datetime'',8,23,3,NULL,16,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-206,-118,''SessionId'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-205,-118,''ServerName'',''nvarchar'',256,0,0,NULL,14,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-204,-118,''ProgramName'',''nvarchar'',256,0,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-203,-118,''OriginalLoginName'',''nvarchar'',256,0,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-202,-118,''NTUsername'',''nvarchar'',256,0,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-201,-118,''NTDomain'',''nvarchar'',256,0,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-200,-118,''MessageText'',''varchar'',512,0,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-199,-118,''LoginName'',''nvarchar'',256,0,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-198,-118,''JournalId'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-197,-118,''HostName'',''nvarchar'',256,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-196,-118,''FunctionName'',''varchar'',256,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-195,-118,''ExtraInfo'',''varchar'',-1,0,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-194,-118,''ExceptionId'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-193,-118,''DatabaseName'',''nvarchar'',256,0,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-192,-117,''UtcDate'',''datetime'',8,23,3,NULL,21,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-191,-117,''SystemDate'',''datetime'',8,23,3,NULL,20,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-190,-117,''SessionLoginTime'',''datetime'',8,23,3,NULL,19,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-189,-117,''SessionId'',''int'',4,10,0,NULL,18,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-188,-117,''ServerName'',''nvarchar'',256,0,0,NULL,17,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-187,-117,''ProgramName'',''nvarchar'',256,0,0,NULL,16,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-186,-117,''OriginalLoginName'',''nvarchar'',256,0,0,NULL,15,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-185,-117,''NTUsername'',''nvarchar'',256,0,0,NULL,14,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-184,-117,''NTDomain'',''nvarchar'',256,0,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-183,-117,''LoginName'',''nvarchar'',256,0,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-182,-117,''HostName'',''nvarchar'',256,0,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-181,-117,''ExceptionId'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-180,-117,''ErrorState'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-179,-117,''ErrorSeverity'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-178,-117,''ErrorProcedure'',''nvarchar'',256,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-177,-117,''ErrorNumber'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-176,-117,''ErrorMessage'',''nvarchar'',-1,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-175,-117,''ErrorLine'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-174,-117,''ErrorContext'',''nvarchar'',1024,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-173,-117,''DatabaseName'',''nvarchar'',256,0,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-172,-116,''version_number'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-171,-116,''updated_by'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-170,-116,''update_date_time'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-169,-116,''source_table_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-168,-116,''source_table_hierarchy_key'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-167,-116,''release_number'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-166,-116,''prior_table_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-165,-116,''is_cancelled'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-164,-115,''version_number'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-163,-115,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-162,-115,''updated_by'',''varchar'',30,0,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-161,-115,''source_table_load_type'',''varchar'',50,0,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-160,-115,''source_table_key'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-159,-115,''schedule_source_table_key'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-158,-115,''schedule_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-157,-115,''release_number'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-156,-115,''queue'',''varchar'',50,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-155,-115,''priority'',''varchar'',50,0,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-154,-115,''is_cancelled'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-153,-114,''version_number'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-152,-114,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-151,-114,''updated_by'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-150,-114,''schedule_name'',''varchar'',128,0,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-149,-114,''schedule_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-148,-114,''schedule_frequency'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-147,-114,''schedule_description'',''varchar'',256,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-146,-114,''release_number'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-145,-114,''is_cancelled'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-144,-113,''version_number'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-143,-113,''updated_by'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-142,-113,''update_date_time'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-141,-113,''timevault_name'',''varchar'',50,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-140,-113,''source_system_name'',''varchar'',50,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-139,-113,''source_system_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-138,-113,''release_number'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-137,-113,''is_retired'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-136,-112,''version_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-135,-112,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-134,-112,''updated_by'',''varchar'',30,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-133,-112,''satellite_key'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-132,-112,''satellite_col_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-131,-112,''release_number'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-129,-111,''version_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-128,-111,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-127,-111,''updated_by'',''varchar'',30,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-126,-111,''release_number'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-125,-111,''link_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-124,-111,''hub_link_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-123,-111,''hub_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-122,-110,''version_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-121,-110,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-120,-110,''updated_by'',''varchar'',30,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-119,-110,''release_number'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-118,-110,''hub_key_column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-117,-110,''hub_col_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-116,-110,''column_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-115,-109,''version_number'',''int'',4,10,0,NULL,14,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-114,-109,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-113,-109,''updated_by'',''varchar'',30,0,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-112,-109,''release_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-111,-109,''hub_key_ordinal_position'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-110,-109,''hub_key_column_type'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-109,-109,''hub_key_column_scale'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-108,-109,''hub_key_column_precision'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-107,-109,''hub_key_column_name'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-106,-109,''hub_key_column_length'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-105,-109,''hub_key_column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-104,-109,''hub_key_Collation_Name'',''nvarchar'',256,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-103,-109,''hub_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-102,-108,''start_datetime'',''datetimeoffset'',10,34,7,NULL,18,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-101,-108,''source_timevault'',''varchar'',50,0,0,NULL,17,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-100,-108,''source_table_schema'',''nvarchar'',256,0,0,NULL,16,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-99,-108,''source_table_name'',''nvarchar'',256,0,0,NULL,15,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-98,-108,''source_table_load_type'',''varchar'',50,0,0,NULL,14,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-97,-108,''source_table_key'',''int'',4,10,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-96,-108,''source_system_name'',''varchar'',50,0,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-95,-108,''source_procedure_schema'',''varchar'',128,0,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-94,-108,''source_procedure_name'',''varchar'',128,0,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-93,-108,''session_id'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-92,-108,''run_status'',''varchar'',128,0,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-91,-108,''run_manifest_key'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-90,-108,''run_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-89,-108,''row_count'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-88,-108,''queue'',''varchar'',10,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-87,-108,''priority'',''varchar'',10,0,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-86,-108,''completed_datetime'',''datetimeoffset'',10,34,7,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-85,-107,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-84,-107,''run_status'',''varchar'',128,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-83,-107,''run_start_datetime'',''datetimeoffset'',10,34,7,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-82,-107,''run_schedule_name'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-81,-107,''run_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-80,-107,''run_end_datetime'',''datetimeoffset'',10,34,7,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-79,-106,''version_number'',''int'',4,10,0,NULL,19,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-78,-106,''updated_by'',''varchar'',30,0,0,NULL,18,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-77,-106,''update_date_time'',''datetimeoffset'',10,34,7,NULL,17,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-76,-106,''table_key'',''int'',4,10,0,NULL,16,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-75,-106,''source_ordinal_position'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-73,-106,''release_number'',''int'',4,10,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-72,-106,''is_source_date'',''bit'',1,1,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-71,-106,''is_retired'',''bit'',1,1,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-69,-106,''column_type'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-68,-106,''column_scale'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-67,-106,''column_precision'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-66,-106,''column_name'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-65,-106,''column_length'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-64,-106,''column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-63,-106,''Collation_Name'',''nvarchar'',256,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-62,-106,''bk_ordinal_position'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-61,-105,''version_number'',''int'',4,10,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-60,-105,''updated_by'',''varchar'',30,0,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-59,-105,''update_date_time'',''datetimeoffset'',10,34,7,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-58,-105,''system_key'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-57,-105,''source_table_schema'',''varchar'',128,0,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-56,-105,''source_table_name'',''varchar'',128,0,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-55,-105,''source_table_load_type'',''varchar'',50,0,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-54,-105,''source_table_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-53,-105,''source_procedure_schema'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-52,-105,''source_procedure_name'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-51,-105,''release_number'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-50,-105,''is_retired'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-49,-104,''version_number'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-48,-104,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,14,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-47,-104,''updated_by'',''varchar'',30,0,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-46,-104,''release_start_datetime'',''datetimeoffset'',10,34,7,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-45,-104,''release_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-44,-104,''release_description'',''varchar'',256,0,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-43,-104,''release_count'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-42,-104,''release_complete_datetime'',''datetimeoffset'',10,34,7,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-41,-104,''release_built_by'',''varchar'',30,0,0,NULL,7,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-40,-104,''reference_source'',''varchar'',50,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-39,-104,''reference_number'',''varchar'',50,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-38,-104,''build_server'',''varchar'',256,0,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-37,-104,''build_number'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-36,-104,''build_date'',''datetimeoffset'',10,34,7,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-35,-103,''version_number'',''int'',4,10,0,NULL,16,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-34,-103,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,15,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-33,-103,''updated_by'',''varchar'',30,0,0,NULL,14,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-32,-103,''satellite_schema'',''varchar'',128,0,0,NULL,13,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-31,-103,''satellite_name'',''varchar'',128,0,0,NULL,12,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-30,-103,''satellite_key'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-29,-103,''satellite_database'',''varchar'',128,0,0,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-28,-103,''satellite_abbreviation'',''varchar'',4,0,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-27,-103,''release_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-26,-103,''link_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-25,-103,''link_hub_satellite_flag'',''char'',1,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-24,-103,''is_retired'',''bit'',1,1,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-23,-103,''is_columnstore'',''bit'',1,1,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-22,-103,''hub_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-21,-103,''duplicate_removal_threshold'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-20,-102,''version_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-19,-102,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-18,-102,''updated_by'',''varchar'',30,0,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-17,-102,''release_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-16,-102,''link_schema'',''varchar'',128,0,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-15,-102,''link_name'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-14,-102,''link_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-13,-102,''link_database'',''varchar'',128,0,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-12,-102,''link_abbreviation'',''varchar'',4,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-11,-102,''is_retired'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-10,-101,''version_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-9,-101,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,10,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-8,-101,''updated_by'',''varchar'',30,0,0,NULL,9,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-7,-101,''release_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-6,-101,''is_retired'',''bit'',1,1,0,NULL,6,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-5,-101,''hub_schema'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-4,-101,''hub_name'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-3,-101,''hub_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-2,-101,''hub_database'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00''),
		(-1,-101,''hub_abbreviation'',''varchar'',4,0,0,NULL,1,NULL,NULL,0,-1,''Nov  2 2016  9:57:22.2490405PM +00:00'')
			) AS src([satellite_col_key],[satellite_key],[column_name],[column_type],[column_length],[column_precision],[column_scale],[collation_name],[satellite_ordinal_position],[ref_function_key],[func_arguments],[func_ordinal_position],[release_key],[updated_datetime])
	ON
		trgt.[satellite_col_key] = src.[satellite_col_key]
	WHEN MATCHED THEN
		UPDATE SET
			[satellite_key] = src.[satellite_key]
		, [column_name] = src.[column_name]
		, [column_type] = src.[column_type]
		, [column_length] = src.[column_length]
		, [column_precision] = src.[column_precision]
		, [column_scale] = src.[column_scale]
		, [collation_name] = src.[collation_name]
		, [satellite_ordinal_position] = src.[satellite_ordinal_position]
		, [ref_function_key] = src.[ref_function_key]
		, [func_arguments] = src.[func_arguments]
		, [func_ordinal_position] = src.[func_ordinal_position]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([satellite_col_key],[satellite_key],[column_name],[column_type],[column_length],[column_precision],[column_scale],[collation_name],[satellite_ordinal_position],[ref_function_key],[func_arguments],[func_ordinal_position],[release_key],[updated_datetime])
		VALUES ([satellite_col_key],[satellite_key],[column_name],[column_type],[column_length],[column_precision],[column_scale],[collation_name],[satellite_ordinal_position],[ref_function_key],[func_arguments],[func_ordinal_position],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_satellite_column] OFF;', 338)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 13, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_column] ON; MERGE INTO [dbo].[dv_column] AS trgt USING	(VALUES (-1355,-1038,-1335,''satellite_col_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-1354,-1038,-1334,''ref_function_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-1352,-1037,-1332,''version_number'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-1351,-1037,-1331,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,10,0,0,-1),
		(-1350,-1037,-1330,''updated_by'',''varchar'',30,0,0,NULL,0,9,0,0,-1),
		(-1349,-1037,-1329,''release_number'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-1348,-1037,-1328,''release_key'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-1347,-1037,-1327,''ref_function_name'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-1346,-1037,-1326,''ref_function_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-1345,-1037,-1325,''ref_function'',''nvarchar'',8000,0,0,NULL,0,4,0,0,-1),
		(-1343,-1037,-1323,''is_retired'',''bit'',1,1,0,NULL,0,5,0,0,-1),
		(-1342,-1036,-1322,''satellite_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-1341,-1036,-1321,''satellite_col_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-1340,-1035,-1320,''column_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-1339,-1035,-1319,''satellite_col_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-1338,-112,-1316,''func_arguments'',''nvarchar'',512,0,0,NULL,0,19,0,0,-1),
		(-1337,-112,-1317,''func_ordinal_position'',''int'',4,0,0,NULL,0,18,0,0,-1),
		(-1336,-112,-1315,''ref_function_key'',''int'',4,0,0,NULL,0,17,0,0,-1),
		(-1335,-112,-1314,''satellite_ordinal_position'',''int'',4,0,0,NULL,0,16,0,0,-1),
		(-1334,-112,-1313,''collation_name'',''varchar'',128,0,0,NULL,0,15,0,0,-1),
		(-1333,-112,-1312,''column_scale'',''int'',4,10,0,NULL,0,14,0,0,-1),
		(-1332,-112,-1311,''column_precision'',''int'',4,10,0,NULL,0,13,0,0,-1),
		(-1331,-112,-1310,''column_length'',''int'',4,10,0,NULL,0,12,0,0,-1),
		(-1330,-112,-1309,''column_type'',''varchar'',30,0,0,NULL,0,11,0,0,-1),
		(-1329,-112,-1308,''column_name'',''varchar'',128,0,0,NULL,0,10,0,0,-1),
		(-1328,-106,-1318,''satellite_col_key'',''int'',4,10,0,NULL,0,21,0,0,-1),
		(-1327,-1034,-1306,''updated_by'',''varchar'',30,0,0,NULL,0,17,0,0,-1),
		(-1326,-1034,-1305,''update_date_time'',''datetimeoffset'',10,34,7,NULL,0,18,0,0,-1),
		(-1325,-1034,-1304,''timevault_name'',''varchar'',50,0,0,NULL,0,6,0,0,-1),
		(-1324,-1034,-1303,''source_table_schema'',''varchar'',128,0,0,NULL,0,9,0,0,-1),
		(-1323,-1034,-1302,''source_table_name'',''varchar'',128,0,0,NULL,0,10,0,0,-1),
		(-1322,-1034,-1301,''source_table_load_type'',''varchar'',50,0,0,NULL,0,11,0,0,-1),
		(-1321,-1034,-1300,''source_table_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-1320,-1034,-1299,''source_system_release_number'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-1319,-1034,-1298,''source_system_release_key'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-1318,-1034,-1297,''source_system_name'',''varchar'',50,0,0,NULL,0,5,0,0,-1),
		(-1317,-1034,-1296,''source_system_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-1316,-1034,-1295,''source_system_is_retired'',''bit'',1,1,0,NULL,0,4,0,0,-1),
		(-1315,-1034,-1294,''source_procedure_schema'',''varchar'',128,0,0,NULL,0,12,0,0,-1),
		(-1314,-1034,-1293,''source_procedure_name'',''varchar'',128,0,0,NULL,0,13,0,0,-1),
		(-1313,-1034,-1292,''release_number'',''int'',4,10,0,NULL,0,16,0,0,-1),
		(-1312,-1034,-1291,''release_key'',''int'',4,10,0,NULL,0,15,0,0,-1),
		(-1311,-1034,-1290,''metrics_stage_run_time'',''datetimeoffset'',10,34,7,NULL,0,1,0,0,-1),
		(-1310,-1034,-1289,''is_retired'',''bit'',1,1,0,NULL,0,14,0,0,-1),
		(-1309,-105,-1288,''release_key'',''int'',4,10,0,NULL,0,14,0,0,-1),
		(-1308,-113,-1287,''release_key'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-1307,-115,-1286,''release_key'',''int'',4,10,0,NULL,0,13,0,0,-1),
		(-1306,-116,-1285,''release_key'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-1305,-114,-1284,''release_key'',''int'',4,10,0,NULL,0,11,0,0,-1),
		(-1304,-112,-1283,''release_key'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-1303,-111,-1282,''release_key'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-1302,-110,-1281,''release_key'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-1301,-102,-1280,''release_key'',''int'',4,10,0,NULL,0,12,0,0,-1),
		(-1300,-109,-1279,''release_key'',''int'',4,10,0,NULL,0,15,0,0,-1),
		(-1299,-103,-1278,''release_key'',''int'',4,10,0,NULL,0,17,0,0,-1),
		(-1298,-101,-1277,''release_key'',''int'',4,10,0,NULL,0,12,0,0,-1),
		(-1297,-106,-1276,''release_key'',''int'',4,10,0,NULL,0,20,0,0,-1),
		(-1296,-139,-1275,''SeverityName'',''varchar'',128,0,0,NULL,0,2,0,0,-1),
		(-1295,-139,-1274,''SeverityId'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-450,-108,-92,''run_status'',''varchar'',128,0,0,NULL,0,16,0,0,-1),
		(-449,-108,-91,''run_manifest_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-448,-108,-90,''run_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-447,-108,-89,''row_count'',''int'',4,10,0,NULL,0,17,0,0,-1),
		(-446,-108,-88,''queue'',''varchar'',10,0,0,NULL,0,13,0,0,-1),
		(-445,-108,-87,''priority'',''varchar'',10,0,0,NULL,0,12,0,0,-1),
		(-443,-108,-86,''completed_datetime'',''datetimeoffset'',10,34,7,NULL,0,15,0,0,-1),
		(-442,-107,-85,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,7,0,0,-1),
		(-441,-107,-84,''run_status'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-440,-107,-83,''run_start_datetime'',''datetimeoffset'',10,34,7,NULL,0,5,0,0,-1),
		(-439,-107,-82,''run_schedule_name'',''varchar'',128,0,0,NULL,0,4,0,0,-1),
		(-438,-107,-81,''run_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-437,-107,-80,''run_end_datetime'',''datetimeoffset'',10,34,7,NULL,0,6,0,0,-1),
		(-435,-106,-79,''version_number'',''int'',4,10,0,NULL,0,17,0,0,-1),
		(-434,-106,-78,''updated_by'',''varchar'',30,0,0,NULL,0,18,0,0,-1),
		(-433,-106,-77,''update_date_time'',''datetimeoffset'',10,34,7,NULL,0,19,0,0,-1),
		(-432,-106,-76,''table_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-431,-106,-75,''source_ordinal_position'',''int'',4,10,0,NULL,0,11,0,0,-1),
		(-429,-106,-73,''release_number'',''int'',4,10,0,NULL,0,16,0,0,-1),
		(-427,-106,-72,''is_source_date'',''bit'',1,1,0,NULL,0,13,0,0,-1),
		(-426,-106,-71,''is_retired'',''bit'',1,1,0,NULL,0,15,0,0,-1),
		(-424,-106,-69,''column_type'',''varchar'',30,0,0,NULL,0,5,0,0,-1),
		(-423,-106,-68,''column_scale'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-422,-106,-67,''column_precision'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-421,-106,-66,''column_name'',''varchar'',128,0,0,NULL,0,4,0,0,-1),
		(-420,-106,-65,''column_length'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-419,-106,-64,''column_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-418,-106,-63,''Collation_Name'',''nvarchar'',256,0,0,NULL,0,9,0,0,-1),
		(-417,-106,-62,''bk_ordinal_position'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-416,-105,-61,''version_number'',''int'',4,10,0,NULL,0,11,0,0,-1),
		(-415,-105,-60,''updated_by'',''varchar'',30,0,0,NULL,0,12,0,0,-1),
		(-414,-105,-59,''update_date_time'',''datetimeoffset'',10,34,7,NULL,0,13,0,0,-1),
		(-413,-105,-58,''system_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-412,-105,-57,''source_table_schema'',''varchar'',128,0,0,NULL,0,4,0,0,-1),
		(-411,-105,-56,''source_table_name'',''varchar'',128,0,0,NULL,0,5,0,0,-1),
		(-410,-105,-55,''source_table_load_type'',''varchar'',50,0,0,NULL,0,6,0,0,-1),
		(-409,-105,-54,''source_table_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-408,-105,-53,''source_procedure_schema'',''varchar'',128,0,0,NULL,0,7,0,0,-1),
		(-407,-105,-52,''source_procedure_name'',''varchar'',128,0,0,NULL,0,8,0,0,-1),
		(-406,-105,-51,''release_number'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-404,-105,-50,''is_retired'',''bit'',1,1,0,NULL,0,9,0,0,-1),
		(-403,-104,-49,''version_number'',''int'',4,10,0,NULL,0,13,0,0,-1),
		(-402,-104,-48,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,15,0,0,-1),
		(-401,-104,-47,''updated_by'',''varchar'',30,0,0,NULL,0,14,0,0,-1),
		(-400,-104,-46,''release_start_datetime'',''datetimeoffset'',10,34,7,NULL,0,10,0,0,-1),
		(-399,-104,-45,''release_number'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-398,-104,-44,''release_description'',''varchar'',256,0,0,NULL,0,3,0,0,-1),
		(-397,-104,-43,''release_count'',''int'',4,10,0,NULL,0,12,0,0,-1),
		(-396,-104,-42,''release_complete_datetime'',''datetimeoffset'',10,34,7,NULL,0,11,0,0,-1),
		(-395,-104,-41,''release_built_by'',''varchar'',30,0,0,NULL,0,9,0,0,-1),
		(-394,-104,-40,''reference_source'',''varchar'',50,0,0,NULL,0,5,0,0,-1),
		(-393,-104,-39,''reference_number'',''varchar'',50,0,0,NULL,0,4,0,0,-1),
		(-391,-104,-38,''build_server'',''varchar'',256,0,0,NULL,0,8,0,0,-1),
		(-390,-104,-37,''build_number'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-389,-104,-36,''build_date'',''datetimeoffset'',10,34,7,NULL,0,7,0,0,-1),
		(-388,-103,-35,''version_number'',''int'',4,10,0,NULL,0,14,0,0,-1),
		(-387,-103,-34,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,16,0,0,-1),
		(-386,-103,-33,''updated_by'',''varchar'',30,0,0,NULL,0,15,0,0,-1),
		(-385,-103,-32,''satellite_schema'',''varchar'',128,0,0,NULL,0,8,0,0,-1),
		(-384,-103,-31,''satellite_name'',''varchar'',128,0,0,NULL,0,6,0,0,-1),
		(-383,-103,-30,''satellite_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-382,-103,-29,''satellite_database'',''varchar'',128,0,0,NULL,0,9,0,0,-1),
		(-381,-103,-28,''satellite_abbreviation'',''varchar'',4,0,0,NULL,0,7,0,0,-1),
		(-380,-103,-27,''release_number'',''int'',4,10,0,NULL,0,13,0,0,-1),
		(-378,-103,-26,''link_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-377,-103,-25,''link_hub_satellite_flag'',''char'',1,0,0,NULL,0,5,0,0,-1),
		(-376,-103,-24,''is_retired'',''bit'',1,1,0,NULL,0,12,0,0,-1),
		(-375,-103,-23,''is_columnstore'',''bit'',1,1,0,NULL,0,11,0,0,-1),
		(-374,-103,-22,''hub_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-373,-103,-21,''duplicate_removal_threshold'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-372,-102,-20,''version_number'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-371,-102,-19,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,11,0,0,-1),
		(-370,-102,-18,''updated_by'',''varchar'',30,0,0,NULL,0,10,0,0,-1),
		(-369,-102,-17,''release_number'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-367,-102,-16,''link_schema'',''varchar'',128,0,0,NULL,0,5,0,0,-1),
		(-366,-102,-15,''link_name'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-365,-102,-14,''link_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-364,-102,-13,''link_database'',''varchar'',128,0,0,NULL,0,6,0,0,-1),
		(-363,-102,-12,''link_abbreviation'',''varchar'',4,0,0,NULL,0,4,0,0,-1),
		(-362,-102,-11,''is_retired'',''bit'',1,1,0,NULL,0,7,0,0,-1),
		(-361,-101,-10,''version_number'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-360,-101,-9,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,11,0,0,-1),
		(-359,-101,-8,''updated_by'',''varchar'',30,0,0,NULL,0,10,0,0,-1),
		(-358,-101,-7,''release_number'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-356,-101,-6,''is_retired'',''bit'',1,1,0,NULL,0,7,0,0,-1),
		(-355,-101,-5,''hub_schema'',''varchar'',128,0,0,NULL,0,5,0,0,-1),
		(-354,-101,-4,''hub_name'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-353,-101,-3,''hub_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-352,-101,-2,''hub_database'',''varchar'',128,0,0,NULL,0,6,0,0,-1),
		(-351,-101,-1,''hub_abbreviation'',''varchar'',4,0,0,NULL,0,4,0,0,-1),
		(-318,-138,-291,''source_table_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-317,-138,-290,''ShortDescription'',''varchar'',255,0,0,NULL,0,2,0,0,-1),
		(-315,-138,-289,''LongDescription'',''varchar'',8000,0,0,NULL,0,3,0,0,-1),
		(-313,-137,-288,''hub_key_column_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-312,-137,-287,''Description'',''varchar'',255,0,0,NULL,0,2,0,0,-1),
		(-311,-137,-286,''BusinessRule'',''varchar'',8000,0,0,NULL,0,3,0,0,-1),
		(-309,-136,-285,''Description'',''varchar'',255,0,0,NULL,0,2,0,0,-1),
		(-308,-136,-284,''column_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-307,-136,-283,''BusinessRule'',''varchar'',8000,0,0,NULL,0,3,0,0,-1),
		(-305,-135,-282,''link_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-304,-135,-281,''Description'',''varchar'',255,0,0,NULL,0,2,0,0,-1),
		(-303,-135,-280,''BusinessRule'',''varchar'',8000,0,0,NULL,0,3,0,0,-1),
		(-302,-134,-279,''satellite_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-300,-134,-278,''Description'',''varchar'',255,0,0,NULL,0,2,0,0,-1),
		(-299,-134,-277,''BusinessRule'',''varchar'',8000,0,0,NULL,0,3,0,0,-1),
		(-297,-133,-276,''hub_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-296,-133,-275,''Description'',''varchar'',255,0,0,NULL,0,2,0,0,-1),
		(-295,-133,-274,''BusinessRule'',''varchar'',8000,0,0,NULL,0,3,0,0,-1),
		(-294,-132,-273,''MaxLength'',''bigint'',8,19,0,NULL,9,9,0,0,-1),
		(-293,-132,-272,''MinLength'',''bigint'',8,19,0,NULL,8,8,0,0,-1),
		(-292,-132,-271,''blank_count'',''bigint'',8,19,0,NULL,7,7,0,0,-1),
		(-291,-132,-270,''null_count'',''bigint'',8,19,0,NULL,6,6,0,0,-1),
		(-290,-132,-269,''domain_count'',''bigint'',8,19,0,NULL,5,5,0,0,-1),
		(-289,-132,-268,''max_value'',''varchar'',8000,0,0,NULL,4,4,0,0,-1),
		(-288,-132,-267,''min_value'',''varchar'',8000,0,0,NULL,3,3,0,0,-1),
		(-287,-132,-266,''column_name'',''varchar'',128,0,0,NULL,2,2,0,0,-1),
		(-286,-132,-265,''column_key'',''int'',4,10,0,NULL,1,1,0,0,-1),
		(-285,-131,-257,''TotalRowCount'',''bigint'',8,19,0,NULL,0,7,0,0,-1),
		(-284,-131,-256,''SourceTableName'',''varchar'',128,0,0,NULL,0,6,0,0,-1),
		(-283,-131,-255,''SourceTableKey'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-282,-131,-254,''SourceSystemName'',''varchar'',128,0,0,NULL,0,5,0,0,-1),
		(-281,-131,-253,''RunDate'',''datetimeoffset'',10,34,7,NULL,0,1,0,0,-1),
		(-280,-131,-252,''HubName'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-279,-131,-251,''HubKey'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-278,-130,-250,''TotalRowCount'',''bigint'',8,19,0,NULL,0,7,0,0,-1),
		(-277,-130,-249,''SourceTableName'',''varchar'',128,0,0,NULL,0,6,0,0,-1),
		(-276,-130,-248,''SourceTableKey'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-275,-130,-247,''SourceSystemName'',''varchar'',128,0,0,NULL,0,5,0,0,-1),
		(-274,-130,-246,''RunDate'',''datetimeoffset'',10,34,7,NULL,0,1,0,0,-1),
		(-273,-130,-245,''LinkName'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-272,-130,-244,''LinkKey'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-271,-129,-243,''VersionedRowCount'',''bigint'',8,19,0,NULL,0,6,0,0,-1),
		(-270,-129,-242,''TotalRowCount'',''bigint'',8,19,0,NULL,0,4,0,0,-1),
		(-269,-129,-241,''TombstoneRowCount'',''bigint'',8,19,0,NULL,0,7,0,0,-1),
		(-268,-129,-240,''SatelliteName'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-267,-129,-239,''SatelliteKey'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-266,-129,-238,''RunDate'',''datetimeoffset'',10,34,7,NULL,0,1,0,0,-1),
		(-265,-129,-237,''CurrentRowCount'',''bigint'',8,19,0,NULL,0,5,0,0,-1),
		(-263,-128,-236,''JournalId'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-262,-128,-235,''ExceptionId'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-261,-127,-234,''source_table_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-260,-127,-233,''schedule_table_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-259,-127,-232,''schedule_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-257,-126,-231,''run_manifest_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-256,-126,-230,''run_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-254,-125,-229,''source_table_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-253,-125,-228,''run_manifest_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-251,-124,-227,''source_table_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-249,-124,-226,''column_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-245,-122,-223,''satellite_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-243,-122,-222,''link_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-241,-121,-221,''link_key'',''int'',4,10,0,NULL,0,5,0,0,-1),
		(-240,-121,-220,''hub_key_column_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-239,-121,-219,''hub_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-238,-121,-218,''column_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-236,-120,-217,''hub_key_column_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-235,-120,-216,''hub_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-234,-120,-215,''column_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-233,-119,-214,''satellite_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-231,-119,-213,''hub_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-230,-118,-212,''UtcDate'',''datetime'',8,23,3,NULL,0,3,0,0,-1),
		(-229,-118,-211,''Task'',''varchar'',128,0,0,NULL,0,5,0,0,-1),
		(-228,-118,-210,''SystemDate'',''datetime'',8,23,3,NULL,0,4,0,0,-1),
		(-227,-118,-209,''StepInFunction'',''varchar'',128,0,0,NULL,0,7,0,0,-1),
		(-226,-118,-208,''SeverityId'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-225,-118,-207,''SessionLoginTime'',''datetime'',8,23,3,NULL,0,20,0,0,-1),
		(-224,-118,-206,''SessionId'',''int'',4,10,0,NULL,0,11,0,0,-1),
		(-223,-118,-205,''ServerName'',''nvarchar'',256,0,0,NULL,0,12,0,0,-1),
		(-222,-118,-204,''ProgramName'',''nvarchar'',256,0,0,NULL,0,15,0,0,-1),
		(-221,-118,-203,''OriginalLoginName'',''nvarchar'',256,0,0,NULL,0,19,0,0,-1),
		(-220,-118,-202,''NTUsername'',''nvarchar'',256,0,0,NULL,0,17,0,0,-1),
		(-219,-118,-201,''NTDomain'',''nvarchar'',256,0,0,NULL,0,16,0,0,-1),
		(-217,-118,-200,''MessageText'',''varchar'',512,0,0,NULL,0,8,0,0,-1),
		(-216,-118,-199,''LoginName'',''nvarchar'',256,0,0,NULL,0,18,0,0,-1),
		(-215,-118,-198,''JournalId'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-214,-118,-197,''HostName'',''nvarchar'',256,0,0,NULL,0,14,0,0,-1),
		(-213,-118,-196,''FunctionName'',''varchar'',256,0,0,NULL,0,6,0,0,-1),
		(-212,-118,-195,''ExtraInfo'',''varchar'',-1,0,0,NULL,0,21,0,0,-1),
		(-211,-118,-194,''ExceptionId'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-210,-118,-193,''DatabaseName'',''nvarchar'',256,0,0,NULL,0,13,0,0,-1),
		(-209,-117,-192,''UtcDate'',''datetime'',8,23,3,NULL,0,3,0,0,-1),
		(-208,-117,-191,''SystemDate'',''datetime'',8,23,3,NULL,0,4,0,0,-1),
		(-207,-117,-190,''SessionLoginTime'',''datetime'',8,23,3,NULL,0,21,0,0,-1),
		(-206,-117,-189,''SessionId'',''int'',4,10,0,NULL,0,12,0,0,-1),
		(-205,-117,-188,''ServerName'',''nvarchar'',256,0,0,NULL,0,13,0,0,-1),
		(-204,-117,-187,''ProgramName'',''nvarchar'',256,0,0,NULL,0,16,0,0,-1),
		(-203,-117,-186,''OriginalLoginName'',''nvarchar'',256,0,0,NULL,0,20,0,0,-1),
		(-202,-117,-185,''NTUsername'',''nvarchar'',256,0,0,NULL,0,18,0,0,-1),
		(-201,-117,-184,''NTDomain'',''nvarchar'',256,0,0,NULL,0,17,0,0,-1),
		(-199,-117,-183,''LoginName'',''nvarchar'',256,0,0,NULL,0,19,0,0,-1),
		(-198,-117,-182,''HostName'',''nvarchar'',256,0,0,NULL,0,15,0,0,-1),
		(-197,-117,-181,''ExceptionId'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-196,-117,-180,''ErrorState'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-195,-117,-179,''ErrorSeverity'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-194,-117,-178,''ErrorProcedure'',''nvarchar'',256,0,0,NULL,0,9,0,0,-1),
		(-193,-117,-177,''ErrorNumber'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-192,-117,-176,''ErrorMessage'',''nvarchar'',-1,0,0,NULL,0,11,0,0,-1),
		(-191,-117,-175,''ErrorLine'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-190,-117,-174,''ErrorContext'',''nvarchar'',1024,0,0,NULL,0,5,0,0,-1),
		(-189,-117,-173,''DatabaseName'',''nvarchar'',256,0,0,NULL,0,14,0,0,-1),
		(-188,-116,-172,''version_number'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-187,-116,-171,''updated_by'',''varchar'',30,0,0,NULL,0,8,0,0,-1),
		(-186,-116,-170,''update_date_time'',''datetimeoffset'',10,34,7,NULL,0,9,0,0,-1),
		(-185,-116,-169,''source_table_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-184,-116,-168,''source_table_hierarchy_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-183,-116,-167,''release_number'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-182,-116,-166,''prior_table_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-180,-116,-165,''is_cancelled'',''bit'',1,1,0,NULL,0,5,0,0,-1),
		(-179,-115,-164,''version_number'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-178,-115,-163,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,12,0,0,-1),
		(-177,-115,-162,''updated_by'',''varchar'',30,0,0,NULL,0,11,0,0,-1),
		(-176,-115,-161,''source_table_load_type'',''varchar'',50,0,0,NULL,0,5,0,0,-1),
		(-175,-115,-160,''source_table_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-174,-115,-159,''schedule_source_table_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-173,-115,-158,''schedule_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-172,-115,-157,''release_number'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-171,-115,-156,''queue'',''varchar'',50,0,0,NULL,0,7,0,0,-1),
		(-170,-115,-155,''priority'',''varchar'',50,0,0,NULL,0,6,0,0,-1),
		(-168,-115,-154,''is_cancelled'',''bit'',1,1,0,NULL,0,8,0,0,-1),
		(-167,-114,-153,''version_number'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-166,-114,-152,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,10,0,0,-1),
		(-165,-114,-151,''updated_by'',''varchar'',30,0,0,NULL,0,9,0,0,-1),
		(-164,-114,-150,''schedule_name'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-163,-114,-149,''schedule_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-162,-114,-148,''schedule_frequency'',''varchar'',128,0,0,NULL,0,5,0,0,-1),
		(-161,-114,-147,''schedule_description'',''varchar'',256,0,0,NULL,0,4,0,0,-1),
		(-160,-114,-146,''release_number'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-158,-114,-145,''is_cancelled'',''bit'',1,1,0,NULL,0,6,0,0,-1),
		(-157,-113,-144,''version_number'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-156,-113,-143,''updated_by'',''varchar'',30,0,0,NULL,0,8,0,0,-1),
		(-155,-113,-142,''update_date_time'',''datetimeoffset'',10,34,7,NULL,0,9,0,0,-1),
		(-154,-113,-141,''timevault_name'',''varchar'',50,0,0,NULL,0,4,0,0,-1),
		(-153,-113,-140,''source_system_name'',''varchar'',50,0,0,NULL,0,3,0,0,-1),
		(-152,-113,-139,''source_system_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-151,-113,-138,''release_number'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-149,-113,-137,''is_retired'',''bit'',1,1,0,NULL,0,5,0,0,-1),
		(-148,-112,-136,''version_number'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-147,-112,-135,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,8,0,0,-1),
		(-146,-112,-134,''updated_by'',''varchar'',30,0,0,NULL,0,7,0,0,-1),
		(-145,-112,-133,''satellite_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-144,-112,-132,''satellite_col_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-143,-112,-131,''release_number'',''int'',4,10,0,NULL,0,5,0,0,-1),
		(-140,-111,-129,''version_number'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-139,-111,-128,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,8,0,0,-1),
		(-138,-111,-127,''updated_by'',''varchar'',30,0,0,NULL,0,7,0,0,-1),
		(-137,-111,-126,''release_number'',''int'',4,10,0,NULL,0,5,0,0,-1),
		(-135,-111,-125,''link_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-134,-111,-124,''hub_link_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-133,-111,-123,''hub_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-132,-110,-122,''version_number'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-131,-110,-121,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,8,0,0,-1),
		(-130,-110,-120,''updated_by'',''varchar'',30,0,0,NULL,0,7,0,0,-1),
		(-129,-110,-119,''release_number'',''int'',4,10,0,NULL,0,5,0,0,-1),
		(-127,-110,-118,''hub_key_column_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-126,-110,-117,''hub_col_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-125,-110,-116,''column_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-124,-109,-115,''version_number'',''int'',4,10,0,NULL,0,12,0,0,-1),
		(-123,-109,-114,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,14,0,0,-1),
		(-122,-109,-113,''updated_by'',''varchar'',30,0,0,NULL,0,13,0,0,-1),
		(-121,-109,-112,''release_number'',''int'',4,10,0,NULL,0,11,0,0,-1),
		(-119,-109,-111,''hub_key_ordinal_position'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-118,-109,-110,''hub_key_column_type'',''varchar'',30,0,0,NULL,0,5,0,0,-1),
		(-117,-109,-109,''hub_key_column_scale'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-116,-109,-108,''hub_key_column_precision'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-115,-109,-107,''hub_key_column_name'',''varchar'',128,0,0,NULL,0,4,0,0,-1),
		(-114,-109,-106,''hub_key_column_length'',''int'',4,10,0,NULL,0,6,0,0,-1),
		(-113,-109,-105,''hub_key_column_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-112,-109,-104,''hub_key_Collation_Name'',''nvarchar'',256,0,0,NULL,0,9,0,0,-1),
		(-111,-109,-103,''hub_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-110,-108,-102,''start_datetime'',''datetimeoffset'',10,34,7,NULL,0,14,0,0,-1),
		(-109,-108,-101,''source_timevault'',''varchar'',50,0,0,NULL,0,5,0,0,-1),
		(-108,-108,-100,''source_table_schema'',''nvarchar'',256,0,0,NULL,0,6,0,0,-1),
		(-107,-108,-99,''source_table_name'',''nvarchar'',256,0,0,NULL,0,7,0,0,-1),
		(-106,-108,-98,''source_table_load_type'',''varchar'',50,0,0,NULL,0,8,0,0,-1),
		(-105,-108,-97,''source_table_key'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-104,-108,-96,''source_system_name'',''varchar'',50,0,0,NULL,0,4,0,0,-1),
		(-103,-108,-95,''source_procedure_schema'',''varchar'',128,0,0,NULL,0,10,0,0,-1),
		(-102,-108,-94,''source_procedure_name'',''varchar'',128,0,0,NULL,0,11,0,0,-1),
		(-101,-108,-93,''session_id'',''int'',4,10,0,NULL,0,18,0,0,-1)
			) AS src([column_key],[table_key],[satellite_col_key],[column_name],[column_type],[column_length],[column_precision],[column_scale],[Collation_Name],[bk_ordinal_position],[source_ordinal_position],[is_source_date],[is_retired],[release_key])
	ON
		trgt.[column_key] = src.[column_key]
	WHEN MATCHED THEN
		UPDATE SET
			[table_key] = src.[table_key]
		, [satellite_col_key] = src.[satellite_col_key]
		, [column_name] = src.[column_name]
		, [column_type] = src.[column_type]
		, [column_length] = src.[column_length]
		, [column_precision] = src.[column_precision]
		, [column_scale] = src.[column_scale]
		, [Collation_Name] = src.[Collation_Name]
		, [bk_ordinal_position] = src.[bk_ordinal_position]
		, [source_ordinal_position] = src.[source_ordinal_position]
		, [is_source_date] = src.[is_source_date]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([column_key],[table_key],[satellite_col_key],[column_name],[column_type],[column_length],[column_precision],[column_scale],[Collation_Name],[bk_ordinal_position],[source_ordinal_position],[is_source_date],[is_retired],[release_key])
		VALUES ([column_key],[table_key],[satellite_col_key],[column_name],[column_type],[column_length],[column_precision],[column_scale],[Collation_Name],[bk_ordinal_position],[source_ordinal_position],[is_source_date],[is_retired],[release_key])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_column] OFF;', 338)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 14, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_hub_column] ON; MERGE INTO [dbo].[dv_hub_column] AS trgt USING	(VALUES (-162,-112,-1355,-1,''Nov  2 2016 10:27:30.3699103PM +00:00''),
		(-161,-120,-1354,-1,''Nov  2 2016 10:27:30.3699103PM +00:00''),
		(-160,-120,-1346,-1,''Nov  2 2016 10:27:30.3699103PM +00:00''),
		(-159,-112,-1341,-1,''Nov  2 2016  3:28:58.6311143AM +00:00''),
		(-158,-112,-1339,-1,''Nov  2 2016  3:28:45.4596224AM +00:00''),
		(-157,-106,-1340,-1,''Nov  2 2016  3:28:13.2418456AM +00:00''),
		(-156,-103,-1342,-1,''Nov  2 2016  3:27:37.3991865AM +00:00''),
		(-155,-105,-1321,-1,''Sep  9 2016  2:15:57.2236345AM +00:00''),
		(-154,-119,-1295,-1,''Sep  7 2016  3:03:09.0982786AM +00:00''),
		(-153,-105,-318,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-152,-109,-313,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-151,-112,-308,-1,''Nov  3 2016 12:11:39.7945259AM +00:00''),
		(-150,-102,-305,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-149,-103,-302,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-148,-101,-297,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-147,-112,-286,-1,''Nov  2 2016 11:04:43.1074613PM +00:00''),
		(-145,-101,-279,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-144,-102,-272,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-143,-103,-267,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-142,-118,-263,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-141,-117,-262,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-140,-105,-261,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-139,-115,-260,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-138,-114,-259,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-137,-107,-256,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-136,-108,-257,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-135,-105,-254,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-134,-108,-253,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-133,-105,-251,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-132,-106,-249,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-129,-103,-245,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-128,-102,-243,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-127,-102,-241,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-126,-109,-240,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-125,-106,-238,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-124,-101,-239,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-123,-109,-236,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-122,-106,-234,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-121,-101,-235,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-120,-103,-233,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-119,-101,-231,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-118,-118,-215,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-117,-117,-197,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-116,-116,-184,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-115,-115,-174,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-114,-114,-163,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-113,-113,-152,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-112,-112,-144,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-111,-111,-134,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-110,-110,-126,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-109,-109,-113,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-108,-108,-449,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-107,-107,-438,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-106,-106,-419,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-105,-105,-409,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-104,-104,-399,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-103,-103,-383,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-102,-102,-365,-1,''Sep  7 2016  3:02:21.5525086AM +00:00''),
		(-101,-101,-353,-1,''Sep  7 2016  3:02:21.5525086AM +00:00'')
			) AS src([hub_col_key],[hub_key_column_key],[column_key],[release_key],[updated_datetime])
	ON
		trgt.[hub_col_key] = src.[hub_col_key]
	WHEN MATCHED THEN
		UPDATE SET
			[hub_key_column_key] = src.[hub_key_column_key]
		, [column_key] = src.[column_key]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([hub_col_key],[hub_key_column_key],[column_key],[release_key],[updated_datetime])
		VALUES ([hub_col_key],[hub_key_column_key],[column_key],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_hub_column] OFF;', 59)
GO

USE [$(DatabaseName)]
GO