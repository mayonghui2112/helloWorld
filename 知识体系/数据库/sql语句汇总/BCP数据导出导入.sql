--ʹ��BCP���ߵ������ݣ���������
EXEC master..xp_cmdshell "BCP BJSJK.dbo.DataSynLog out c:\currency1.txt -T -w"

--  ʹ��SQL��ѯ�����ݵ���  F�ӵ�10�п�ʼ   L ����13�н���
EXEC master..xp_cmdshell 'BCP "SELECT TOP 20 * FROM AdventureWorks.sales.currency" queryout c:\currency2.txt -F 10 -L 13 -c -T'

EXEC master..xp_cmdshell 'BCP AdventureWorks.sales.currency format nul -f c:\currency_format2.fmt -x -c -T' 

-- ���ض����ַ���Ϊ�зָ���зָ�
EXEC master..xp_cmdshell "BCP AdventureWorks.sales.currency out c:\currency1.txt -c -T -t , -r ; "

--����
EXEC master..xp_cmdshell 'BCP BJSJK.dbo.DataSynLog in c:\currency1.txt -w -T' 

/*
-f format_file
format_file��ʾ��ʽ�ļ��������ѡ�������������Ķ��������ʹ�õ���in��out��format_file��ʾ�Ѿ����ڵĸ�ʽ�ļ������ʹ�õ���format���ʾ��Ҫ���ɵĸ�ʽ�ļ��� 

-x 
���ѡ��Ҫ��-f format_file���ʹ�ã��Ա�����xml��ʽ�ĸ�ʽ�ļ���

-F first_row 
ָ���ӱ����������һ�е�������ӱ������ļ�����һ�е��롣

-L last_row 
ָ����������Ҫ������һ�н�������ӱ������ļ�������ʱ��������һ�н�����

-c 
ʹ��char������Ϊ�洢���ͣ�û��ǰ׺����"\t"��Ϊ�ֶηָ������"\n"��Ϊ�зָ���� 

-w
��-c���ƣ�ֻ�ǵ�ʹ��Unicode�ַ�����������ʱʹ�ã�����nchar��Ϊ�洢���͡�

-t field_term 
ָ���ַ��ָ����Ĭ����"\t"��

-r row_term 
ָ���зָ����Ĭ����"\n"��

-S server_name[ \instance_name] 
ָ��Ҫ���ӵ�SQL Server��������ʵ�������δָ����ѡ�BCP���ӱ�����SQL ServerĬ��ʵ�������Ҫ����ĳ̨�����ϵ�Ĭ��ʵ����ֻ��Ҫָ�����������ɡ�

-U login_id 
ָ������SQL Sever���û�����

-P password 
ָ������SQL Server���û������롣 

-T
ָ��BCPʹ���������ӵ�¼SQL Server�����δָ��-T������ָ��-U��-P�� 

-k
ָ������ʹ��nullֵ���룬���������е�Ĭ��ֵ��


*/

bcp "select * from PartitionPaySys.dbo.AssDubaUserInfo where account_id>=60000000 and account_id<70000000" queryout E:\sug\FTP_AssDubaUserInfo\dayDuBaUserInfo5.txt -c -T

bcp "select * from PartitionPaySys.dbo.AssDubaUserInfo where account_id>=70000000 and account_id<70000000" queryout E:\sug\FTP_AssDubaUserInfo\dayDuBaUserInfo6.txt -c -T

BCP CustomerServiceCenter.dbo.CSCustomersInfo in D:\zwm\ftp\dayDuBaUserInfo2.txt -c -T

bcp "select account_id,passport,expiretime,maxenddate from UserInfo.dbo.CSCustomersInfo" queryout c:\1k.txt -c -T -F 1 -L100000 -b 5000 & bcp "select account_id,passport,expiretime,maxenddate from UserInfo.dbo.CSCustomersInfo" queryout c:\2k.txt -c -T -F 100000 -L 200000 -b 5000
