SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbActions_Del_Demo]
    @Data varchar(10)
AS
UPDATE WJbActions
SET Disabled = 1
WHERE (ActionId = CAST(@Data AS int))
GO
