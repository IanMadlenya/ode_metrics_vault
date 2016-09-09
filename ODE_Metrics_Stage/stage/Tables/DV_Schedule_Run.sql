CREATE TABLE [stage].[DV_Schedule_Run] (
    [metrics_stage_run_time] DATETIMEOFFSET (7) NOT NULL,
    [run_key]                INT                IDENTITY (1, 1) NOT NULL,
    [run_status]             VARCHAR (128)      NOT NULL,
    [run_schedule_name]      VARCHAR (128)      NOT NULL,
    [run_start_datetime]     DATETIMEOFFSET (7) NULL,
    [run_end_datetime]       DATETIMEOFFSET (7) NULL,
    [updated_datetime]       DATETIMEOFFSET (7) NOT NULL
);

