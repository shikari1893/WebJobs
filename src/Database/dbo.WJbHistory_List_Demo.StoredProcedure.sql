SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbHistory_List_Demo]
    @Data varchar(100)
AS
DECLARE @Date datetime = CAST(JSON_VALUE(@Data, '$.Date') AS date)

SELECT H.*, R.RuleName
FROM (
    SELECT JobId, JobPriority, Created, RuleId, Started, Finished, LEFT(JobMore, 200) JobMore
    FROM WJbHistory
    WHERE Created >= @Date AND Created < DATEADD(DAY, 1, @Date)
    UNION ALL 
    SELECT JobId, JobPriority, Created, RuleId, Started, Finished, LEFT(JobMore, 200) JobMore
    FROM WJbQueue
    --WHERE Created >= @Date AND Created < DATEADD(DAY, 1, @Date)
    ) AS H 
INNER JOIN WJbRules AS R ON H.RuleId = R.RuleId
ORDER BY H.JobId ASC
FOR JSON PATH
GO
