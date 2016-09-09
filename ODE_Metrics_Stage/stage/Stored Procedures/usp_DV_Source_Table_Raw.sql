
CREATE PROCEDURE [stage].[usp_DV_Source_Table_Raw]
--	@LoadType varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	IF (EXISTS (SELECT * 
				FROM INFORMATION_SCHEMA.TABLES 
				WHERE TABLE_SCHEMA = 'stage' AND TABLE_NAME = 'DV_Source_Table_Raw'))
	DROP TABLE stage.DV_Source_Table_Raw;

	SELECT metrics_stage_run_time = SYSDATETIMEOFFSET()
		,s.[source_table_key]
		,s.[system_key]
		,s.[source_table_schema]
		,s.[source_table_name]
		,s.[source_table_load_type]
		,s.[source_procedure_schema]
		,s.[source_procedure_name]
		,s.[is_retired]
		,s.[release_key]
		,m.[release_number]
		,s.[version_number]
		,s.[updated_by]
		,s.[update_date_time]
	INTO [stage].[DV_Source_Table_Raw]
	FROM [ODE_Config].[dbo].[dv_source_table] s
	LEFT JOIN [ODE_Config].[dv_release].[dv_release_master] m
	ON s.release_key = m.release_key
END