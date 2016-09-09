
CREATE PROCEDURE [stage].[usp_Link_Journal_Exception]
--	@LoadType varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	IF (EXISTS (SELECT * 
				FROM INFORMATION_SCHEMA.TABLES 
				WHERE TABLE_SCHEMA = 'stage' AND TABLE_NAME = 'Link_Journal_Exception'))
	DROP TABLE stage.Link_Journal_Exception;

	SELECT metrics_stage_run_time = SYSDATETIMEOFFSET()
		,ExceptionId
		,JournalId
	INTO [stage].[Link_Journal_Exception]
	FROM [ODE_Metrics_Vault].[RawSat].[s_DV_Journal]
	WHERE [dv_row_is_current] = 1
	AND [dv_is_tombstone] = 0
	AND ExceptionId IS NOT NULL
END