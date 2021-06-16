SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbQueue_Ins]
	@Data nvarchar(max) 
AS
DECLARE @RuleId int = CASE WHEN ISNUMERIC(JSON_VALUE(@Data, '$.Rule')) = 1 THEN JSON_VALUE(@Data, '$.Rule') 
    ELSE (SELECT TOP 1 RuleId FROM WJbRules WHERE (RuleName = JSON_VALUE(@Data, '$.Rule'))) END;

INSERT INTO WJbQueue (RuleId, JobPriority, JobMore, JobStatus)
SELECT @RuleId, JSON_VALUE(@Data, '$.RulePriority'), JSON_QUERY(@Data, '$.RuleMore'), 1 /* Queued */
--SELECT * FROM OPENJSON(@Data) 
--WITH (RuleId int, RulePriority tinyint, RuleMore nvarchar(max))

SELECT SCOPE_IDENTITY()
GO
