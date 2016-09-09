CREATE PROCEDURE [stage].[usp_Link_Table_Schedule]
--	@LoadType varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	IF (EXISTS (SELECT * 
				FROM INFORMATION_SCHEMA.TABLES 
				WHERE TABLE_SCHEMA = 'stage' AND TABLE_NAME = 'Link_Table_Schedule'))
	DROP TABLE stage.Link_Table_Schedule;

	SELECT metrics_stage_run_time = SYSDATETIMEOFFSET()
		,schedule_key
		,schedule_source_table_key as [schedule_table_key]
		,[source_table_key]
	INTO [stage].[Link_Table_Schedule]
	FROM [ODE_Metrics_Vault].[RawSat].[s_DV_Schedule_Table]
	WHERE [dv_row_is_current] = 1
	AND [dv_is_tombstone] = 0
END