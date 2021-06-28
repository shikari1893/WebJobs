SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJb_Jobs_Ins_Demo]
AS
INSERT INTO WJbQueue (RuleId, JobPriority, JobMore)
SELECT RuleId, RulePriority, N'{ "data": "3" }'
FROM WJbRules
WHERE (RuleId = 2) AND (Disabled = 0)

INSERT INTO WJbQueue ( RuleId, JobPriority, JobMore)
SELECT RuleId, RulePriority, N'{ "data": "5" }'
FROM WJbRules
WHERE (RuleId = 2) AND (Disabled = 0)

INSERT INTO WJbQueue ( RuleId, JobPriority)
SELECT RuleId, RulePriority
FROM WJbRules
WHERE (RuleId = 1000) AND (Disabled = 0)
GO
