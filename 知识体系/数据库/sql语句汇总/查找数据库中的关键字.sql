--�������п���ĳ��ֵ 
--�������̣���������Ҫ��ѯ���ַ���
create proc proc_selectall
@s varchar(50)--��Ĺؼ���
as
begin
declare @sql varchar(8000),@where varchar(8000)
declare cursor_tb cursor for
select name from sysobjects where xtype='u'
declare @name varchar(50)
open cursor_tb
fetch next from cursor_tb
into @name
while @@FETCH_STATUS = 0
begin
select @sql=isnull(@sql+' or ','')+'ltrim(['+name+'])='''+@s+''''
from syscolumns where id=object_id(@name)
set @where=replace(@sql,'''','''''')
exec('if exists(select 1 from ['+@name+'] where '+@sql+') exec(''select * from ['+@name+'] where '+@where+''')')
select @sql=null
fetch next from cursor_tb
into @name
end
close cursor_tb
deallocate cursor_tb
end
go 




--����
if object_id('tb') is not null
drop table tb
if object_id('ta')is not null
drop table ta
go
create table tb(s varchar(50))
insert into tb select 'abc'
create table ta(s varchar(50))
insert into ta select 'abc'
go

exec proc_selectall 'abc'

select * from syscolumns group by xtype


