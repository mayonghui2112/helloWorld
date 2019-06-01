--�鿴���������Ƭ
DECLARE @db_id SMALLINT;
DECLARE @object_id INT;

SET @db_id = DB_ID(N'zuoTest');
SET @object_id = OBJECT_ID(N'zuoTest.dbo.Last_Account_Bind_verify_Info');

IF @db_id IS NULL
BEGIN;
    PRINT N'Invalid database';
END;
ELSE IF @object_id IS NULL
BEGIN;
    PRINT N'Invalid object';
END;
ELSE
BEGIN;
    SELECT database_id as ���ݿ�ID,
	object_id as [������/��ͼID],
	index_id as ����ID,
	partition_number as ������,
	index_type_desc as ��������,
	avg_fragmentation_in_percent as �����߼���Ƭ,
	fragment_count as Ҷ������Ƭ��,
	avg_fragment_size_in_pages as ��Ƭ��ƽ��ҳ��,
	avg_page_space_used_in_percent as ҳʹ�ô洢�ռ�ƽ���ٷֱ�,
	record_count as �ܼ�¼��
	FROM sys.dm_db_index_physical_stats(@db_id, @object_id, NULL, NULL , 'LIMITED');
END;
GO

--ǿ��ʹ������
select top 100 * from PartitionPaySys.dbo.FactPayRecord with (index=IX_active_time) 
where Active_Time<'2009-02-02' and active_time>'2009-02-01'

select top 1000 * from alluserwithallfields a with(index=ip) left join iptable b with(index=IX_IP) on 
a.install_ip>i_start_ip and install_ip<i_end_ip and install_time<='2008-1-1' 

