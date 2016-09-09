CREATE TABLE [stage].[Column_Integrity] (
    [RunDate]       DATETIMEOFFSET (7) NULL,
    [SatelliteKey]  INT                NULL,
    [SatelliteName] VARCHAR (128)      NULL,
    [ColumnName]    VARCHAR (128)      NULL,
    [ColumnKey]     INT                NULL,
    [MinValue]      VARCHAR (MAX)      NULL,
    [MaxValue]      VARCHAR (MAX)      NULL,
    [DomainCount]   BIGINT             NULL,
    [NullCount]     BIGINT             NULL,
    [BlankCount]    BIGINT             NULL,
    [MinLength]     BIGINT             NULL,
    [MaxLength]     BIGINT             NULL
);

