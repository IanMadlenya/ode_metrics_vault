CREATE TABLE [stage].[DV_Hub_Link] (
    [metrics_stage_run_time] DATETIMEOFFSET (7) NOT NULL,
    [hub_link_key]           INT                NOT NULL,
    [link_key]               INT                NOT NULL,
    [hub_key]                INT                NOT NULL,
    [release_key]            INT                NOT NULL,
    [release_number]         INT                NULL,
    [version_number]         INT                NOT NULL,
    [updated_by]             VARCHAR (30)       NULL,
    [updated_datetime]       DATETIMEOFFSET (7) NULL
);

