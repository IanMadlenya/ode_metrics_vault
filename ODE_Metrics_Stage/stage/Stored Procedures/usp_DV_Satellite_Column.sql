CREATE PROCEDURE [stage].[usp_DV_Satellite_Column]
--	@LoadType varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	IF (EXISTS (SELECT * 
				FROM INFORMATION_SCHEMA.TABLES 
				WHERE TABLE_SCHEMA = 'stage' AND TABLE_NAME = 'DV_Satellite_Column'))
	DROP TABLE stage.DV_Satellite_Column;

	SELECT metrics_stage_run_time = SYSDATETIMEOFFSET()
		,s.[satellite_col_key]
		,s.[satellite_key]
		,s.[column_key]
		,s.[release_key]
		,m.[release_number]
		,s.[version_number]
		,s.[updated_by]
		,s.[updated_datetime]
	INTO [stage].[DV_Satellite_Column]
	FROM [$(ODE_Config)].[dbo].[dv_satellite_column] s
	LEFT JOIN [$(ODE_Config)].[dv_release].[dv_release_master] m
	ON s.release_key = m.release_key
END