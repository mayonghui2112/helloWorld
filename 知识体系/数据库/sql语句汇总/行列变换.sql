select * from dbo.reportData

create table t (id int,name varchar(10),code int)
insert t values(1,'�˿�',20)
insert t values(1,'����',12)
insert t values(1,'�Ļ�',15)
insert t values(1,'����',45) 
insert t values(1,'�˿�',120)
insert t values(1,'����',112)
insert t values(1,'�Ļ�',115)
insert t values(1,'����',145) 
insert t values(2,'�˿�',200)
insert t values(2,'����',120)
insert t values(2,'�Ļ�',150)
insert t values(2,'����',450) 

select id,name,sum(code) from t group by id,name 

declare @sql varchar(1000)
set @sql = ''
select @sql =@sql+ name+'=max(case when name='''+name+''' then code else 0 end),' from t group by name
print @sql 
set @sql = left(@sql,len(@sql) - 1)
set @sql = 'select id,'+@sql+' from t group by id'
exec (@sql)
--drop table t 

ʵ���� 

create   table   #(a   varchar(100),b   int)   
  insert   #   values('aa',11)   
  insert   #   values('bb',1)   
  insert   #   values('aa',45)   
  insert   #   values('cc',81)   
  insert   #   values('a',11)   
  insert   #   values('aay',561)   
  insert   #   values('a',14)   
    
  declare   @sql   varchar(8000)   
  set   @sql   =   'select   '   
  select   @sql   =   @sql   +   'sum(case   a   when   '''+a+'''     
                                                      then   b   else   0   end)   '+a+'������,'   
      from   (select   distinct   a   from   #)   as   a   
    
  select   @sql   =   left(@sql,len(@sql)-1)   +   '   from   #'   
    
  exec(@sql)   
    
select * from #
--  drop   table   # 


--���ɲ�������   
create   table   tabname(Name   varchar(20),Date   datetime,Number   int)   
insert   into   tabname   select   '001','2005/12/1',50   
insert   into   tabname   select   '001','2005/12/2',70   
insert   into   tabname   select   '001','2005/12/3',80   
insert   into   tabname   select   '001','2005/12/1',45   
insert   into   tabname   select   '001','2005/12/2',55  
insert   into   tabname   select   '001','2008/12/2',55  
go   
select identity(int,1,1) as id,* into # from tabname   
--ִ�ж�̬������ѯ   
declare   @s   varchar(8000)   
set   @s   =   ''   
select @s=@s+',['+convert(char(10),[Date],111)+']=max(case when [Date]='''+
convert(char(10),[Date],120)+'''and id='+rtrim(id)+'then Number else 0 end)'   
from # group by id,[Date] order by id,[Date]   
set   @s='select Name'+@s+'from # group by Name order by Name'   
exec(@s)   
go   

select * from #
--ɾ����������   
drop   table   tabname,#   
go




