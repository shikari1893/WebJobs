SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbSettings_Set]
	@Data nvarchar(1000)
AS
UPDATE dbo.WJbSettings
SET Value = JSON_VALUE(@Data, '$.Value')
WHERE (Name = JSON_VALUE(@Data, '$.Name'))

IF @@ROWCOUNT = 0 BEGIN
    INSERT INTO dbo.WJbSettings (Name, Value)
    VALUES (JSON_VALUE(@Data, '$.Name'), JSON_VALUE(@Data, '$.Value'))
END
GO
