
����--��������-IT������������ƪ��̳����(��������������)��Ҫ������SQL Server 2005���ݿ⾵������ýű�����ϸ�������Ҳο����ģ� 

����--SQL Server 2005���ݿ⾵�����ýű�: 

����ʾ�����£� 

����--��MIR-A�ϣ��������ݿ⾵��˵� 

����create endpoint DB_MirroringEP 

����AS tcp (listener_port = 5022) 

����for database_Mirroring (role = partner,encryption=supported); 

����go 

����--��MIR-B�ϣ��������ݿ⾵��˵㣬���ڻ��ͨѶ 

����CREATE ENDPOINT Db_MirroringEP 

����AS TCP (LISTENER_PORT = 5022) 

����FOR DATABASE_MIRRORING (ROLE = PARTNER, ENCRYPTION = SUPPORTED); 

����GO 

����ALTER ENDPOINT Db_MirroringEP STATE = STARTED 

����GO 

����--��MIR-W�ϣ��������ݿ⾵��˵㣬���ڼ�֤ͨѶ 

����CREATE ENDPOINT Db_MirroringEP 

����AS TCP (LISTENER_PORT = 5022) 

����FOR DATABASE_MIRRORING (ROLE = WITNESS, ENCRYPTION = SUPPORTED); 

����GO 

����ALTER ENDPOINT Db_MirroringEP STATE = STARTED 

����GO 

����--��MIR-A��MIR-B��MIR-W�ϣ����˵����� 

����SELECT * FROM sys.database_mirroring_endpoints 

����GO 

����--��MIR-A��MIR-B��MIR-W�ϣ��������ݿ⾵��ȫ�ԣ�somodesql.comΪ�Լ������� 

����use master 

����go 

����grant connect on endpoint::"DB_MirroringEP" to "SOMODESQL\sqladmin" 

����go 

����--��MIR-A�ϣ���AdventureWorks���ݿ�����ȫ���� 

����BACKUP DATABASE AdventureWorks TO DISK = 'C:\AdventureWorks.bak' 

����GO 

����--��MIR-B�ϻָ�AdventureWorks���ݿ⡣ 

����--ͨ����ȫ�������� C:\AdventureWorks.bak ���Ƶ� MIR-B�� 

����--�� MIR-B �ľ��������ʵ���ϻ�ԭ���ݿ⣺ 

����RESTORE DATABASE AdventureWorks 

����FROM DISK = 'C:\AdventureWorks.bak' 

����WITH NORECOVERY 

����GO 

����--�������ݿ⾵��ע��˳����Ҫ�������ھ�������������û�� 

����--��MIR-B�ϣ�ָ�����˵�,somodesql.comΪ�Լ������� 

����alter database AdventureWorks 

����set partner = N'TCP://MIR-A.somodesql.com:5022' 

����GO 

����--��MIR-A�ϣ�ָ�����˵� 

����alter database AdventureWorks 

����set partner = N'TCP://MIR-B.somodesql.com:5022' 

����GO 

����--��MIR-A�ϣ�ָ����֤�������˵� 

����ALTER DATABASE AdventureWorks 

����SET WITNESS = N'TCP://MIR-W.somodesql.com:5022' 

����GO 

����--�������ݿ⾵������ȫ���� 

����ALTER DATABASE AdventureWorks SET SAFETY FULL 

����GO 

����--=================�鿴���ݿ⾵�������״̬================= 

����-- 1.)ͨ��Management studio ������Դ���������鿴�������ݿ⡢�������ݿ�״̬ 

����-- 2.)ͨ��Management studio ������Դ�������е����ݿ����Բ鿴״̬ 

����-- 3.)ͨ��ϵͳĿ¼��ͼ�鿴���ݿ⾵��������� 

����use master 

����go 

����SELECT * FROM sys.database_mirroring_endpoints 

����SELECT * FROM sys.database_mirroring WHERE database_id = 

����(SELECT database_id FROM sys.databases WHERE name = 'AdventureWorks') 

	

	//////////////////////////////////////////////////////////////////////////////////////////////
	--1 �ھ����������,�������ݿ����
	create database db_temp
	on (name=mfw_data,filename='C:\temp_file.ss')
	as snapshot of mfw

	--2 ���ʾ�����վݿ�
	use db_temp
	select * from SeedMachine

	--3ɾ����Ҫ�õĿ��վݿ�
	Use master
	Go
	Drop database db_temp
	go
	--*********************************************************************
	--ʹ�������ݿ�ǿ�Ʒ���
	ALTER DATABASE <database_name> SET PARTNER FORCE_SERVICE_ALLOW_DATA_LOSS
	--�ֶ�����ת��
	ALTER DATABASE <database_name> SET PARTNER FAILOVER
	--*********************************************************************
	--�������ݿ�Ϊ��ȫ����
	RESTORE DATABASE mfw WITH RECOVERY
	--*********************************************************************
	--����trace����
	--��������trace 1400
	--����1��
	dbcc traceon (1400) --�ֲ�
	dbcc traceoff (1400)
	dbcc traceon (1400, -1) --ȫ��
	dbcc traceoff (1400, -1)
	--����2��
	--�ڷ���������������������;��׷��-T 1400
	dbcc tracestatus --�鿴trace

	--�޸ĳ�ʱ��ѯ��ʱ���޸Ľ����ڸ߰�ȫģʽ��
	ALTER DATABASE <database> SET PARTNER TIMEOUT <integer> 
	select mirroring_connection_timeout from sys.database_mirroring