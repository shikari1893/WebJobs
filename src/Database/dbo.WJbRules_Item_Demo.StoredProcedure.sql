SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbRules_Item_Demo]
    @Data varchar(10)
AS
SELECT R.*, A.ActionName, A.ActionMore
FROM WJbRules AS R 
INNER JOIN WJbActions AS A ON R.ActionId = A.ActionId
WHERE R.RuleId = CAST(@Data AS int)
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
GO
