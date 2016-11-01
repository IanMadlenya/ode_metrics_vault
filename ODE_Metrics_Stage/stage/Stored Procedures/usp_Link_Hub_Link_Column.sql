
CREATE PROCEDURE [stage].[usp_Link_Hub_Link_Column]
--	@LoadType varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	IF (EXISTS (SELECT * 
				FROM INFORMATION_SCHEMA.TABLES 
				WHERE TABLE_SCHEMA = 'stage' AND TABLE_NAME = 'Link_Hub_Link_Column'))
	DROP TABLE stage.Link_Hub_Link_Column;

	;WITH sHubKey	AS (SELECT * FROM [$(ODE_Metrics_Vault)].[Sat].[s_DV_Hub_Key]			WHERE [dv_row_is_current] = 1	AND [dv_is_tombstone] = 0)
	,sHubColumn		AS (SELECT * FROM [$(ODE_Metrics_Vault)].[RawSat].[s_DV_Hub_Column]		WHERE [dv_row_is_current] = 1	AND [dv_is_tombstone] = 0)
	,sHubLink		AS (SELECT * FROM [$(ODE_Metrics_Vault)].[RawSat].[s_DV_Hub_Link]			WHERE [dv_row_is_current] = 1	AND [dv_is_tombstone] = 0)
	,sSatellite		AS (SELECT * FROM [$(ODE_Metrics_Vault)].[Sat].[s_DV_Satellite]			WHERE [dv_row_is_current] = 1	AND [dv_is_tombstone] = 0)
	,sSatColumn		AS (SELECT * FROM [$(ODE_Metrics_Vault)].[RawSat].[s_DV_Satellite_Column]	WHERE [dv_row_is_current] = 1	AND [dv_is_tombstone] = 0)

	SELECT metrics_stage_run_time = SYSDATETIMEOFFSET()
		,h.hub_key
		,h.hub_key_column_key
		,hc.column_key 
		,l.link_key
	INTO [stage].[Link_Hub_Link_Column]
	FROM sHubKey h
	JOIN sHubColumn hc
	ON hc.hub_key_column_key = h.hub_key_column_key
	JOIN sHubLink l
	ON h.hub_key = l.hub_key
	JOIN sSatellite s
	ON l.link_key = s.link_key
	AND s.link_hub_satellite_flag = 'L'
	JOIN sSatColumn sc
	ON s.satellite_key = sc.satellite_key
	AND hc.column_key = sc.column_key
END