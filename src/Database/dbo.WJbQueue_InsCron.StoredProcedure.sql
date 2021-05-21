SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbQueue_InsCron]
AS
INSERT INTO WJbQueue (RuleId, JobPriority)
SELECT R.RuleId, R.RulePriority
FROM WJbRules R
WHERE R.Disabled = 0 
AND NOT JSON_VALUE(R.RuleMore, '$.cron') IS NULL
AND NOT EXISTS (SELECT 1 FROM WJbQueue WHERE RuleId = R.RuleId)
AND dbo.CronValidate(JSON_VALUE(R.RuleMore, '$.cron'), GETDATE()) = 1
GO
