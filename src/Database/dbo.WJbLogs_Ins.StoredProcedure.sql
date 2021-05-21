SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[WJbLogs_Ins]
    @Data nvarchar(max)
AS
INSERT INTO WJbLogs (LogLevel, Title, LogMore)
VALUES (JSON_VALUE(@Data, '$.logLevel'), JSON_VALUE(@Data, '$.title'), 
    ISNULL(JSON_QUERY(@Data, '$.logMore'), JSON_VALUE(@Data, '$.logMore')))
GO
