SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbSettings_Get]
	@Data nvarchar(1000)
AS
SELECT TOP 1 [Value]
FROM WJbSettings S
WHERE S.Name = JSON_VALUE(@Data, '$.Name')
GO
