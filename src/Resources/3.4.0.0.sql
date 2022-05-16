
BEGIN /***** Init Tables *****/

BEGIN /*** Init WJbActions ***/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WJbActions]') AND type in (N'U'))
BEGIN
	CREATE TABLE [WJbActions](
		[ActionId] [int] IDENTITY(1000,1) NOT NULL,
		[ActionName] [nvarchar](100) NOT NULL,
		[ActionType] [nvarchar](255) NOT NULL,
		[ActionMore] [nvarchar](max) NULL,
		[Disabled] [bit] NOT NULL,
	 CONSTRAINT [PK_WJbActions] PRIMARY KEY CLUSTERED 
	(
		[ActionId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	 CONSTRAINT [UX_WJbActions_ActionName] UNIQUE NONCLUSTERED 
	(
		[ActionName] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbActions_Disabled]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbActions] ADD  CONSTRAINT [DF_WJbActions_Disabled]  DEFAULT ((0)) FOR [Disabled]
END

SET IDENTITY_INSERT [WJbActions] ON 

IF NOT EXISTS (SELECT 1 FROM [WJbActions] WHERE (ActionId = 1))
	INSERT [WJbActions] ([ActionId], [ActionName], [ActionType], [ActionMore], [Disabled]) 
	VALUES (1, N'RunSqlProc', N'RunSqlProcAction, UkrGuru.WebJobs', N'{
	"proc": "",
	"data": null,
	"timeout": null,
	"result_name": null
}', 0)

IF NOT EXISTS (SELECT 1 FROM [WJbActions] WHERE (ActionId = 2))
	INSERT [WJbActions] ([ActionId], [ActionName], [ActionType], [ActionMore], [Disabled]) 
	VALUES (2, N'SendEmail', N'SendEmailAction, UkrGuru.WebJobs', N'{
	"smtp_settings_name": "",
	"from": "",
	"to": "",
	"cc": null,
	"bcc": null,
	"subject": "",
	"body": "",
	"attachment": null,
	"attachments": null
}', 0)

IF NOT EXISTS (SELECT 1 FROM [WJbActions] WHERE (ActionId = 3))
	INSERT [WJbActions] ([ActionId], [ActionName], [ActionType], [ActionMore], [Disabled]) 
	VALUES (3, N'FillTemplate', N'FillTemplateAction, UkrGuru.WebJobs', N'{
	"tname_pattern": "[A-Z]{1,}[_]{1,}[A-Z]{1,}[_]{0,}[A-Z]{0,}"
}', 0)

IF NOT EXISTS (SELECT 1 FROM [WJbActions] WHERE (ActionId = 5))
	INSERT [WJbActions] ([ActionId], [ActionName], [ActionType], [ActionMore], [Disabled]) 
	VALUES (5, N'RunApiProc', N'RunApiProcAction, UkrGuru.WebJobs', N'{
  "api_settings_name": "",
  "proc": "",
  "data": null,
  "body": null,
  "timeout": null,
  "result_name": null
}', 0)

SET IDENTITY_INSERT [WJbActions] OFF

END

BEGIN /*** Init WJbRules ***/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WJbRules]') AND type in (N'U'))
BEGIN
	CREATE TABLE [WJbRules](
		[RuleId] [int] IDENTITY(1000,1) NOT NULL,
		[RuleName] [nvarchar](100) NOT NULL,
		[RulePriority] [tinyint] NOT NULL,
		[ActionId] [int] NOT NULL,
		[RuleMore] [nvarchar](max) NULL,
		[Disabled] [bit] NOT NULL,
	 CONSTRAINT [PK_WJbRules] PRIMARY KEY CLUSTERED 
	(
		[RuleId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING ON
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[WJbRules]') AND name = N'UX_WJbRules_RuleName')
	CREATE UNIQUE NONCLUSTERED INDEX [UX_WJbRules_RuleName] ON [WJbRules]
	(
		[RuleName] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbRules_RulePriority]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbRules] ADD  CONSTRAINT [DF_WJbRules_RulePriority]  DEFAULT ((2)) FOR [RulePriority]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbRules_Disabled]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbRules] ADD  CONSTRAINT [DF_WJbRules_Disabled]  DEFAULT ((0)) FOR [Disabled]
END

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[FK_WJbRules_WJbActions]') AND parent_object_id = OBJECT_ID(N'[WJbRules]'))
	ALTER TABLE [WJbRules]  WITH CHECK ADD  CONSTRAINT [FK_WJbRules_WJbActions] FOREIGN KEY([ActionId]) REFERENCES [WJbActions] ([ActionId])

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[FK_WJbRules_WJbActions]') AND parent_object_id = OBJECT_ID(N'[WJbRules]'))
	ALTER TABLE [WJbRules] CHECK CONSTRAINT [FK_WJbRules_WJbActions]

SET IDENTITY_INSERT [WJbRules] ON 
IF NOT EXISTS (SELECT 1 FROM [WJbRules] WHERE (RuleId = 1))
	INSERT [WJbRules] ([RuleId], [RuleName], [RulePriority], [ActionId], [RuleMore], [Disabled]) 
	VALUES (1, N'RunSqlProc Base', 2, 1, NULL, 0)

IF NOT EXISTS (SELECT 1 FROM [WJbRules] WHERE (RuleId = 2))
	INSERT [WJbRules] ([RuleId], [RuleName], [RulePriority], [ActionId], [RuleMore], [Disabled]) 
	VALUES (2, N'SendEmail Base', 2, 2, NULL, 0)

IF NOT EXISTS (SELECT 1 FROM [WJbRules] WHERE (RuleId = 3))
	INSERT [WJbRules] ([RuleId], [RuleName], [RulePriority], [ActionId], [RuleMore], [Disabled]) 
	VALUES (3, N'FillTemplate Base', 2, 3, NULL, 0)

SET IDENTITY_INSERT [WJbRules] OFF


SET IDENTITY_INSERT [WJbRules] ON 

IF NOT EXISTS (SELECT 1 FROM [WJbRules] WHERE (RuleId = 5))
	INSERT [WJbRules] ([RuleId], [RuleName], [RulePriority], [ActionId], [RuleMore], [Disabled]) 
	VALUES (5, N'RunApiProc Base', 2, 5, NULL, 0)

SET IDENTITY_INSERT [WJbRules] OFF

END

BEGIN /*** Init WJbQueue ***/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WJbQueue]') AND type in (N'U'))
BEGIN
	CREATE TABLE [WJbQueue](
		[JobId] [int] IDENTITY(1000,1) NOT NULL,
		[JobPriority] [tinyint] NOT NULL,
		[Created] [datetime] NOT NULL,
		[RuleId] [int] NOT NULL,
		[Started] [datetime] NULL,
		[Finished] [datetime] NULL,
		[JobMore] [nvarchar](max) NULL,
		[JobStatus] [tinyint] NOT NULL,
	 CONSTRAINT [PK_WJbQueue] PRIMARY KEY CLUSTERED 
	(
		[JobId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[WJbQueue]') AND name = N'IX_WJbQueue_RuleId')
	CREATE NONCLUSTERED INDEX [IX_WJbQueue_RuleId] ON [WJbQueue]
	(
		[RuleId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbQueue_JobPriority]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbQueue] ADD  CONSTRAINT [DF_WJbQueue_JobPriority]  DEFAULT ((2)) FOR [JobPriority]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbQueue_Created]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbQueue] ADD  CONSTRAINT [DF_WJbQueue_Created]  DEFAULT (getdate()) FOR [Created]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbQueue_JobStatus]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbQueue] ADD  CONSTRAINT [DF_WJbQueue_JobStatus]  DEFAULT ((0)) FOR [JobStatus]
END

END

BEGIN /*** Init WJbHistory ***/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WJbHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [WJbHistory](
		[JobId] [int] NOT NULL,
		[JobPriority] [tinyint] NOT NULL,
		[Created] [datetime] NOT NULL,
		[RuleId] [int] NOT NULL,
		[Started] [datetime] NULL,
		[Finished] [datetime] NULL,
		[JobMore] [nvarchar](max) NULL,
		[JobStatus] [tinyint] NOT NULL,
	 CONSTRAINT [PK_WJbHistory] PRIMARY KEY CLUSTERED 
	(
		[JobId] DESC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[WJbHistory]') AND name = N'IX_WJbHistory_CreatedDesc')
	CREATE NONCLUSTERED INDEX [IX_WJbHistory_CreatedDesc] ON [WJbHistory]
	(
		[Created] DESC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[WJbHistory]') AND name = N'IX_WJbHistory_RuleId')
	CREATE NONCLUSTERED INDEX [IX_WJbHistory_RuleId] ON [WJbHistory]
	(
		[RuleId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbHistory_JobStatus]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbHistory] ADD  CONSTRAINT [DF_WJbHistory_JobStatus]  DEFAULT ((0)) FOR [JobStatus]
END

END

BEGIN /*** Init WJbFiles ***/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WJbFiles]') AND type in (N'U'))
BEGIN
	CREATE TABLE [WJbFiles](
		[Id] [uniqueidentifier] NOT NULL,
		[Created] [datetime] NOT NULL,
		[FileName] [nvarchar](100) NULL,
		[FileContent] [varbinary](max) NULL,
	 CONSTRAINT [PK_WJbFiles] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[WJbFiles]') AND name = N'IX_WJbFiles_CreatedDesc')
	CREATE NONCLUSTERED INDEX [IX_WJbFiles_CreatedDesc] ON [WJbFiles]
	(
		[Created] DESC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

BEGIN /*** Init WJbLogs ***/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WJbLogs]') AND type in (N'U'))
BEGIN
	CREATE TABLE [WJbLogs](
		[LogId] [int] IDENTITY(1,1) NOT NULL,
		[Logged] [datetime] NOT NULL,
		[LogLevel] [int] NOT NULL,
		[Title] [nvarchar](100) NOT NULL,
		[LogMore] [nvarchar](max) NULL,
	 CONSTRAINT [PK_WJbLogs] PRIMARY KEY CLUSTERED 
	(
		[LogId] DESC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[WJbLogs]') AND name = N'IX_WJbLogs_LoggedDesc')
	CREATE NONCLUSTERED INDEX [IX_WJbLogs_LoggedDesc] ON [WJbLogs]
	(
		[Logged] DESC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[WJbLogs]') AND name = N'IX_WJbLogs_LogLevel')
	CREATE NONCLUSTERED INDEX [IX_WJbLogs_LogLevel] ON [WJbLogs]
	(
		[LogLevel] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

SET ANSI_PADDING ON
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[WJbLogs]') AND name = N'IX_WJbLogs_Title')
	CREATE NONCLUSTERED INDEX [IX_WJbLogs_Title] ON [WJbLogs]
	(
		[Title] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbLogs_Created]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbLogs] ADD  CONSTRAINT [DF_WJbLogs_Created]  DEFAULT (getdate()) FOR [Logged]
END

END

BEGIN /*** Init WJbSettings ***/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WJbSettings]') AND type in (N'U'))
BEGIN
	CREATE TABLE [WJbSettings](
		[Name] [nvarchar](100) NOT NULL,
		[Value] [nvarchar](max) NULL,
	 CONSTRAINT [PK_WJbSettings] PRIMARY KEY CLUSTERED 
	(
		[Name] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbFiles_Id]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbFiles] ADD  CONSTRAINT [DF_WJbFiles_Id]  DEFAULT (newid()) FOR [Id]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF_WJbFiles_Created]') AND type = 'D')
BEGIN
	ALTER TABLE [WJbFiles] ADD  CONSTRAINT [DF_WJbFiles_Created]  DEFAULT (getdate()) FOR [Created]
END



END

END

BEGIN /***** Cron Funcs *****/
EXEC dbo.sp_executesql @statement = N'
-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER FUNCTION [dbo].[CronValidate] (@Expression varchar(100), @Now datetime)
RETURNS bit
AS
BEGIN
    SET @Expression =   REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
		                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
		                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                        UPPER(@Expression), 
		                ''JAN'', ''1''),''FEB'', ''2''),''MAR'', ''3''),''APR'', ''4''),''MAY'', ''5''),''JUN'', ''6''),
		                ''JUL'', ''7''),''AUG'', ''8''),''SEP'', ''9''),''OCT'', ''10''),''NOV'', ''11''),''DEC'', ''12''),
		                ''SUN'', ''0''),''MON'', ''1''),''TUE'', ''2''),''WED'', ''3''),''THU'', ''4''),''FRI'', ''5''),''SAT'', ''6'')

    IF @Expression LIKE ''%[^0-9*,-/ ]%'' RETURN 0

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, '' '', 1), DATEPART(MINUTE, @Now), 0, 59) = 0 RETURN 0;

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, '' '', 2), DATEPART(HOUR, @Now), 0, 23) = 0 RETURN 0;

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, '' '', 3), DATEPART(DAY, @Now), 1, 31) = 0 RETURN 0;

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, '' '', 4), DATEPART(MONTH, @Now), 1, 12) = 0 RETURN 0;

    IF dbo.CronValidatePart(dbo.CronWord(@Expression, '' '', 5), dbo.CronWeekDay(@Now), 0, 6) = 0 RETURN 0;

    RETURN 1
END
';
EXEC dbo.sp_executesql @statement = N'
-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER FUNCTION [dbo].[CronValidatePart](@Expression varchar(100), @Value int, @Min int, @Max int)
RETURNS tinyint
AS
BEGIN
    IF @Expression LIKE ''%[^0-9*,-/]%'' RETURN 0
    IF @Value IS NULL OR @Min IS NULL OR @Max IS NULL OR NOT @Value BETWEEN @Min AND @Max RETURN 0  

    IF @Expression = ''*'' RETURN 1

    IF CHARINDEX('','', @Expression, 0) > 0 BEGIN
        RETURN (SELECT MAX(dbo.CronValidatePart(value, @Value, @Min, @Max)) 
            FROM STRING_SPLIT(@Expression, '','') 
            WHERE LEN(value) > 0);
    END

    IF CHARINDEX(''-'', @Expression, 0) > 0 
        RETURN dbo.CronValidateRange(@Expression, @Value, @Min, @Max)

    ELSE IF CHARINDEX(''/'', @Expression, 0) > 0 
        RETURN dbo.CronValidateStep(@Expression, @Value, @Min, @Max)

    ELSE IF TRY_CAST(@Expression as int) = @Value 
        RETURN 1

    RETURN 0
END
';
EXEC dbo.sp_executesql @statement = N'
-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER FUNCTION [dbo].[CronValidateRange](@Expression varchar(100), @Value int, @Min int, @Max int)
RETURNS tinyint
AS
BEGIN
    IF @Expression LIKE ''%[^0-9*-/]%'' RETURN 0
    IF @Value IS NULL OR @Min IS NULL OR @Max IS NULL OR NOT @Value BETWEEN @Min AND @Max RETURN 0  

    DECLARE @Begin int, @End int, @Step int

    IF CHARINDEX(''/'', @Expression, 0) > 0 BEGIN
        SET @Step = TRY_CAST(dbo.CronWord(@Expression, ''/'', 2) as int);
        IF ISNULL(@Step, 0) <= 0 RETURN 0;

        SET @Expression = dbo.CronWord(@Expression, ''/'', 1);
    END

    SET @Begin = TRY_CAST(dbo.CronWord(@Expression, ''-'', 1) as int);
    SET @End = TRY_CAST(dbo.CronWord(@Expression, ''-'', 2) as int);
    SET @Step = ISNULL(@Step, 1);

    IF @Begin IS NULL OR @End IS NULL RETURN 0;

    DECLARE @i int = @Begin, @OneMore int = CASE WHEN @End < @Begin THEN 1 ELSE 0 END 
    
    IF @OneMore = 0 AND @End < @Max SET @Max = @End 

    WHILE @i <= @Max BEGIN

        IF @i = @Value RETURN 1

        SET @i += @Step;

        IF @i > @Max AND @OneMore = 1 BEGIN
            SET @i -= (@Max + 1);
            SET @Max = @End
            SET @OneMore = 0; 
        END
    END
   
    RETURN 0
END
';
EXEC dbo.sp_executesql @statement = N'
-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER FUNCTION [dbo].[CronValidateStep](@Expression varchar(100), @Value int, @Min int, @Max int)
RETURNS tinyint
AS
BEGIN
    IF @Expression LIKE ''%[^0-9*/]%'' RETURN 0
    IF @Value IS NULL OR @Min IS NULL OR @Max IS NULL OR NOT @Value BETWEEN @Min AND @Max RETURN 0  

    DECLARE @Start int = ISNULL(TRY_CAST(dbo.CronWord(@Expression, ''/'', 1) as int), 0),
        @Step int = TRY_CAST(dbo.CronWord(@Expression, ''/'', 2) as int);

    IF @Start IS NULL OR @Step IS NULL OR ISNULL(@Step, 0) <= 0 RETURN 0;

    DECLARE @i int = @Start;
    WHILE @i <= @Max 
    BEGIN
        IF @i = @Value RETURN 1;
            
        SET @i += @Step;
    END

    RETURN 0
END
';
EXEC dbo.sp_executesql @statement = N'
-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER FUNCTION [dbo].[CronWeekDay](@Now datetime)
RETURNS int
AS
BEGIN
    RETURN (DATEPART(weekday, @Now) + @@DATEFIRST + 6) % 7
END
';
EXEC dbo.sp_executesql @statement = N'
-- ==============================================================
-- Copyright (c) Oleksandr Viktor (UkrGuru). All rights reserved.
-- ==============================================================
CREATE OR ALTER FUNCTION [dbo].[CronWord](@Expression varchar(100), @Separator char(1) = '' '', @Index int)
RETURNS varchar(100)
AS
BEGIN
    DECLARE @i int = 0, @v varchar(100);

    SELECT @i = @i + 1, @v = CASE WHEN @i <= @Index THEN value ELSE @v END   
    FROM STRING_SPLIT(@Expression, @Separator)
    WHERE LEN(value) > 0

    RETURN CASE WHEN @i < @Index THEN NULL ELSE @v END
END
';
END

BEGIN /*** WJbFiles Procs ***/
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbFiles_Get]
	@Data uniqueidentifier
AS
SELECT Id, Created, FileName, FileContent
FROM WJbFiles
WHERE Id = @Data
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
';
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbFiles_Ins]
    @Data nvarchar(max)
AS
DECLARE @Id uniqueidentifier = NEWID();

INSERT WJbFiles (Id, Created, FileName, FileContent)
SELECT @Id Id, GETDATE() Created, * 
FROM OPENJSON(@Data) 
WITH (FileName nvarchar(100), FileContent varbinary(max))

SELECT CAST(@Id as varchar(50)) Id
';

END

BEGIN /*** WJbLogs Procs ***/
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbLogs_Ins]
    @Data nvarchar(max)
AS
INSERT INTO WJbLogs (LogLevel, Title, LogMore)
VALUES (JSON_VALUE(@Data, ''$.LogLevel''), JSON_VALUE(@Data, ''$.Title''), 
    ISNULL(JSON_QUERY(@Data, ''$.LogMore''), JSON_VALUE(@Data, ''$.LogMore'')))
';
END

BEGIN /*** WJbQueue Procs ***/
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbQueue_Finish] 
    @Data varchar(100)
AS
WITH cte 
AS (
    SELECT TOP 1 JobId, JobPriority, Created, RuleId, Started, GETDATE() AS Finished, JobMore, JSON_VALUE(@Data, ''$.JobStatus'') JobStatus 
    FROM WJbQueue
    WHERE JobId = JSON_VALUE(@Data, ''$.JobId'') AND Started IS NOT NULL
    )
DELETE cte 
OUTPUT deleted.* INTO WJbHistory
';
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbQueue_FinishAll] 
AS
;WITH cte 
AS (
    SELECT JobId, JobPriority, Created, RuleId, Started, GETDATE() AS Finished, JobMore, 5 /* Cancelled */ JobStatus 
    FROM WJbQueue
    WHERE Started IS NOT NULL
    )
DELETE cte 
OUTPUT deleted.* INTO WJbHistory
';
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbQueue_Ins]
	@Data nvarchar(max) 
AS
DECLARE @RuleId int = CASE WHEN ISNUMERIC(JSON_VALUE(@Data, ''$.Rule'')) = 1 THEN JSON_VALUE(@Data, ''$.Rule'') 
    ELSE (SELECT TOP 1 RuleId FROM WJbRules WHERE (RuleName = JSON_VALUE(@Data, ''$.Rule''))) END;

INSERT INTO WJbQueue (RuleId, JobPriority, JobMore, JobStatus)
SELECT @RuleId, JSON_VALUE(@Data, ''$.RulePriority''), JSON_QUERY(@Data, ''$.RuleMore''), 1 /* Queued */

SELECT CAST(SCOPE_IDENTITY() AS varchar) Id
';
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbQueue_InsCron]
AS
INSERT INTO WJbQueue (RuleId, JobPriority, JobStatus)
SELECT R.RuleId, R.RulePriority, 1 /* Queued */ 
FROM WJbRules R
WHERE R.Disabled = 0 
AND NOT JSON_VALUE(R.RuleMore, ''$.cron'') IS NULL
AND NOT EXISTS (SELECT 1 FROM WJbQueue WHERE RuleId = R.RuleId)
AND dbo.CronValidate(JSON_VALUE(R.RuleMore, ''$.cron''), GETDATE()) = 1
';
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbQueue_Get]
	@Data int
AS
SELECT TOP (1) Q.*, R.RuleMore, A.ActionName, A.ActionType, A.ActionMore
FROM WJbQueue Q
INNER JOIN WJbRules R ON Q.RuleId = R.RuleId 
INNER JOIN WJbActions A ON R.ActionId = A.ActionId
WHERE Q.JobId = @Data
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
';
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbQueue_Start1st]
AS
DECLARE @JobId int;

;WITH cte 
AS (
    SELECT TOP 1 JobId, Started, JobStatus 
    FROM WJbQueue
    WHERE [Started] IS NULL 
    ORDER BY JobPriority ASC, JobId ASC
    )
UPDATE cte 
SET @JobId = JobId, [Started] = GETDATE(), JobStatus = 2 /* Running */

EXEC WJbQueue_Get @JobId
';

END

BEGIN /*** WJbSettings Procs ***/
EXEC dbo.sp_executesql @statement = N'
CREATE OR ALTER PROCEDURE [WJbSettings_Get]
	@Data nvarchar(100)
AS
SELECT TOP 1 [Value]
FROM WJbSettings
WHERE Name = @Data
';
EXEC dbo.sp_executesql @statement = N'
/*
EXEC WJbSettings_Set ''{ "Name":"Name1", "Value":"Value1" }''
*/
CREATE OR ALTER PROCEDURE [WJbSettings_Set]
	@Data nvarchar(max)
AS
DECLARE @Name nvarchar(100), @Value nvarchar(max)

SELECT @Name = D.[Name], @Value = D.[Value]
FROM OPENJSON(@Data) WITH ([Name] nvarchar(100), [Value] nvarchar(max)) D

UPDATE WJbSettings
SET [Value] = @Value
WHERE ([Name] = @Name)

IF @@ROWCOUNT = 0 
    INSERT INTO WJbSettings ([Name], [Value]) 
    VALUES (@Name, @Value)
';
END
