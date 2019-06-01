SELECT 
    [Name] AS ��������, 
    [Path] AS ����·��,
	[Parameter] as �������,
    CASE 
        [Type] 
        WHEN 2 THEN N'����' 
        WHEN 6 THEN N'����ģ��' 
    END AS ����,
    CAST(
        CAST([content] AS VARBINARY(max)) AS XML
        ) AS ������
FROM ReportServer.dbo.[Catalog]
WHERE 
    [Type] IN (2,6)
ORDER BY 
    [Path], [Type], [Name]

select * FROM ReportServer.dbo.[Catalog]
