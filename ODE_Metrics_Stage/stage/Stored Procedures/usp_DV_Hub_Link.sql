CREATE PROCEDURE [stage].[usp_DV_Hub_Link]
--	@LoadType varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	IF (EXISTS (SELECT * 
				FROM INFORMATION_SCHEMA.TABLES 
				WHERE TABLE_SCHEMA = 'stage' AND TABLE_NAME = 'DV_Hub_Link'))
	DROP TABLE stage.DV_Hub_Link;

	SELECT metrics_stage_run_time = SYSDATETIMEOFFSET()
		,l.[hub_link_key]
		,l.[link_key]
		,l.[hub_key]
		,l.[release_key]
		,m.[release_number]
		,l.[version_number]
		,l.[updated_by]
		,l.[updated_datetime]
	INTO [stage].[DV_Hub_Link]
	FROM [$(ODE_Config)].[dbo].[dv_hub_link] l
	LEFT JOIN [$(ODE_Config)].[dv_release].[dv_release_master] m
	ON l.release_key = m.release_key
END