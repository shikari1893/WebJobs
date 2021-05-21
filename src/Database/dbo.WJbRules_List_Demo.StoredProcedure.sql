SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbRules_List_Demo]
AS
SELECT R.*, A.ActionName
FROM WJbRules R
INNER JOIN WJbActions A ON R.ActionId = A.ActionId
WHERE R.Disabled = 0 AND A.Disabled = 0
FOR JSON PATH
GO
