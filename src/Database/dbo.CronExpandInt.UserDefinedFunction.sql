SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
SELECT * FROM dbo.CronExpandInt('0', 0, 59)
*/
CREATE FUNCTION [dbo].[CronExpandInt] (@Expression varchar(100), @Min int, @Max int) 
RETURNS @Values TABLE (Value int)
AS BEGIN
	IF @Expression = '*' OR @Min IS NULL OR @Max IS NULL OR @Min > @Max RETURN;
	IF CHARINDEX(',', @Expression, 1) + CHARINDEX('/', @Expression, 1) + CHARINDEX('-', @Expression, 1) > 0 RETURN;
	IF CONVERT(int, @Expression) < @Min OR CONVERT(int, @Expression) > @Max RETURN;

	INSERT @Values (Value) SELECT Value = CONVERT(int, @Expression)

	RETURN	
END
GO
