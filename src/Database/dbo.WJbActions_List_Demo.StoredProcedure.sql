SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbActions_List_Demo]
AS
SELECT ActionId, ActionName, ActionType, ActionMore
FROM WJbActions
WHERE (Disabled = 0)
FOR JSON PATH
GO
