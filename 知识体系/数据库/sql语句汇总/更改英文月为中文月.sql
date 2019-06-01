USE AdventureWorksDW
--ΪDimtime����������������
ALTER TABLE Dimtime ADD ChineseMonthName NVARCHAR(50)
GO
--��Ӧ��Ӣ�ĵ������ƣ���Ϊ���ĵ�������
With ModifyTime(English,Chinese) AS
(
SELECT 'January',N'һ��'
UNION
SELECT 'February',N'����'
UNION
SELECT 'March',N'����'
UNION
SELECT 'April',N'����'
UNION
SELECT 'May',N'����'
UNION
SELECT 'June',N'����'
UNION
SELECT 'July',N'����'
UNION
SELECT 'August',N'����'
UNION
SELECT 'September',N'����'
UNION
SELECT 'October',N'ʮ��'
UNION
SELECT 'November',N'ʮһ��'
UNION
SELECT 'December',N'ʮ����'
)
--
--
UPDATE DimTime SET ChineseMonthName=Chinese
FROM DimTime e JOIN ModifyTime t ON e.EnglishMonthName=t.English
GO
