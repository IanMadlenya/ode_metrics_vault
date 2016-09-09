CREATE TABLE [stage].[SourceTable_DataDictionary] (
    [source_table_key]       INT                NULL,
    [ShortDescription]       VARCHAR (255)      NULL,
    [LongDescription]        VARCHAR (8000)     NULL,
    [metrics_stage_run_time] DATETIMEOFFSET (7) DEFAULT (sysdatetimeoffset()) NULL
);

