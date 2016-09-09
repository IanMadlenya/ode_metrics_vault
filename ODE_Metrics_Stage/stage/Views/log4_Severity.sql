create view stage.log4_Severity
as
select [SeverityId]
, [SeverityName]
FROM [ODE_Config].log4.Severity