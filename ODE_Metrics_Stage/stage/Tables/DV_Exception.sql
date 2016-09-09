CREATE TABLE [stage].[DV_Exception] (
    [metrics_stage_run_time] DATETIMEOFFSET (7) NOT NULL,
    [ExceptionId]            INT                IDENTITY (1, 1) NOT NULL,
    [UtcDate]                DATETIME           NULL,
    [SystemDate]             DATETIME           NULL,
    [ErrorContext]           NVARCHAR (512)     NULL,
    [ErrorNumber]            INT                NULL,
    [ErrorSeverity]          INT                NULL,
    [ErrorState]             INT                NULL,
    [ErrorProcedure]         NVARCHAR (128)     NULL,
    [ErrorLine]              INT                NULL,
    [ErrorMessage]           NVARCHAR (MAX)     NULL,
    [SessionId]              INT                NULL,
    [ServerName]             NVARCHAR (128)     NULL,
    [DatabaseName]           NVARCHAR (128)     NULL,
    [HostName]               NVARCHAR (128)     NULL,
    [ProgramName]            NVARCHAR (128)     NULL,
    [NTDomain]               NVARCHAR (128)     NULL,
    [NTUsername]             NVARCHAR (128)     NULL,
    [LoginName]              NVARCHAR (128)     NULL,
    [OriginalLoginName]      NVARCHAR (128)     NULL,
    [SessionLoginTime]       DATETIME           NULL
);

