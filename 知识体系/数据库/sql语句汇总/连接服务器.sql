EXEC sp_addlinkedsrvlogin 
'PC901', 
'false', 
NULL, 
--Զ�̷������ĵ�½�û��� 
'sa', 
--Զ�̷������ĵ�½���� 
'12345670' 
go 

create view abc
as
select * from KAH_WANGSY.�����ش��߲�������Ϣ���ݿ�.dbo.Agencies
union all
select * from [PC901\ITZHL].�����ش��߲�������Ϣ���ݿ�.dbo.Agencies
go 

select * from abc

SELECT top 100 * FROM openquery(dubadg,'select * from DBPAYSYS.
account_base where lower(substr(ACCOUNT,0,4))<>''ksol'' and ACCOUNT_ID> 76942635')