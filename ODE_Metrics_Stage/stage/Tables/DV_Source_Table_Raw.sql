CREATE TABLE [stage].[DV_Source_Table_Raw] (
    [metrics_stage_run_time]  DATETIMEOFFSET (7) NOT NULL,
    [source_table_key]        INT                NOT NULL,
    [system_key]              INT                NOT NULL,
    [source_table_schema]     VARCHAR (128)      NOT NULL,
    [source_table_name]       VARCHAR (128)      NOT NULL,
    [source_table_load_type]  VARCHAR (50)       NOT NULL,
    [source_procedure_schema] VARCHAR (128)      NULL,
    [source_procedure_name]   VARCHAR (128)      NULL,
    [is_retired]              BIT                NOT NULL,
    [release_key]             INT                NOT NULL,
    [release_number]          INT                NULL,
    [version_number]          INT                NULL,
    [updated_by]              VARCHAR (30)       NULL,
    [update_date_time]        DATETIMEOFFSET (7) NULL
);

