CREATE TABLE [stage].[Link_Table_Schedule] (
    [metrics_stage_run_time] DATETIMEOFFSET (7) NOT NULL,
    [schedule_key]           INT                NULL,
    [schedule_table_key]     INT                NULL,
    [source_table_key]       INT                NULL
);

