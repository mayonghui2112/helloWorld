declare @table_id int
set @table_id=object_id('dbo.[Log_Install(61.129.59.67.dubadg)]')
dbcc showcontig(@table_id)


--�ڶ���:�ع�������
dbcc dbreindex('����',pk_������,100)
--������һ�����緢��ɨ���ܶ�/Scan Density����С��100%���ع������������
--�������һ���ܴ�100%��
dbcc dbreindex('dbo.Last_Log_Machine_Bind','',100)
