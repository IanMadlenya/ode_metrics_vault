/*
 Pre-Deployment Script 							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the solution build script.	
 These statements will configure ODE with the Metrics Vault objects and create them
	before the Stage database is populated with the logic
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
CREATE DATABASE [ODE_Metrics_Vault]
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

--Insert data to the release build table

INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 1, 1, N'Header', N'SET IDENTITY_INSERT [dv_release].[dv_release_master] ON; MERGE INTO [dv_release].[dv_release_master] AS trgt USING	(VALUES (-1,1,''Metrics vault settings'',''N/A'',''N/A'',9,''Nov 24 2016  9:59:38.0813818PM +00:00'',''PC111'',''dbo'',''Nov 24 2016  9:59:38.0813818PM +00:00'')
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
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 2, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_source_system] ON; MERGE INTO [dbo].[dv_source_system] AS trgt USING	(VALUES (-101,''MetricsVault'',0,-1)
			) AS src([source_system_key],[source_system_name],[is_retired],[release_key])
	ON
		trgt.[source_system_key] = src.[source_system_key]
	WHEN MATCHED THEN
		UPDATE SET
			[source_system_name] = src.[source_system_name]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([source_system_key],[source_system_name],[is_retired],[release_key])
		VALUES ([source_system_key],[source_system_name],[is_retired],[release_key])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_source_system] OFF;', 1)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 3, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_stage_database] ON; MERGE INTO [dbo].[dv_stage_database] AS trgt USING	(VALUES (-1,''ODE_Metrics_Stage'',0,-1)
			) AS src([stage_database_key],[stage_database_name],[is_retired],[release_key])
	ON
		trgt.[stage_database_key] = src.[stage_database_key]
	WHEN MATCHED THEN
		UPDATE SET
			[stage_database_name] = src.[stage_database_name]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([stage_database_key],[stage_database_name],[is_retired],[release_key])
		VALUES ([stage_database_key],[stage_database_name],[is_retired],[release_key])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_stage_database] OFF;', 1)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 4, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_stage_schema] ON; MERGE INTO [dbo].[dv_stage_schema] AS trgt USING	(VALUES (-1,-1,''stage'',0,-1)
			) AS src([stage_schema_key],[stage_database_key],[stage_schema_name],[is_retired],[release_key])
	ON
		trgt.[stage_schema_key] = src.[stage_schema_key]
	WHEN MATCHED THEN
		UPDATE SET
			[stage_database_key] = src.[stage_database_key]
		, [stage_schema_name] = src.[stage_schema_name]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([stage_schema_key],[stage_database_key],[stage_schema_name],[is_retired],[release_key])
		VALUES ([stage_schema_key],[stage_database_key],[stage_schema_name],[is_retired],[release_key])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_stage_schema] OFF;', 1)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 5, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_source_table] ON; MERGE INTO [dbo].[dv_source_table] AS trgt USING	(VALUES (-2041,''Link_Hub_Link_Column'',''BespokeProc'',''Full'',-101,''stage'',''Link_Hub_Link_Column'',-1,''Link_Hub_Link_Column'',0,0,0,-1),
		(-1041,''Link_Link_Key'',''BespokeProc'',''Full'',-101,''stage'',''Link_Link_Key'',-1,''Link_Link_Key'',0,0,0,-1),
		(-1040,''DV_Link_Key_Column'',''BespokeProc'',''Full'',-101,''stage'',''DV_Link_Key_Column'',-1,''DV_Link_Key_Column'',0,0,0,-1),
		(-1038,''Link_Satellite_Column_Function'',''BespokeProc'',''Full'',-101,''Stage'',''Link_Satellite_Column_Function'',-1,''Link_Satellite_Column_Function'',0,0,0,-1),
		(-1037,''DV_Reference_Function'',''BespokeProc'',''Full'',-101,''Stage'',''DV_Reference_Function'',-1,''DV_Reference_Function'',0,0,0,-1),
		(-1036,''Link_Satellite_Column_Satellite'',''BespokeProc'',''Full'',-101,''stage'',''Link_Satellite_Column_Satellite'',-1,''Link_Satellite_Column_Satellite'',0,0,0,-1),
		(-1035,''Link_Column_Satellite_Column'',''BespokeProc'',''Full'',-101,''stage'',''Link_Column_Satellite_Column'',-1,''Link_Column_Satellite_Column'',0,0,0,-1),
		(-1034,''DV_Source_Table'',''BespokeProc'',''Full'',-101,''stage'',''DV_Source_Table'',-1,''DV_Source_Table'',0,0,0,-1),
		(-139,''log4_Severity'',''BespokeProc'',''Full'',-101,''stage'',''log4_Severity'',-1,''log4_Severity'',0,0,0,-1),
		(-138,''SourceTable_DataDictionary'',''BespokeProc'',''Full'',-101,''stage'',''SourceTable_DataDictionary'',-1,''SourceTable_DataDictionary'',0,0,0,-1),
		(-137,''HubKey_DataDictionary'',''BespokeProc'',''Full'',-101,''stage'',''HubKey_DataDictionary'',-1,''HubKey_DataDictionary'',0,0,0,-1),
		(-136,''Column_DataDictionary'',''BespokeProc'',''Full'',-101,''stage'',''Column_DataDictionary'',-1,''Column_DataDictionary'',0,0,0,-1),
		(-135,''Link_DataDictionary'',''BespokeProc'',''Full'',-101,''stage'',''Link_DataDictionary'',-1,''Link_DataDictionary'',0,0,0,-1),
		(-134,''Satellite_DataDictionary'',''BespokeProc'',''Full'',-101,''stage'',''Satellite_DataDictionary'',-1,''Satellite_DataDictionary'',0,0,0,-1),
		(-133,''Hub_DataDictionary'',''BespokeProc'',''Full'',-101,''stage'',''Hub_DataDictionary'',-1,''Hub_DataDictionary'',0,0,0,-1),
		(-132,''Column_Integrity'',''BespokeProc'',''Full'',-101,''stage'',''Column_Integrity'',-1,''Column_Integrity'',0,0,0,-1),
		(-131,''Hub_Integrity'',''BespokeProc'',''Full'',-101,''stage'',''Hub_Integrity'',-1,''Hub_Integrity'',0,0,0,-1),
		(-130,''Link_Integrity'',''BespokeProc'',''Full'',-101,''stage'',''Link_Integrity'',-1,''Link_Integrity'',0,0,0,-1),
		(-129,''Satellite_Integrity'',''BespokeProc'',''Full'',-101,''stage'',''Satellite_Integrity'',-1,''Satellite_Integrity'',0,0,0,-1),
		(-128,''Link_Journal_Exception'',''BespokeProc'',''Full'',-101,''stage'',''Link_Journal_Exception'',-1,''Link_Journal_Exception'',0,0,0,-1),
		(-127,''Link_Table_Schedule'',''BespokeProc'',''Full'',-101,''stage'',''Link_Table_Schedule'',-1,''Link_Table_Schedule'',0,0,0,-1),
		(-126,''Link_Run_Manifest'',''BespokeProc'',''Full'',-101,''stage'',''Link_Run_Manifest'',-1,''Link_Run_Manifest'',0,0,0,-1),
		(-125,''Link_Manifest_Source'',''BespokeProc'',''Full'',-101,''stage'',''Link_Manifest_Source'',-1,''Link_Manifest_Source'',0,0,0,-1),
		(-124,''Link_Column_Source'',''BespokeProc'',''Full'',-101,''stage'',''Link_Column_Source'',-1,''Link_Column_Source'',0,0,0,-1),
		(-122,''Link_Link_Satellite'',''BespokeProc'',''Full'',-101,''stage'',''Link_Link_Satellite'',-1,''Link_Link_Satellite'',0,0,0,-1),
		(-120,''Link_Hub_Column_Key'',''BespokeProc'',''Full'',-101,''stage'',''Link_Hub_Column_Key'',-1,''Link_Hub_Column_Key'',0,0,0,-1),
		(-119,''Link_Hub_Satellite'',''BespokeProc'',''Full'',-101,''stage'',''Link_Hub_Satellite'',-1,''Link_Hub_Satellite'',0,0,0,-1),
		(-118,''DV_Journal'',''BespokeProc'',''Full'',-101,''stage'',''DV_Journal'',-1,''DV_Journal'',0,0,0,-1),
		(-117,''DV_Exception'',''BespokeProc'',''Full'',-101,''stage'',''DV_Exception'',-1,''DV_Exception'',0,0,0,-1),
		(-116,''DV_Schedule_Hierarchy'',''BespokeProc'',''Full'',-101,''stage'',''DV_Schedule_Hierarchy'',-1,''DV_Schedule_Hierarchy'',0,0,0,-1),
		(-115,''DV_Schedule_Table'',''BespokeProc'',''Full'',-101,''stage'',''DV_Schedule_Table'',-1,''DV_Schedule_Table'',0,0,0,-1),
		(-114,''DV_Schedule'',''BespokeProc'',''Full'',-101,''stage'',''DV_Schedule'',-1,''DV_Schedule'',0,0,0,-1),
		(-113,''DV_Source_System'',''BespokeProc'',''Full'',-101,''stage'',''DV_Source_System'',-1,''DV_Source_System'',0,0,0,-1),
		(-112,''DV_Satellite_Column'',''BespokeProc'',''Full'',-101,''stage'',''DV_Satellite_Column'',-1,''DV_Satellite_Column'',0,0,0,-1),
		(-111,''DV_Hub_Link'',''BespokeProc'',''Full'',-101,''stage'',''DV_Hub_Link'',-1,''DV_Hub_Link'',0,0,0,-1),
		(-110,''DV_Hub_Column'',''BespokeProc'',''Full'',-101,''stage'',''DV_Hub_Column'',-1,''DV_Hub_Column'',0,0,0,-1),
		(-109,''DV_Hub_Key'',''BespokeProc'',''Full'',-101,''stage'',''DV_Hub_Key'',-1,''DV_Hub_Key'',0,0,0,-1),
		(-108,''DV_Run_Manifest'',''BespokeProc'',''Full'',-101,''stage'',''DV_Run_Manifest'',-1,''DV_Run_Manifest'',0,0,0,-1),
		(-107,''DV_Schedule_Run'',''BespokeProc'',''Full'',-101,''stage'',''DV_Schedule_Run'',-1,''DV_Schedule_Run'',0,0,0,-1),
		(-106,''DV_Column'',''BespokeProc'',''Full'',-101,''stage'',''DV_Column'',-1,''DV_Column'',0,0,0,-1),
		(-105,''DV_Source_Table_Raw'',''BespokeProc'',''Full'',-101,''stage'',''DV_Source_Table_Raw'',-1,''DV_Source_Table_Raw'',0,0,0,-1),
		(-104,''DV_Release'',''BespokeProc'',''Full'',-101,''stage'',''DV_Release'',-1,''DV_Release'',0,0,0,-1),
		(-103,''DV_Satellite'',''BespokeProc'',''Full'',-101,''stage'',''DV_Satellite'',-1,''DV_Satellite'',0,0,0,-1),
		(-102,''DV_Link'',''BespokeProc'',''Full'',-101,''stage'',''DV_Link'',-1,''DV_Link'',0,0,0,-1),
		(-101,''DV_Hub'',''BespokeProc'',''Full'',-101,''stage'',''DV_Hub'',-1,''DV_Hub'',0,0,0,-1)
			) AS src([source_table_key],[source_unique_name],[source_type],[load_type],[system_key],[source_table_schma],[source_table_nme],[stage_schema_key],[stage_table_name],[is_columnstore],[is_compressed],[is_retired],[release_key])
	ON
		trgt.[source_table_key] = src.[source_table_key]
	WHEN MATCHED THEN
		UPDATE SET
			[source_unique_name] = src.[source_unique_name]
		, [source_type] = src.[source_type]
		, [load_type] = src.[load_type]
		, [system_key] = src.[system_key]
		, [source_table_schma] = src.[source_table_schma]
		, [source_table_nme] = src.[source_table_nme]
		, [stage_schema_key] = src.[stage_schema_key]
		, [stage_table_name] = src.[stage_table_name]
		, [is_columnstore] = src.[is_columnstore]
		, [is_compressed] = src.[is_compressed]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([source_table_key],[source_unique_name],[source_type],[load_type],[system_key],[source_table_schma],[source_table_nme],[stage_schema_key],[stage_table_name],[is_columnstore],[is_compressed],[is_retired],[release_key])
		VALUES ([source_table_key],[source_unique_name],[source_type],[load_type],[system_key],[source_table_schma],[source_table_nme],[stage_schema_key],[stage_table_name],[is_columnstore],[is_compressed],[is_retired],[release_key])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_source_table] OFF;', 45)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 6, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_source_version] ON; MERGE INTO [dbo].[dv_source_version] AS trgt USING	(VALUES (-2041,-2041,1,''usp_Link_Hub_Link_Column'',0,1,-1),
		(-1041,-1041,1,''usp_Link_Link_Key'',0,1,-1),
		(-1040,-1040,1,''usp_DV_Link_Key_Column'',0,1,-1),
		(-1038,-1038,1,''usp_Link_Satellite_Column_Function'',0,1,-1),
		(-1037,-1037,1,''usp_DV_Reference_Function'',0,1,-1),
		(-1036,-1036,1,''usp_Link_Satellite_Column_Satellite'',0,1,-1),
		(-1035,-1035,1,''usp_Link_Column_Satellite_Column'',0,1,-1),
		(-1034,-1034,1,''usp_DV_Source_Table'',0,1,-1),
		(-139,-139,1,''usp_log4_Severity'',0,1,-1),
		(-138,-138,1,NULL,0,1,-1),
		(-137,-137,1,NULL,0,1,-1),
		(-136,-136,1,NULL,0,1,-1),
		(-135,-135,1,NULL,0,1,-1),
		(-134,-134,1,NULL,0,1,-1),
		(-133,-133,1,NULL,0,1,-1),
		(-132,-132,1,''usp_Column_Integrity'',0,1,-1),
		(-131,-131,1,''usp_Hub_Integrity'',0,1,-1),
		(-130,-130,1,''usp_Link_Integrity'',0,1,-1),
		(-129,-129,1,''usp_Satellite_Integrity'',0,1,-1),
		(-128,-128,1,''usp_Link_Journal_Exception'',0,1,-1),
		(-127,-127,1,''usp_Link_Table_Schedule'',0,1,-1),
		(-126,-126,1,''usp_Link_Run_Manifest'',0,1,-1),
		(-125,-125,1,''usp_Link_Manifest_Source'',0,1,-1),
		(-124,-124,1,''usp_Link_Column_Source'',0,1,-1),
		(-122,-122,1,''usp_Link_Link_Satellite'',0,1,-1),
		(-120,-120,1,''usp_Link_Hub_Column_Key'',0,1,-1),
		(-119,-119,1,''usp_Link_Hub_Satellite'',0,1,-1),
		(-118,-118,1,''usp_DV_Journal'',0,1,-1),
		(-117,-117,1,''usp_DV_Exception'',0,1,-1),
		(-116,-116,1,''usp_DV_Schedule_Hierarchy'',0,1,-1),
		(-115,-115,1,''usp_DV_Schedule_Table'',0,1,-1),
		(-114,-114,1,''usp_DV_Schedule'',0,1,-1),
		(-113,-113,1,''usp_DV_Source_System'',0,1,-1),
		(-112,-112,1,''usp_DV_Satellite_Column'',0,1,-1),
		(-111,-111,1,''usp_DV_Hub_Link'',0,1,-1),
		(-110,-110,1,''usp_DV_Hub_Column'',0,1,-1),
		(-109,-109,1,''usp_DV_Hub_Key'',0,1,-1),
		(-108,-108,1,''usp_DV_Run_Manifest'',0,1,-1),
		(-107,-107,1,''usp_DV_Schedule_Run'',0,1,-1),
		(-106,-106,1,''usp_DV_Column'',0,1,-1),
		(-105,-105,1,''usp_DV_Source_Table_Raw'',0,1,-1),
		(-104,-104,1,''usp_DV_Release'',0,1,-1),
		(-103,-103,1,''usp_DV_Satellite'',0,1,-1),
		(-102,-102,1,''usp_DV_Link'',0,1,-1),
		(-101,-101,1,''usp_DV_Hub'',0,1,-1)
			) AS src([source_version_key],[source_table_key],[source_version],[source_procedure_name],[pass_load_type_to_proc],[is_current],[release_key])
	ON
		trgt.[source_version_key] = src.[source_version_key]
	WHEN MATCHED THEN
		UPDATE SET
			[source_table_key] = src.[source_table_key]
		, [source_version] = src.[source_version]
		, [source_procedure_name] = src.[source_procedure_name]
		, [pass_load_type_to_proc] = src.[pass_load_type_to_proc]
		, [is_current] = src.[is_current]
		, [release_key] = src.[release_key]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([source_version_key],[source_table_key],[source_version],[source_procedure_name],[pass_load_type_to_proc],[is_current],[release_key])
		VALUES ([source_version_key],[source_table_key],[source_version],[source_procedure_name],[pass_load_type_to_proc],[is_current],[release_key])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_source_version] OFF;', 45)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 7, 1, N'Table', N'SET IDENTITY_INSERT [dv_scheduler].[dv_schedule] ON; MERGE INTO [dv_scheduler].[dv_schedule] AS trgt USING	(VALUES (-1,''Metrics_Vault'',''Intergity checks for the metrics vault'',''Daily'',0,-1,''Feb 28 2017  9:37:01.8822161AM +13:00'')
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
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 8, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_hub] ON; MERGE INTO [dbo].[dv_hub] AS trgt USING	(VALUES (-124,''DV_Link_Key_Column'',''h123'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-122,''Link_Source_Table'',''h122'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-121,''Hub_Source_Table'',''h121'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-120,''DV_Reference_Function'',''h120'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-119,''Severity'',''h119'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-118,''DV_Journal'',''h118'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-117,''DV_Exception'',''h117'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-116,''DV_Schedule_Hierarchy'',''h116'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-115,''DV_Schedule_Table'',''h115'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-114,''DV_Schedule'',''h114'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-113,''DV_Source_System'',''h113'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-112,''DV_Satellite_Column'',''h112'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-111,''DV_Hub_Link'',''h111'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-110,''DV_Hub_Column'',''h110'',''RawHub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-109,''DV_Hub_Key'',''h109'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-108,''DV_Run_Manifest'',''h108'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-107,''DV_Schedule_Run'',''h107'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-106,''DV_Column'',''h106'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-105,''DV_Source_Table'',''h105'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-104,''DV_Release'',''h104'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-103,''DV_Satellite'',''h103'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-102,''DV_Link'',''h102'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00''),
		(-101,''DV_Hub'',''h101'',''hub'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:09:45.0041565AM +13:00'')
			) AS src([hub_key],[hub_name],[hub_abbreviation],[hub_schema],[hub_database],[is_compressed],[is_retired],[release_key],[updated_datetime])
	ON
		trgt.[hub_key] = src.[hub_key]
	WHEN MATCHED THEN
		UPDATE SET
			[hub_name] = src.[hub_name]
		, [hub_abbreviation] = src.[hub_abbreviation]
		, [hub_schema] = src.[hub_schema]
		, [hub_database] = src.[hub_database]
		, [is_compressed] = src.[is_compressed]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([hub_key],[hub_name],[hub_abbreviation],[hub_schema],[hub_database],[is_compressed],[is_retired],[release_key],[updated_datetime])
		VALUES ([hub_key],[hub_name],[hub_abbreviation],[hub_schema],[hub_database],[is_compressed],[is_retired],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_hub] OFF;', 23)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 9, 1, N'Table', N'SET IDENTITY_INSERT [dv_scheduler].[dv_source_table_hierarchy] ON; MERGE INTO [dv_scheduler].[dv_source_table_hierarchy] AS trgt USING	(VALUES (-1027,-2041,-110,0,-1),
		(-1026,-1038,-112,0,-1),
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
	 select @result = @@rowcount; SET IDENTITY_INSERT [dv_scheduler].[dv_source_table_hierarchy] OFF;', 27)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 10, 1, N'Table', N'SET IDENTITY_INSERT [dv_scheduler].[dv_schedule_source_table] ON; MERGE INTO [dv_scheduler].[dv_schedule_source_table] AS trgt USING	(VALUES (-2041,-1,-2041,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-1041,-1,-1041,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-1040,-1,-1040,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-1039,-1,-1038,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-1038,-1,-1037,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-1037,-1,-1036,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-1036,-1,-1035,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-1035,-1,-1034,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-40,-1,-138,''Delta'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-39,-1,-137,''Delta'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-38,-1,-136,''Delta'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-37,-1,-135,''Delta'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-36,-1,-134,''Delta'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-35,-1,-133,''Delta'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-34,-1,-129,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-33,-1,-127,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-31,-1,-126,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-30,-1,-125,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-29,-1,-122,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-28,-1,-128,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-27,-1,-109,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-26,-1,-104,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-25,-1,-130,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-23,-1,-119,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-21,-1,-120,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-20,-1,-124,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-19,-1,-131,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-18,-1,-105,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-17,-1,-113,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-16,-1,-115,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-15,-1,-107,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-13,-1,-116,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-12,-1,-114,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-11,-1,-112,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-10,-1,-103,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-9,-1,-108,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-8,-1,-102,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-7,-1,-118,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-5,-1,-110,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-4,-1,-101,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-3,-1,-117,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-2,-1,-106,''Full'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00''),
		(-1,-1,-132,''Delta'',''Low'',''001'',0,-1,''Feb 28 2017  9:37:01.9466828AM +13:00'')
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
	 select @result = @@rowcount; SET IDENTITY_INSERT [dv_scheduler].[dv_schedule_source_table] OFF;', 43)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 11, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_hub_key_column] ON; MERGE INTO [dbo].[dv_hub_key_column] AS trgt USING	(VALUES (-126,-124,''link_key_column_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-124,-122,''source_table_key'',''int'',4,10,0,NULL,2,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-123,-122,''link_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-122,-121,''source_table_key'',''int'',4,10,0,NULL,2,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-121,-121,''hub_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-120,-120,''ref_function_key'',''varchar'',30,0,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-119,-119,''SeverityID'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-118,-118,''JournalID'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-117,-117,''ExceptionID'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-116,-116,''schedule_hierarchy_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-115,-115,''schedule_table_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-114,-114,''schedule_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-113,-113,''source_system_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-112,-112,''satellite_col_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-111,-111,''hub_link_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-110,-110,''hub_column_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-109,-109,''hub_key_column_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-108,-108,''run_manifest_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-107,-107,''run_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-106,-106,''column_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-105,-105,''source_table_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-104,-104,''release_number'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-103,-103,''satellite_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-102,-102,''link_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00''),
		(-101,-101,''hub_key'',''int'',4,10,0,NULL,1,-1,''Feb 28 2017  9:37:01.9662009AM +13:00'')
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
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_hub_key_column] OFF;', 25)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 12, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_link] ON; MERGE INTO [dbo].[dv_link] AS trgt USING	(VALUES (-115,''Hub_Link_Column'',''l115'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-114,''Link_Key'',''l114'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-113,''Satellite_Column_Function'',''l113'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-112,''Satellite_Column_Satellite'',''l112'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-111,''Column_Satellite_Column'',''l111'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-110,''Journal_Exception'',''l110'',''RawLnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-109,''Table_Schedule'',''l109'',''RawLnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-108,''Run_Manifest'',''l108'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-107,''Manifest_Source'',''l107'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-106,''Column_Source'',''l106'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-104,''Link_Satellite'',''l104'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-102,''Hub_Column_Key'',''l102'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00''),
		(-101,''Hub_Satellite'',''l101'',''lnk'',''ODE_Metrics_Vault'',0,0,-1,''Feb 28 2017 11:10:10.6891273AM +13:00'')
			) AS src([link_key],[link_name],[link_abbreviation],[link_schema],[link_database],[is_retired],[is_compressed],[release_key],[updated_datetime])
	ON
		trgt.[link_key] = src.[link_key]
	WHEN MATCHED THEN
		UPDATE SET
			[link_name] = src.[link_name]
		, [link_abbreviation] = src.[link_abbreviation]
		, [link_schema] = src.[link_schema]
		, [link_database] = src.[link_database]
		, [is_retired] = src.[is_retired]
		, [is_compressed] = src.[is_compressed]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([link_key],[link_name],[link_abbreviation],[link_schema],[link_database],[is_retired],[is_compressed],[release_key],[updated_datetime])
		VALUES ([link_key],[link_name],[link_abbreviation],[link_schema],[link_database],[is_retired],[is_compressed],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_link] OFF;', 13)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 13, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_link_key_column] ON; MERGE INTO [dbo].[dv_link_key_column] AS trgt USING	(VALUES (-1132,-115,''DV_Hub_Key'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-1131,-115,''DV_Column'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-1130,-115,''DV_Link_Key_Column'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-131,-114,''DV_Link_Key_Column'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-130,-114,''DV_Link'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-129,-112,''DV_Satellite'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-128,-111,''DV_Column'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-127,-110,''DV_Exception'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-126,-109,''DV_Schedule'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-125,-109,''DV_Schedule_Table'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-124,-108,''DV_Run_Manifest'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-123,-107,''DV_Run_Manifest'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-122,-106,''DV_Column'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-121,-104,''DV_Link'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-117,-102,''DV_Hub'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-115,-102,''DV_Column'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-114,-101,''DV_Hub'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-113,-113,''DV_Reference_Function'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-112,-101,''DV_Satellite'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-111,-102,''DV_Hub_Key'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-109,-104,''DV_Satellite'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-108,-106,''DV_Source_Table'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-107,-107,''DV_Source_Table'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-106,-108,''DV_Schedule_Run'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-105,-109,''DV_Source_Table'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-104,-110,''DV_Journal'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-103,-111,''DV_Satellite_Column'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-102,-112,''DV_Satellite_Column'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00''),
		(-101,-113,''DV_Satellite_Column'',-1,''Feb 28 2017  9:37:01.9947220AM +13:00'')
			) AS src([link_key_column_key],[link_key],[link_key_column_name],[release_key],[updated_datetime])
	ON
		trgt.[link_key_column_key] = src.[link_key_column_key]
	WHEN MATCHED THEN
		UPDATE SET
			[link_key] = src.[link_key]
		, [link_key_column_name] = src.[link_key_column_name]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([link_key_column_key],[link_key],[link_key_column_name],[release_key],[updated_datetime])
		VALUES ([link_key_column_key],[link_key],[link_key_column_name],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_link_key_column] OFF;', 29)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 14, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_satellite] ON; MERGE INTO [dbo].[dv_satellite] AS trgt USING	(VALUES (-1043,0,-115,''L'',''Link_Hub_Link_Column'',''143s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-1042,0,-114,''L'',''Link_Link_Key'',''141s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-1041,-124,0,''H'',''DV_Link_Key_Column'',''140s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-1039,0,-113,''L'',''Link_Satellite_Column_Function'',''039s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-1038,-120,0,''H'',''DV_Reference_Function'',''038s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-1037,0,-112,''L'',''Link_Satellite_Column_Satellite'',''037s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-1036,0,-111,''L'',''Link_Column_Satellite_Column'',''036s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-1035,-105,0,''H'',''DV_Source_Table'',''035s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-139,-105,0,''H'',''SourceTable_DataDictionary'',''139s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-138,-109,0,''H'',''HubKey_DataDictionary'',''138s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-137,-112,0,''H'',''Column_DataDictionary'',''137s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-136,-102,0,''H'',''Link_DataDictionary'',''136s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-135,-103,0,''H'',''Satellite_DataDictionary'',''135s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-134,-101,0,''H'',''Hub_DataDictionary'',''134s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-133,0,-101,''L'',''Link_Hub_Satellite'',''133s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-132,-112,0,''H'',''Satellite_Column_Integrity'',''132s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-131,-121,0,''H'',''Hub_Integrity'',''131s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-130,-122,0,''H'',''Link_Integrity'',''130s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-129,-103,0,''H'',''Satellite_Integrity'',''129s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-128,0,-110,''L'',''Link_Journal_Exception'',''128s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-127,0,-109,''L'',''Link_Table_Schedule'',''127s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-126,0,-108,''L'',''Link_Run_Manifest'',''126s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-125,0,-107,''L'',''Link_Manifest_Source'',''125s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-124,0,-106,''L'',''Link_Column_Source'',''124s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-122,0,-104,''L'',''Link_Link_Satellite'',''122s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-120,0,-102,''L'',''Link_Hub_Column_Key'',''120s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-119,-119,0,''H'',''log4_Severity'',''119s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-118,-118,0,''H'',''DV_Journal'',''118s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-117,-117,0,''H'',''DV_Exception'',''117s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-116,-116,0,''H'',''DV_Schedule_Hierarchy'',''116s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-115,-115,0,''H'',''DV_Schedule_Table'',''115s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-114,-114,0,''H'',''DV_Schedule'',''114s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-113,-113,0,''H'',''DV_Source_System'',''113s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-112,-112,0,''H'',''DV_Satellite_Column'',''112s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-111,-111,0,''H'',''DV_Hub_Link'',''s111'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-110,-110,0,''H'',''DV_Hub_Column'',''110s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-109,-109,0,''H'',''DV_Hub_Key'',''109s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-108,-108,0,''H'',''DV_Run_Manifest'',''108s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-107,-107,0,''H'',''DV_Schedule_Run'',''107s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-106,-106,0,''H'',''DV_Column'',''106s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-105,-105,0,''H'',''DV_Source_Table_Raw'',''105s'',''RawSat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-104,-104,0,''H'',''DV_Release'',''104s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-103,-103,0,''H'',''DV_Satellite'',''103s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-102,-102,0,''H'',''DV_Link'',''102s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00''),
		(-101,-101,0,''H'',''DV_Hub'',''101s'',''sat'',''ODE_Metrics_Vault'',0,0,0,0,-1,''Feb 28 2017  9:37:02.0477596AM +13:00'')
			) AS src([satellite_key],[hub_key],[link_key],[link_hub_satellite_flag],[satellite_name],[satellite_abbreviation],[satellite_schema],[satellite_database],[duplicate_removal_threshold],[is_columnstore],[is_compressed],[is_retired],[release_key],[updated_datetime])
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
		, [is_compressed] = src.[is_compressed]
		, [is_retired] = src.[is_retired]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([satellite_key],[hub_key],[link_key],[link_hub_satellite_flag],[satellite_name],[satellite_abbreviation],[satellite_schema],[satellite_database],[duplicate_removal_threshold],[is_columnstore],[is_compressed],[is_retired],[release_key],[updated_datetime])
		VALUES ([satellite_key],[hub_key],[link_key],[link_hub_satellite_flag],[satellite_name],[satellite_abbreviation],[satellite_schema],[satellite_database],[duplicate_removal_threshold],[is_columnstore],[is_compressed],[is_retired],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_satellite] OFF;', 45)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 15, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_satellite_column] ON; MERGE INTO [dbo].[dv_satellite_column] AS trgt USING	(VALUES (-2364,-105,''stage_table_name'',''varchar'',128,0,0,NULL,25,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2363,-105,''is_columnstore'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2362,-105,''stage_schema_key'',''int'',4,10,0,NULL,23,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2361,-105,''source_type'',''varchar'',50,0,0,NULL,19,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2360,-105,''source_unique_name'',''varchar'',128,0,0,NULL,21,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2359,-105,''is_compressed'',''bit'',1,1,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2358,-103,''is_compressed'',''bit'',1,1,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2357,-102,''is_compressed'',''bit'',1,1,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2356,-101,''is_compressed'',''bit'',1,1,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2355,-1043,''column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2354,-1043,''link_key_column_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2353,-1043,''hub_key_column_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1354,-1042,''link_key'',''varchar'',30,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1353,-1042,''link_key_column_key'',''varchar'',30,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1352,-1041,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1351,-1041,''updated_by'',''varchar'',30,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1350,-1041,''version_number'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1349,-1041,''release_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1348,-1041,''link_key_column_name'',''varchar'',128,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1347,-1041,''link_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1346,-1041,''link_key_column_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1336,-110,''link_key_column_key'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1335,-1039,''satellite_col_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1334,-1039,''ref_function_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1332,-1038,''version_number'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1331,-1038,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1330,-1038,''updated_by'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1329,-1038,''release_number'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1328,-1038,''release_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1327,-1038,''ref_function_name'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1326,-1038,''ref_function_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1325,-1038,''ref_function'',''nvarchar'',8000,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1323,-1038,''is_retired'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1322,-1037,''satellite_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1321,-1037,''satellite_col_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1320,-1036,''column_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1319,-1036,''satellite_col_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1318,-106,''satellite_col_key'',''int'',4,10,0,NULL,21,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1317,-112,''func_ordinal_position'',''int'',4,10,0,NULL,18,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1316,-112,''func_arguments'',''nvarchar'',512,0,0,NULL,17,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1315,-112,''ref_function_key'',''int'',4,10,0,NULL,16,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1314,-112,''satellite_ordinal_position'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1313,-112,''collation_name'',''varchar'',128,0,0,NULL,14,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1312,-112,''column_scale'',''int'',4,10,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1311,-112,''column_precision'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1310,-112,''column_length'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1309,-112,''column_type'',''varchar'',30,0,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1308,-112,''column_name'',''varchar'',128,0,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1306,-1035,''updated_by'',''varchar'',30,0,0,NULL,18,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1305,-1035,''update_date_time'',''datetimeoffset'',10,34,7,NULL,17,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1303,-1035,''source_table_schema'',''varchar'',128,0,0,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1302,-1035,''source_table_name'',''varchar'',128,0,0,NULL,14,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1301,-1035,''source_table_load_type'',''varchar'',50,0,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1300,-1035,''source_table_key'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1299,-1035,''source_system_release_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1298,-1035,''source_system_release_key'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1297,-1035,''source_system_name'',''varchar'',50,0,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1296,-1035,''source_system_key'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1295,-1035,''source_system_is_retired'',''bit'',1,1,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1292,-1035,''release_number'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1291,-1035,''release_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1290,-1035,''metrics_stage_run_time'',''datetimeoffset'',10,34,7,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1289,-1035,''is_retired'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1288,-105,''release_key'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1287,-113,''release_key'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1286,-115,''release_key'',''int'',4,10,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1285,-116,''release_key'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1284,-114,''release_key'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1283,-112,''release_key'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1282,-111,''release_key'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1281,-110,''release_key'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1280,-102,''release_key'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1279,-109,''release_key'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1278,-103,''release_key'',''int'',4,10,0,NULL,17,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1277,-101,''release_key'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1276,-106,''release_key'',''int'',4,10,0,NULL,20,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1275,-119,''SeverityName'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1274,-119,''SeverityId'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-291,-139,''source_table_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-290,-139,''ShortDescription'',''varchar'',255,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-289,-139,''LongDescription'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-288,-138,''hub_key_column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-287,-138,''Description'',''varchar'',255,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-286,-138,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-285,-137,''Description'',''varchar'',255,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-284,-137,''column_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-283,-137,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-282,-136,''link_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-281,-136,''Description'',''varchar'',255,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-280,-136,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-279,-135,''satellite_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-278,-135,''Description'',''varchar'',255,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-277,-135,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-276,-134,''hub_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-275,-134,''Description'',''varchar'',255,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-274,-134,''BusinessRule'',''varchar'',8000,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-273,-132,''MaxLength'',''bigint'',8,19,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-272,-132,''MinLength'',''bigint'',8,19,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-271,-132,''BlankCount'',''bigint'',8,19,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-270,-132,''NullCount'',''bigint'',8,19,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-269,-132,''DomainCount'',''bigint'',8,19,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-268,-132,''MaxValue'',''varchar'',8000,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-267,-132,''MinValue'',''varchar'',8000,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-266,-132,''ColumnName'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-265,-132,''ColumnKey'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-257,-131,''TotalRowCount'',''bigint'',8,19,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-256,-131,''SourceTableName'',''varchar'',128,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-255,-131,''SourceTableKey'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-254,-131,''SourceSystemName'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-253,-131,''RunDate'',''datetimeoffset'',10,34,7,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-252,-131,''HubName'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-251,-131,''HubKey'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-250,-130,''TotalRowCount'',''bigint'',8,19,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-249,-130,''SourceTableName'',''varchar'',128,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-248,-130,''SourceTableKey'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-247,-130,''SourceSystemName'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-246,-130,''RunDate'',''datetimeoffset'',10,34,7,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-245,-130,''LinkName'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-244,-130,''LinkKey'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-243,-129,''VersionedRowCount'',''bigint'',8,19,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-242,-129,''TotalRowCount'',''bigint'',8,19,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-241,-129,''TombstoneRowCount'',''bigint'',8,19,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-240,-129,''SatelliteName'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-239,-129,''SatelliteKey'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-238,-129,''RunDate'',''datetimeoffset'',10,34,7,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-237,-129,''CurrentRowCount'',''bigint'',8,19,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-236,-128,''JournalId'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-235,-128,''ExceptionId'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-234,-127,''source_table_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-233,-127,''schedule_table_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-232,-127,''schedule_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-231,-126,''run_manifest_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-230,-126,''run_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-229,-125,''source_table_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-228,-125,''run_manifest_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-227,-124,''source_table_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-226,-124,''column_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-223,-122,''satellite_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-222,-122,''link_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-217,-120,''hub_key_column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-216,-120,''hub_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-215,-120,''column_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-214,-133,''satellite_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-213,-133,''hub_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-212,-118,''UtcDate'',''datetime'',8,23,3,NULL,21,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-211,-118,''Task'',''varchar'',128,0,0,NULL,20,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-210,-118,''SystemDate'',''datetime'',8,23,3,NULL,19,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-209,-118,''StepInFunction'',''varchar'',128,0,0,NULL,18,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-208,-118,''SeverityId'',''int'',4,10,0,NULL,17,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-207,-118,''SessionLoginTime'',''datetime'',8,23,3,NULL,16,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-206,-118,''SessionId'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-205,-118,''ServerName'',''nvarchar'',256,0,0,NULL,14,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-204,-118,''ProgramName'',''nvarchar'',256,0,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-203,-118,''OriginalLoginName'',''nvarchar'',256,0,0,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-202,-118,''NTUsername'',''nvarchar'',256,0,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-201,-118,''NTDomain'',''nvarchar'',256,0,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-200,-118,''MessageText'',''varchar'',512,0,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-199,-118,''LoginName'',''nvarchar'',256,0,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-198,-118,''JournalId'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-197,-118,''HostName'',''nvarchar'',256,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-196,-118,''FunctionName'',''varchar'',256,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-195,-118,''ExtraInfo'',''varchar'',-1,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-194,-118,''ExceptionId'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-193,-118,''DatabaseName'',''nvarchar'',256,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-192,-117,''UtcDate'',''datetime'',8,23,3,NULL,21,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-191,-117,''SystemDate'',''datetime'',8,23,3,NULL,20,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-190,-117,''SessionLoginTime'',''datetime'',8,23,3,NULL,19,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-189,-117,''SessionId'',''int'',4,10,0,NULL,18,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-188,-117,''ServerName'',''nvarchar'',256,0,0,NULL,17,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-187,-117,''ProgramName'',''nvarchar'',256,0,0,NULL,16,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-186,-117,''OriginalLoginName'',''nvarchar'',256,0,0,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-185,-117,''NTUsername'',''nvarchar'',256,0,0,NULL,14,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-184,-117,''NTDomain'',''nvarchar'',256,0,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-183,-117,''LoginName'',''nvarchar'',256,0,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-182,-117,''HostName'',''nvarchar'',256,0,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-181,-117,''ExceptionId'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-180,-117,''ErrorState'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-179,-117,''ErrorSeverity'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-178,-117,''ErrorProcedure'',''nvarchar'',256,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-177,-117,''ErrorNumber'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-176,-117,''ErrorMessage'',''nvarchar'',-1,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-175,-117,''ErrorLine'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-174,-117,''ErrorContext'',''nvarchar'',1024,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-173,-117,''DatabaseName'',''nvarchar'',256,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-172,-116,''version_number'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-171,-116,''updated_by'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-170,-116,''update_date_time'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-169,-116,''source_table_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-168,-116,''source_table_hierarchy_key'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-167,-116,''release_number'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-166,-116,''prior_table_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-165,-116,''is_cancelled'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-164,-115,''version_number'',''int'',4,10,0,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-163,-115,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-162,-115,''updated_by'',''varchar'',30,0,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-161,-115,''source_table_load_type'',''varchar'',50,0,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-160,-115,''source_table_key'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-159,-115,''schedule_source_table_key'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-158,-115,''schedule_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-157,-115,''release_number'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-156,-115,''queue'',''varchar'',50,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-155,-115,''priority'',''varchar'',50,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-154,-115,''is_cancelled'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-153,-114,''version_number'',''int'',4,10,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-152,-114,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-151,-114,''updated_by'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-150,-114,''schedule_name'',''varchar'',128,0,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-149,-114,''schedule_key'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-148,-114,''schedule_frequency'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-147,-114,''schedule_description'',''varchar'',256,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-146,-114,''release_number'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-145,-114,''is_cancelled'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-144,-113,''version_number'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-143,-113,''updated_by'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-142,-113,''update_date_time'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-140,-113,''source_system_name'',''varchar'',50,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-139,-113,''source_system_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-138,-113,''release_number'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-137,-113,''is_retired'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-136,-112,''version_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-135,-112,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-134,-112,''updated_by'',''varchar'',30,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-133,-112,''satellite_key'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-132,-112,''satellite_col_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-131,-112,''release_number'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-129,-111,''version_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-128,-111,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-127,-111,''updated_by'',''varchar'',30,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-126,-111,''release_number'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-125,-111,''link_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-124,-111,''hub_link_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-123,-111,''hub_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-122,-110,''version_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-121,-110,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-120,-110,''updated_by'',''varchar'',30,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-119,-110,''release_number'',''int'',4,10,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-118,-110,''hub_key_column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-117,-110,''hub_col_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-116,-110,''column_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-115,-109,''version_number'',''int'',4,10,0,NULL,14,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-114,-109,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-113,-109,''updated_by'',''varchar'',30,0,0,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-112,-109,''release_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-111,-109,''hub_key_ordinal_position'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-110,-109,''hub_key_column_type'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-109,-109,''hub_key_column_scale'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-108,-109,''hub_key_column_precision'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-107,-109,''hub_key_column_name'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-106,-109,''hub_key_column_length'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-105,-109,''hub_key_column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-104,-109,''hub_key_Collation_Name'',''nvarchar'',256,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-103,-109,''hub_key'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-102,-108,''start_datetime'',''datetimeoffset'',10,34,7,NULL,23,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-98,-108,''source_table_load_type'',''varchar'',50,0,0,NULL,19,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-97,-108,''source_table_key'',''int'',4,10,0,NULL,17,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-95,-108,''source_unique_name'',''varchar'',128,0,0,NULL,21,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-93,-108,''session_id'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-92,-108,''run_status'',''varchar'',128,0,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-91,-108,''run_manifest_key'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-90,-108,''run_key'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-89,-108,''row_count'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-88,-108,''queue'',''varchar'',10,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-87,-108,''priority'',''varchar'',10,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-86,-108,''completed_datetime'',''datetimeoffset'',10,34,7,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-85,-107,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-84,-107,''run_status'',''varchar'',128,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-83,-107,''run_start_datetime'',''datetimeoffset'',10,34,7,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-82,-107,''run_schedule_name'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-81,-107,''run_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-80,-107,''run_end_datetime'',''datetimeoffset'',10,34,7,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-79,-106,''version_number'',''int'',4,10,0,NULL,19,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-78,-106,''updated_by'',''varchar'',30,0,0,NULL,18,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-77,-106,''update_date_time'',''datetimeoffset'',10,34,7,NULL,17,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-76,-106,''table_key'',''int'',4,10,0,NULL,16,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-75,-106,''source_ordinal_position'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-73,-106,''release_number'',''int'',4,10,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-72,-106,''is_source_date'',''bit'',1,1,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-71,-106,''is_retired'',''bit'',1,1,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-69,-106,''column_type'',''varchar'',30,0,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-68,-106,''column_scale'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-67,-106,''column_precision'',''int'',4,10,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-66,-106,''column_name'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-65,-106,''column_length'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-64,-106,''column_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-63,-106,''Collation_Name'',''nvarchar'',256,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-62,-106,''bk_ordinal_position'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-61,-105,''version_number'',''int'',4,10,0,NULL,33,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-60,-105,''updated_by'',''varchar'',30,0,0,NULL,31,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-59,-105,''update_date_time'',''datetimeoffset'',10,34,7,NULL,29,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-58,-105,''system_key'',''int'',4,10,0,NULL,27,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-57,-105,''source_table_schema'',''varchar'',128,0,0,NULL,17,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-56,-105,''source_table_name'',''varchar'',128,0,0,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-55,-105,''source_table_load_type'',''varchar'',50,0,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-54,-105,''source_table_key'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-51,-105,''release_number'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-50,-105,''is_retired'',''bit'',1,1,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-49,-104,''version_number'',''int'',4,10,0,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-48,-104,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,14,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-47,-104,''updated_by'',''varchar'',30,0,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-46,-104,''release_start_datetime'',''datetimeoffset'',10,34,7,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-45,-104,''release_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-44,-104,''release_description'',''varchar'',256,0,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-43,-104,''release_count'',''int'',4,10,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-42,-104,''release_complete_datetime'',''datetimeoffset'',10,34,7,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-41,-104,''release_built_by'',''varchar'',30,0,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-40,-104,''reference_source'',''varchar'',50,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-39,-104,''reference_number'',''varchar'',50,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-38,-104,''build_server'',''varchar'',256,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-37,-104,''build_number'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-36,-104,''build_date'',''datetimeoffset'',10,34,7,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-35,-103,''version_number'',''int'',4,10,0,NULL,16,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-34,-103,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,15,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-33,-103,''updated_by'',''varchar'',30,0,0,NULL,14,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-32,-103,''satellite_schema'',''varchar'',128,0,0,NULL,13,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-31,-103,''satellite_name'',''varchar'',128,0,0,NULL,12,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-30,-103,''satellite_key'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-29,-103,''satellite_database'',''varchar'',128,0,0,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-28,-103,''satellite_abbreviation'',''varchar'',4,0,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-27,-103,''release_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-26,-103,''link_key'',''int'',4,10,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-25,-103,''link_hub_satellite_flag'',''char'',1,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-24,-103,''is_retired'',''bit'',1,1,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-23,-103,''is_columnstore'',''bit'',1,1,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-22,-103,''hub_key'',''int'',4,10,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-21,-103,''duplicate_removal_threshold'',''int'',4,10,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-20,-102,''version_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-19,-102,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-18,-102,''updated_by'',''varchar'',30,0,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-17,-102,''release_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-16,-102,''link_schema'',''varchar'',128,0,0,NULL,6,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-15,-102,''link_name'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-14,-102,''link_key'',''int'',4,10,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-13,-102,''link_database'',''varchar'',128,0,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-12,-102,''link_abbreviation'',''varchar'',4,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-11,-102,''is_retired'',''bit'',1,1,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-10,-101,''version_number'',''int'',4,10,0,NULL,11,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-9,-101,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,10,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-8,-101,''updated_by'',''varchar'',30,0,0,NULL,9,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-7,-101,''release_number'',''int'',4,10,0,NULL,8,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-6,-101,''is_retired'',''bit'',1,1,0,NULL,7,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-5,-101,''hub_schema'',''varchar'',128,0,0,NULL,5,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-4,-101,''hub_name'',''varchar'',128,0,0,NULL,4,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-3,-101,''hub_key'',''int'',4,10,0,NULL,3,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-2,-101,''hub_database'',''varchar'',128,0,0,NULL,2,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00''),
		(-1,-101,''hub_abbreviation'',''varchar'',4,0,0,NULL,1,NULL,NULL,0,-1,''Feb 28 2017  9:37:02.4351581AM +13:00'')
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
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_satellite_column] OFF;', 345)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 16, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_column] ON; MERGE INTO [dbo].[dv_column] AS trgt USING	(VALUES (-2384,-105,-2364,''stage_table_name'',''varchar'',0,0,0,NULL,0,10,0,0,-1),
		(-2383,-105,-2363,''is_columnstore'',''bit'',1,1,0,NULL,0,12,0,0,-1),
		(-2382,-105,-2362,''stage_schema_key'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-2381,-105,-2361,''source_type'',''varchar'',0,0,0,NULL,0,4,0,0,-1),
		(-2380,-105,-2360,''source_unique_name'',''varchar'',0,0,0,NULL,0,3,0,0,-1),
		(-2379,-105,-2359,''is_compressed'',''bit'',1,1,0,NULL,0,13,0,0,-1),
		(-2378,-103,-2358,''is_compressed'',''bit'',1,1,0,NULL,0,11,0,0,-1),
		(-2377,-102,-2357,''is_compressed'',''bit'',1,1,0,NULL,0,7,0,0,-1),
		(-2376,-101,-2356,''is_compressed'',''bit'',1,1,0,NULL,0,9,0,0,-1),
		(-2375,-2041,-2353,''hub_key_column_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-2374,-2041,-2354,''link_key_column_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-2373,-2041,-2355,''column_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-1374,-1041,-1354,''link_key'',''varchar'',30,0,0,NULL,0,2,0,0,-1),
		(-1373,-1041,-1353,''link_key_column_key'',''varchar'',30,0,0,NULL,0,1,0,0,-1),
		(-1372,-1040,-1352,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,7,0,0,-1),
		(-1371,-1040,-1351,''updated_by'',''varchar'',30,0,0,NULL,0,6,0,0,-1),
		(-1370,-1040,-1350,''version_number'',''int'',4,10,0,NULL,0,5,0,0,-1),
		(-1369,-1040,-1349,''release_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-1368,-1040,-1348,''link_key_column_name'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-1367,-1040,-1347,''link_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-1366,-1040,-1346,''link_key_column_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-1356,-110,-1336,''link_key_column_key'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-1355,-1038,-1335,''satellite_col_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
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
		(-1324,-1034,-1303,''source_table_schema'',''varchar'',128,0,0,NULL,0,9,0,0,-1),
		(-1323,-1034,-1302,''source_table_name'',''varchar'',128,0,0,NULL,0,10,0,0,-1),
		(-1322,-1034,-1301,''source_table_load_type'',''varchar'',50,0,0,NULL,0,11,0,0,-1),
		(-1321,-1034,-1300,''source_table_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-1320,-1034,-1299,''source_system_release_number'',''int'',4,10,0,NULL,0,8,0,0,-1),
		(-1319,-1034,-1298,''source_system_release_key'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-1318,-1034,-1297,''source_system_name'',''varchar'',50,0,0,NULL,0,5,0,0,-1),
		(-1317,-1034,-1296,''source_system_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-1316,-1034,-1295,''source_system_is_retired'',''bit'',1,1,0,NULL,0,4,0,0,-1),
		(-1313,-1034,-1292,''release_number'',''int'',4,10,0,NULL,0,16,0,0,-1),
		(-1312,-1034,-1291,''release_key'',''int'',4,10,0,NULL,0,15,0,0,-1),
		(-1311,-1034,-1290,''metrics_stage_run_time'',''datetimeoffset'',10,34,7,NULL,0,1,0,0,-1),
		(-1310,-1034,-1289,''is_retired'',''bit'',1,1,0,NULL,0,14,0,0,-1),
		(-1309,-105,-1288,''release_key'',''int'',4,10,0,NULL,0,21,0,0,-1),
		(-1308,-113,-1287,''release_key'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-1307,-115,-1286,''release_key'',''int'',4,10,0,NULL,0,13,0,0,-1),
		(-1306,-116,-1285,''release_key'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-1305,-114,-1284,''release_key'',''int'',4,10,0,NULL,0,11,0,0,-1),
		(-1304,-112,-1283,''release_key'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-1303,-111,-1282,''release_key'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-1302,-110,-1281,''release_key'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-1301,-102,-1280,''release_key'',''int'',4,10,0,NULL,0,13,0,0,-1),
		(-1300,-109,-1279,''release_key'',''int'',4,10,0,NULL,0,15,0,0,-1),
		(-1299,-103,-1278,''release_key'',''int'',4,10,0,NULL,0,18,0,0,-1),
		(-1298,-101,-1277,''release_key'',''int'',4,10,0,NULL,0,15,0,0,-1),
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
		(-416,-105,-61,''version_number'',''int'',4,10,0,NULL,0,16,0,0,-1),
		(-415,-105,-60,''updated_by'',''varchar'',30,0,0,NULL,0,18,0,0,-1),
		(-414,-105,-59,''update_date_time'',''datetimeoffset'',10,34,7,NULL,0,20,0,0,-1),
		(-413,-105,-58,''system_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-412,-105,-57,''source_table_schma'',''varchar'',128,0,0,NULL,0,6,0,0,-1),
		(-411,-105,-56,''source_table_nme'',''varchar'',128,0,0,NULL,0,7,0,0,-1),
		(-410,-105,-55,''load_type'',''varchar'',50,0,0,NULL,0,5,0,0,-1),
		(-409,-105,-54,''source_table_key'',''int'',4,10,0,NULL,0,1,0,0,-1),
		(-406,-105,-51,''release_number'',''int'',4,10,0,NULL,0,15,0,0,-1),
		(-404,-105,-50,''is_retired'',''bit'',1,1,0,NULL,0,14,0,0,-1),
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
		(-388,-103,-35,''version_number'',''int'',4,10,0,NULL,0,15,0,0,-1),
		(-387,-103,-34,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,17,0,0,-1),
		(-386,-103,-33,''updated_by'',''varchar'',30,0,0,NULL,0,16,0,0,-1),
		(-385,-103,-32,''satellite_schema'',''varchar'',128,0,0,NULL,0,8,0,0,-1),
		(-384,-103,-31,''satellite_name'',''varchar'',128,0,0,NULL,0,6,0,0,-1),
		(-383,-103,-30,''satellite_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-382,-103,-29,''satellite_database'',''varchar'',128,0,0,NULL,0,9,0,0,-1),
		(-381,-103,-28,''satellite_abbreviation'',''varchar'',4,0,0,NULL,0,7,0,0,-1),
		(-380,-103,-27,''release_number'',''int'',4,10,0,NULL,0,14,0,0,-1),
		(-378,-103,-26,''link_key'',''int'',4,10,0,NULL,0,4,0,0,-1),
		(-377,-103,-25,''link_hub_satellite_flag'',''char'',1,0,0,NULL,0,5,0,0,-1),
		(-376,-103,-24,''is_retired'',''bit'',1,1,0,NULL,0,13,0,0,-1),
		(-375,-103,-23,''is_columnstore'',''bit'',1,1,0,NULL,0,12,0,0,-1),
		(-374,-103,-22,''hub_key'',''int'',4,10,0,NULL,0,3,0,0,-1),
		(-373,-103,-21,''duplicate_removal_threshold'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-372,-102,-20,''version_number'',''int'',4,10,0,NULL,0,10,0,0,-1),
		(-371,-102,-19,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,12,0,0,-1),
		(-370,-102,-18,''updated_by'',''varchar'',30,0,0,NULL,0,11,0,0,-1),
		(-369,-102,-17,''release_number'',''int'',4,10,0,NULL,0,9,0,0,-1),
		(-367,-102,-16,''link_schema'',''varchar'',128,0,0,NULL,0,5,0,0,-1),
		(-366,-102,-15,''link_name'',''varchar'',128,0,0,NULL,0,3,0,0,-1),
		(-365,-102,-14,''link_key'',''int'',4,10,0,NULL,0,2,0,0,-1),
		(-364,-102,-13,''link_database'',''varchar'',128,0,0,NULL,0,6,0,0,-1),
		(-363,-102,-12,''link_abbreviation'',''varchar'',4,0,0,NULL,0,4,0,0,-1),
		(-362,-102,-11,''is_retired'',''bit'',1,1,0,NULL,0,8,0,0,-1),
		(-361,-101,-10,''version_number'',''int'',4,10,0,NULL,0,12,0,0,-1),
		(-360,-101,-9,''updated_datetime'',''datetimeoffset'',10,34,7,NULL,0,14,0,0,-1),
		(-359,-101,-8,''updated_by'',''varchar'',30,0,0,NULL,0,13,0,0,-1),
		(-358,-101,-7,''release_number'',''int'',4,10,0,NULL,0,11,0,0,-1),
		(-356,-101,-6,''is_retired'',''bit'',1,1,0,NULL,0,10,0,0,-1),
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
		(-106,-108,-98,''source_table_load_type'',''varchar'',50,0,0,NULL,0,6,0,0,-1),
		(-105,-108,-97,''source_table_key'',''int'',4,10,0,NULL,0,7,0,0,-1),
		(-103,-108,-95,''source_unique_name'',''varchar'',128,0,0,NULL,0,5,0,0,-1),
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
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_column] OFF;', 345)
GO
INSERT [dv_release].[dv_release_build] ([release_build_key], [release_statement_sequence], [release_number], [release_statement_type], [release_statement], [affected_row_count]) VALUES (-1, 17, 1, N'Table', N'SET IDENTITY_INSERT [dbo].[dv_hub_column] ON; MERGE INTO [dbo].[dv_hub_column] AS trgt USING	(VALUES (-1170,-109,-1132,-2375,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-1169,-126,-1130,-2374,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-1168,-106,-1131,-2373,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-169,-102,-130,-1374,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-168,-126,-131,-1373,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-167,-126,NULL,-1366,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-166,-124,NULL,-276,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-165,-123,NULL,-272,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-164,-122,NULL,-283,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-163,-121,NULL,-279,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-162,-112,-101,-1355,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-161,-120,-113,-1354,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-160,-120,NULL,-1346,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-159,-112,-102,-1341,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-158,-112,-103,-1339,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-157,-106,-128,-1340,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-156,-103,-129,-1342,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-155,-105,NULL,-1321,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-154,-119,NULL,-1295,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-153,-105,NULL,-318,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-152,-109,NULL,-313,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-151,-112,NULL,-308,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-150,-102,NULL,-305,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-149,-103,NULL,-302,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-148,-101,NULL,-297,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-147,-112,NULL,-286,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-143,-103,NULL,-267,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-142,-118,-104,-263,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-141,-117,-127,-262,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-140,-105,-105,-261,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-139,-115,-125,-260,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-138,-114,-126,-259,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-137,-107,-106,-256,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-136,-108,-124,-257,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-135,-105,-107,-254,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-134,-108,-123,-253,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-133,-105,-108,-251,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-132,-106,-122,-249,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-129,-103,-109,-245,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-128,-102,-121,-243,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-123,-109,-111,-236,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-122,-106,-115,-234,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-121,-101,-117,-235,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-120,-103,-112,-233,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-119,-101,-114,-231,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-118,-118,NULL,-215,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-117,-117,NULL,-197,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-116,-116,NULL,-184,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-115,-115,NULL,-174,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-114,-114,NULL,-163,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-113,-113,NULL,-152,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-112,-112,NULL,-144,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-111,-111,NULL,-134,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-110,-110,NULL,-126,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-109,-109,NULL,-113,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-108,-108,NULL,-449,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-107,-107,NULL,-438,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-106,-106,NULL,-419,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-105,-105,NULL,-409,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-104,-104,NULL,-399,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-103,-103,NULL,-383,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-102,-102,NULL,-365,-1,''Feb 28 2017  9:37:02.7885162AM +13:00''),
		(-101,-101,NULL,-353,-1,''Feb 28 2017  9:37:02.7885162AM +13:00'')
			) AS src([hub_col_key],[hub_key_column_key],[link_key_column_key],[column_key],[release_key],[updated_datetime])
	ON
		trgt.[hub_col_key] = src.[hub_col_key]
	WHEN MATCHED THEN
		UPDATE SET
			[hub_key_column_key] = src.[hub_key_column_key]
		, [link_key_column_key] = src.[link_key_column_key]
		, [column_key] = src.[column_key]
		, [release_key] = src.[release_key]
		, [updated_datetime] = src.[updated_datetime]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([hub_col_key],[hub_key_column_key],[link_key_column_key],[column_key],[release_key],[updated_datetime])
		VALUES ([hub_col_key],[hub_key_column_key],[link_key_column_key],[column_key],[release_key],[updated_datetime])
	
	;
	 select @result = @@rowcount; SET IDENTITY_INSERT [dbo].[dv_hub_column] OFF;', 63)
GO

---------------------------------------------------------------------------------------
--Apply release and populate config with Metrics Vault data

EXECUTE [dv_release].[dv_apply_release_config] 
@vault_release_number  = 1
GO

---------------------------------------------------------------------------------------
--Build all tables in Metrics Vault

------------------
--Build Hub Tables
------------------
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Link_Key_Column','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','Link_Source_Table','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','Hub_Source_Table','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Reference_Function','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','Severity','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Journal','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Exception','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Schedule_Hierarchy','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Schedule_Table','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Schedule','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Source_System','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Satellite_Column','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Hub_Column','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Hub_Key','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Run_Manifest','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Schedule_Run','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Column','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Source_Table','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Release','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Satellite','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Link','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Hub','N'
EXECUTE [dbo].[dv_create_hub_table] 'ODE_Metrics_Vault','DV_Hub_Link','N'
 
-------------------
--Build Link Tables
-------------------
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Satellite_Column_Function','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Satellite_Column_Satellite','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Column_Satellite_Column','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Journal_Exception','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Table_Schedule','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Run_Manifest','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Manifest_Source','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Column_Source','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Link_Satellite','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Hub_Column_Key','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Hub_Satellite','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Link_Key','N'
EXECUTE [dbo].[dv_create_link_table] 'ODE_Metrics_Vault','Hub_Link_Column','N'
 
------------------
--Build Sat Tables
------------------
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Hub_Link_Column','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Link_Key','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Link_Key_Column','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Satellite_Column_Function','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Reference_Function','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Satellite_Column_Satellite','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Column_Satellite_Column','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Source_Table','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','SourceTable_DataDictionary','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','HubKey_DataDictionary','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Column_DataDictionary','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_DataDictionary','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Satellite_DataDictionary','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Hub_DataDictionary','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Hub_Satellite','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Satellite_Column_Integrity','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Hub_Integrity','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Integrity','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Satellite_Integrity','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Journal_Exception','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Table_Schedule','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Run_Manifest','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Manifest_Source','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Column_Source','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Link_Satellite','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','Link_Hub_Column_Key','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','log4_Severity','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Journal','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Exception','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Schedule_Hierarchy','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Schedule_Table','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Schedule','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Source_System','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Satellite_Column','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Hub_Column','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Hub_Key','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Run_Manifest','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Schedule_Run','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Column','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Source_Table_Raw','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Release','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Satellite','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Link','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Hub','N'
EXECUTE [dbo].[dv_create_sat_table] 'ODE_Metrics_Vault','DV_Hub_Link','N'
---------------------------------------------------------------------------------------

USE [$(DatabaseName)]
GO