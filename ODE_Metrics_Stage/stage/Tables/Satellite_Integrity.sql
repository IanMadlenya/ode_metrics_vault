CREATE TABLE [stage].[Satellite_Integrity] (
    [RunDate]           DATETIMEOFFSET (7) NULL,
    [SatelliteKey]      INT                NULL,
    [SatelliteName]     VARCHAR (128)      NULL,
    [TotalRowCount]     BIGINT             NULL,
    [CurrentRowCount]   BIGINT             NULL,
    [VersionedRowCount] BIGINT             NULL,
    [TombstoneRowCount] BIGINT             NULL
);

