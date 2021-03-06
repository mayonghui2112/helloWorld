
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[ipstr2bigint] (@ipstr varchar(50))  
RETURNS bigint AS
BEGIN 
	declare @index int
	declare @leftstr varchar(50)
	declare @res bigint
	set @index=CHARINDEX('.',@ipstr)
	if (@index = 0)
	begin
		return 0
	end
	set @leftstr=left(@ipstr, @index-1)
	set @ipstr=right(@ipstr, len(@ipstr)-@index)
	set @res=cast(@leftstr as bigint)

	set @index=CHARINDEX('.',@ipstr)
	if (@index = 0)
	begin
		return 0
	end
	set @leftstr=left(@ipstr, @index-1)
	set @ipstr=right(@ipstr, len(@ipstr)-@index)
	set @res=@res*256+cast(@leftstr as bigint)

	set @index=CHARINDEX('.',@ipstr)
	if (@index = 0)
	begin
		return 0
	end
	set @leftstr=left(@ipstr, @index-1)
	set @ipstr=right(@ipstr, len(@ipstr)-@index)
	set @res=@res*256+cast(@leftstr as bigint)

	set @res=@res*256+cast(@ipstr as bigint)

	return @res
END
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

