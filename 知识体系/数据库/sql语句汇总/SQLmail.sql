exec msdb..sysmail_add_profile_sp @profile_name = 'dba_profile',
@description  = 'dba mail profile',@profile_id   = null


exec msdb..sysmail_add_profileaccount_sp  @profile_name= 'dba_profile' -- profile ���� 
,@account_name= 'test'     -- account ����
 ,@sequence_number = 1-- account �� profile ��˳��   


select * from dbo.abc

declare @b nvarchar(100)
set @b='���Ż���'+convert(varchar(2),datediff(d,getdate(),'2009-08-18'))+'�죬������ҵ�'
exec msdb..sp_send_dbmail @profile_name =  'dba_profile'-- profile ����
,@recipients   =  'jackfor001@126.com'-- �ռ�������
,@subject=@b -- �ʼ�����
,@body=  '����׼���ü޸��Ұɣ��������һ�úð���ģ�������'-- �ʼ�����
,@body_format='TEXT'-- �ʼ���ʽ   


EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'dba_profile',
    @recipients = 'zuowenming@kingsoft.com',
    @query = 'SELECT * FROM AdventureWorks.Production.WorkOrder
                  WHERE DueDate > ''2004-04-30''
                  AND  DATEDIFF(dd, ''2004-04-30'', DueDate) < 2' ,
    @subject = '���Ż���'+convert(varchar(2),datediff(d,getdate(),'2009-08-18'+'��';



SELECT * FROM AdventureWorks.Production.WorkOrder
                  WHERE DueDate > '2004-04-30'
                  AND  DATEDIFF(dd, '2004-04-30', DueDate) < 2