--����ȡƴ������
create function FunGetPinYin(@Str varchar(500)='')
returns varchar(500)
as
begin
    declare @strlen int,@return varchar(500),@ii int
    select @strlen=len(@str),@return='',@ii=0
    set @ii=0
    while @ii<@strlen
    begin
        set @ii=@ii+1
        select @return=@return+py
            from (select 0xB0A1 as cbegin, 0xB0C4 as cend,'A' as py
                union all select 0xB0C5, 0xB2C0,'B' 
                union all select 0xB2C1, 0xB4ED,'C'
                union all select 0xB4EE, 0xB6E9,'D'
                union all select 0xB6EA, 0xB7A1,'E'
                union all select 0xB7A2, 0xB8C0,'F'
                union all select 0xB8C1, 0xB9FD,'G'
                union all select 0xB9FE, 0xBBF6,'H'
                union all select 0xBBF7, 0xBFA5,'J'
                union all select 0xBFA6, 0xC0AB,'K'
                union all select 0xC0AC, 0xC2E7,'L'
                union all select 0xC2E8, 0xC4C2,'M'
                union all select 0xC4C3, 0xC5B5,'N'
                union all select 0xC5B6, 0xC5BD,'O'
                union all select 0xC5BE, 0xC6D9,'P'
                union all select 0xC6DA, 0xC8BA,'Q'
                union all select 0xC8BB, 0xC8F5,'R'
                union all select 0xC8F6, 0xCBF9,'S'
                union all select 0xCBFA, 0xCDD9,'T'
                union all select 0xCDDA, 0xCEF3,'W'
                union all select 0xCEF4, 0xD1B8,'X'
                union all select 0xD1B9, 0xD4D0,'Y'
                union all select 0xD4D1, 0xD7F9,'Z') a
            where cast(substring(@str,@ii,1) as varbinary)
                    between cbegin and cend
    end
    return(@return)
end

go
--����
select dbo.FunGetPinYin('����һ����') as ����һ����,dbo.FunGetPinYin('�й���') as �й���

--ɾ��ƴ������
drop function fgetpy


USE [OperatorsV5]
GO
/****** ����:  UserDefinedFunction [dbo].[FunGetPinYin]    �ű�����: 03/24/2009 16:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--����ȡƴ������
CREATE function [dbo].[FunGetPinYin](@Str varchar(500)='')
returns varchar(500)
as
begin
    declare @strlen int,@return varchar(500),@ii int,@temp varchar(10),@one varchar(5)
    select @strlen=len(@str),@return='',@ii=0
    set @ii=1
    while @ii<@strlen+1
    begin
        select @temp=py 
            from (select 0xB0A1 as cbegin, 0xB0C4 as cend,'A' as py
                union all select 0xB0C5, 0xB2C0,'B' 
                union all select 0xB2C1, 0xB4ED,'C'
                union all select 0xB4EE, 0xB6E9,'D'
                union all select 0xB6EA, 0xB7A1,'E'
                union all select 0xB7A2, 0xB8C0,'F'
                union all select 0xB8C1, 0xB9FD,'G'
                union all select 0xB9FE, 0xBBF6,'H'
                union all select 0xBBF7, 0xBFA5,'J'
                union all select 0xBFA6, 0xC0AB,'K'
                union all select 0xC0AC, 0xC2E7,'L'
                union all select 0xC2E8, 0xC4C2,'M'
                union all select 0xC4C3, 0xC5B5,'N'
                union all select 0xC5B6, 0xC5BD,'O'
                union all select 0xC5BE, 0xC6D9,'P'
                union all select 0xC6DA, 0xC8BA,'Q'
                union all select 0xC8BB, 0xC8F5,'R'
                union all select 0xC8F6, 0xCBF9,'S'
                union all select 0xCBFA, 0xCDD9,'T'
                union all select 0xCDDA, 0xCEF3,'W'
                union all select 0xCEF4, 0xD1B8,'X'
                union all select 0xD1B9, 0xD4D0,'Y'
                union all select 0xD4D1, 0xD7F9,'Z') a
            where cast(substring(@str,@ii,1) as varbinary)
                    between cbegin and cend
			set @one=cast(substring(@str,@ii,1) as varbinary)
			select @return=@return+ISNULL(@temp,@one)
			set @ii=@ii+1
			set @temp=NULL
    end
    return(lower(@return))
end




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[FunGetPinYin](@str nvarchar(4000))
returns nvarchar(4000)
as
begin
declare @strlen int,@re nvarchar(4000)
declare @t table(chr nchar(1) collate Chinese_PRC_CI_AS,letter nchar(1))
insert into @t(chr,letter)
  select '߹','A' union all select '��','B' union all
  select '��','C' union all select '��','D' union all
  select '��','E' union all select '��','F' union all
  select '�','G' union all select '��','H' union all
  select 'آ','J' union all select '��','K' union all
  select '��','L' union all select '�`','M' union all
  select '��','N' union all select '��','O' union all
  select '�r','P' union all select '��','Q' union all
  select '��','R' union all select '��','S' union all
  select '��','T' union all select '��','W' union all
  select 'Ϧ','X' union all select 'Ѿ','Y' union all
  select '��','Z'
  select @strlen=len(@str),@re=''
  while @strlen>0
  begin
    select top 1 @re=letter+@re,@strlen=@strlen-1
      from @t a where chr<=substring(@str,@strlen,1)
      order by chr desc
    if @@rowcount=0
      select @re=substring(@str,@strlen,1)+@re,@strlen=@strlen-1
  end
  return(lower(@re))
end
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

