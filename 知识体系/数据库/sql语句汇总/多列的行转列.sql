create table t(name varchar(03),subject varchar(10),mark int)
insert into t
select 'A','�Z��',80 union all
select 'A','���W',80 union all
select 'A','���Z',80 union all
select 'B','���W',80 union all
select 'B','���Z',80 union all
select 'C','�Z��',78

--��ʹ�ö�̬������ʱ�� ����ʹ�ö�̬�ı�
--��һ
declare @sql varchar(8000),@count int
select @count=count(distinct subject) from T
set @sql='select name'
select @sql=@sql+',sum(case when subject='''+subject+''' then mark else 0 end) as '+subject
from T
group by subject

select @sql=@sql+',sum(isnull(mark,0))/'+rtrim(@count)+' as [avg]  from t group by name'
exec(@sql)
/*
name ���Z          �Z��          ���W          avg         
---- ----------- ----------- ----------- ----------- 
A    80          80          80          80
B    80          0           80          53
C    0           78          0           26
*/
drop table t
--�𰸶�
create table tb(name varchar(10),subject varchar(10),mark int)

insert into tb values('A',         '����',      80)
insert into tb values('A',         '��ѧ',      80)
insert into tb values('A',         '����',      80 )
insert into tb values('B',         '��ѧ',      80)
insert into tb values('B',         '����',      80)
insert into tb values('C',         '����',      78)

select name ,
  max(case subject when '����' then mark else 0 end) '����',
  max(case subject when '��ѧ' then mark else 0 end) '��ѧ',
  max(case subject when '����' then mark else 0 end) '����',
  sum(mark)/(select max(cnt) cnt from (select name , count(*) cnt from tb group by name) t) [avg]
from tb
group by name

declare @sql varchar(8000)
set @sql = 'select Name as ' + '����'
select @sql = @sql + ' , sum(case Subject when ''' + Subject + ''' then mark else 0 end) [' + Subject + ']'
from (select distinct Subject from tb) as a
set @sql = @sql + ' ,sum(mark)/(select max(cnt) cnt from (select name , count(*) cnt from tb group by name) t) [avg] from tb group by name'
exec(@sql) 

drop table tb



