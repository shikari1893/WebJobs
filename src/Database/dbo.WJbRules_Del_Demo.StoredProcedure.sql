SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbRules_Del_Demo]
    @Data varchar(10)
AS
DELETE WJbRules
WHERE (RuleId = CAST(@Data AS int))
GO
