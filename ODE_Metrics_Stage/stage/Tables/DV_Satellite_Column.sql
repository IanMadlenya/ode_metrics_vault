CREATE TABLE [stage].[DV_Satellite_Column] (
    [metrics_stage_run_time] DATETIMEOFFSET (7) NOT NULL,
    [satellite_col_key]      INT                NOT NULL,
    [satellite_key]          INT                NOT NULL,
    [column_key]             INT                NOT NULL,
    [release_key]            INT                NOT NULL,
    [release_number]         INT                NULL,
    [version_number]         INT                NOT NULL,
    [updated_by]             VARCHAR (30)       NULL,
    [updated_datetime]       DATETIMEOFFSET (7) NULL
);

