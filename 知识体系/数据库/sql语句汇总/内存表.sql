
--��ʱ��#temp 

--�ڴ��=�������@temp Ψһ����ĵط����ǹ��̽�������������ͷ��� 

--sql server ����û�г�פ�ڴ�ı����������˵ û�����������ϵ��ڴ�� 

declare  @DataSynLog table (idx uniqueidentifier,
	tabelname nvarchar(50),
	tabel_idx nvarchar(50),
	updata_time smalldatetime,
	isdelete int,
	level int,
	Code int,
	dowork int)  

insert into @DataSynLog select * from datasynlog

select * from @DataSynLog