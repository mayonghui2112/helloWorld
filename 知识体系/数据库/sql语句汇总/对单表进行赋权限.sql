USE [master]
GO
CREATE LOGIN [zhuhai] WITH PASSWORD=N'zhuhai', DEFAULT_DATABASE=[OperatorsV5], 
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [OperatorsV5]
GO
CREATE USER [zhuhai] FOR LOGIN [zhuhai]
GO
use [OperatorsV5]
GO
GRANT Insert ON DimStatisticalPointCode TO [dingyaman] WITH GRANT OPTION 
GO
use [OperatorsV5]
GO
GRANT Update ON [FactInfocInstall] TO [zhuhai] WITH GRANT OPTION 
GO
use [OperatorsV5]
GO
GRANT Select ON [FactInfocInstall] TO [zhuhai] WITH GRANT OPTION 
GO
use [OperatorsV5]
GO
GRANT Delete ON [FactInfocInstall] TO [zhuhai] WITH GRANT OPTION 
GO

GRANT create table to [zhuhai]
GRANT create view to [zhuhai]

--Ϊ�����û����� ����Ȩ��ʱ������Ҫ�ȴ����ܹ�