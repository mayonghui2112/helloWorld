use master
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'Data Partition DB3')
DROP DATABASE [Data Partition DB3]
GO
CREATE DATABASE [Data Partition DB3]
ON PRIMARY
(NAME='Data Partition DB Primary FG3',
FILENAME=
'C:\Data2\Primary\Data Partition DB Primary FG3.mdf',
SIZE=5,
MAXSIZE=500,
FILEGROWTH=1 ),
FILEGROUP [Data Partition DB3 FG1]
(NAME = 'Data Partition DB3 FG1',
FILENAME =
'C:\Data2\FG1\Data Partition DB3 FG1.ndf',
SIZE = 5MB,
MAXSIZE=500,
FILEGROWTH=1 ),
FILEGROUP [Data Partition DB3 FG2]
(NAME = 'Data Partition DB3 FG2',
FILENAME =
'C:\Data2\FG2\Data Partition DB3 FG2.ndf',
SIZE = 5MB,
MAXSIZE=500,
FILEGROWTH=1 ),
FILEGROUP [Data Partition DB3 FG3]
(NAME = 'Data Partition DB3 FG3',
FILENAME =
'C:\Data2\FG3\Data Partition DB3 FG3.ndf',
SIZE = 5MB,
MAXSIZE=500,
FILEGROWTH=1 ),
FILEGROUP [Data Partition DB3 FG4]
(NAME = 'Data Partition DB3 FG4',
FILENAME =
'C:\Data2\FG4\Data Partition DB3 FG4.ndf',
SIZE = 5MB,
MAXSIZE=500,
FILEGROWTH=1 )

--Ȼ����һ�����ݱ�
USE [Data Partition DB3]
go
CREATE TABLE MyTable
(ID INT NOT NULL,
Date DATETIME,
Cost money ) on [primary]

--������һ���ۼ�����
USE [Data Partition DB3]
go
CREATE UNIQUE CLUSTERED INDEX MyTable_IXC
ON MyTable(ID) on [PRIMARY]

--��������������������
USE [Data Partition DB3]
go
declare @count int
set @count =-25
while @count <=100
begin
insert into MyTable select @count,getdate(),100.00
set @count=@count+1
end
set @count =101
while @count <=200
begin
insert into MyTable select @count,getdate(),200.00
set @count=@count+1
end
set @count =201
while @count <=300
begin
insert into MyTable select @count,getdate(),300.00
set @count=@count+1
end
set @count =301
while @count <=400
begin
insert into MyTable select @count,getdate(),400.00
set @count=@count+1
end
set @count =401
while @count <=800
begin
insert into MyTable select @count,getdate(),500.00
set @count=@count+1
end

--��ʱ��ѯһ�£����Կ������ݶ���һ������

select * from sys.partitions where object_name(object_id)='MyTable'
 
--�����ٽ������������

use [Data Partition DB3]
GO
CREATE PARTITION FUNCTION [Data Partition Range](int)
AS RANGE LEFT FOR VALUES (100,200,300)

--�������������ԭ�����ĸ��������Ӹ�����100��101-200��201-300������300
--��Ȼ�������right for values�Ļ������ǴӸ�����99��100��199��200-299���ʹ���300
 
--��󣬰ѱ��������Ӧ�õ��ļ�����

USE [Data Partition DB3]
go
CREATE PARTITION SCHEME [Data Partition Scheme]
AS PARTITION [Data Partition Range]
TO ([Data Partition DB3 FG1], [Data Partition DB3 FG2], [Data Partition DB3 FG3],[Data Partition DB3 FG4]);

--��ԭ�������õı��ƶ�������������
Drop index MyTable_IXC on MyTable with (Move To [Data Partition Scheme] (ID) )
 
--���һ��

select * from sys.partitions where object_name(object_id)='MyTable'
 
--���Կ�����ԭ���ı�����ݱ���ȷ�ֲ��ĸ��ļ�����ȥ�ˣ�ʵ���˱����

select * from dbo.MyTable

--���ĳ��ֵ���ĸ������У��÷�������
select $partition.[Data Partition Range](800)

http://www.cndw.com/tech/data/2006051268831.asp?jdfwkey=42585
