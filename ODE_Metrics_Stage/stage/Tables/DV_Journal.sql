CREATE TABLE [stage].[DV_Journal] (
    [metrics_stage_run_time] DATETIMEOFFSET (7) NOT NULL,
    [JournalId]              INT                NOT NULL,
    [UtcDate]                DATETIME           NULL,
    [SystemDate]             DATETIME           NULL,
    [Task]                   VARCHAR (128)      NULL,
    [FunctionName]           VARCHAR (256)      NULL,
    [StepInFunction]         VARCHAR (128)      NULL,
    [MessageText]            VARCHAR (512)      NULL,
    [SeverityId]             INT                NULL,
    [ExceptionId]            INT                NULL,
    [SessionId]              INT                NULL,
    [ServerName]             NVARCHAR (128)     NULL,
    [DatabaseName]           NVARCHAR (128)     NULL,
    [HostName]               NVARCHAR (128)     NULL,
    [ProgramName]            NVARCHAR (128)     NULL,
    [NTDomain]               NVARCHAR (128)     NULL,
    [NTUsername]             NVARCHAR (128)     NULL,
    [LoginName]              NVARCHAR (128)     NULL,
    [OriginalLoginName]      NVARCHAR (128)     NULL,
    [SessionLoginTime]       DATETIME           NULL,
    [ExtraInfo]              VARCHAR (MAX)      NULL
);

