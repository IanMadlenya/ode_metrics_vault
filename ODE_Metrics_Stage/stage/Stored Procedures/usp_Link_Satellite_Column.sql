CREATE PROCEDURE [stage].[usp_Link_Satellite_Column]
--	@LoadType varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	IF (EXISTS (SELECT * 
				FROM INFORMATION_SCHEMA.TABLES 
				WHERE TABLE_SCHEMA = 'stage' AND TABLE_NAME = 'Link_Satellite_Column'))
	DROP TABLE stage.Link_Satellite_Column;

	SELECT metrics_stage_run_time = SYSDATETIMEOFFSET()
		,satellite_key
		,column_key
	INTO [stage].[Link_Satellite_Column]
	FROM [$(ODE_Metrics_Vault)].[RawSat].[s_DV_Satellite_Column]
	WHERE [dv_row_is_current] = 1
	AND [dv_is_tombstone] = 0
END