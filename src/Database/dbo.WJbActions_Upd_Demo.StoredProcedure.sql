SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbActions_Upd_Demo]
	@Data nvarchar(max) 
AS
UPDATE A
SET ActionName = D.ActionName
    ,Disabled = 0
    ,ActionType = D.ActionType
    ,ActionMore = D.ActionMore
FROM WJbActions A
CROSS JOIN (SELECT * FROM OPENJSON(@Data) 
    WITH (ActionName nvarchar(100), ActionType nvarchar(255), ActionMore nvarchar(max))) D
WHERE A.ActionId = JSON_VALUE(@Data, '$.ActionId')
GO
