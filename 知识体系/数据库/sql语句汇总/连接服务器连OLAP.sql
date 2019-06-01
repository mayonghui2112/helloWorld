EXEC sp_addlinkedserver 
       @server='OLAP',
       @srvproduct='', 
       @provider='MSOLAP',
       @datasrc='219.232.254.21', -- This is the name of the Analysis Services server.
       @catalog='SMSBank' -- This is the Analysis Services database against which you query.


Select * From OpenQuery(OLAP, '
SELECT NON EMPTY { { { [Dim��Ʒ].[��Ʒ���].[��Ʒ����].&[PC����], [Dim��Ʒ].[��Ʒ���].[��Ʒ����].&[������װ], [Dim��Ʒ].[��Ʒ���].[��Ʒ����].&[����ɱ��] } * { [Measures].[������] } } } ON COLUMNS ,

NON EMPTY { [Dim����].[��-����-��-���ڲ��].[����].&[2009���4����]&[2009��] } ON ROWS  

FROM [SMSBank]')

Select * From OpenRowset('MSOLAP', 'Data Source=.;Initial Catalog=SMSBank;', 'SELECT NON EMPTY { { { [Dim��Ʒ].[��Ʒ���].[��Ʒ����].&[PC����], [Dim��Ʒ].[��Ʒ���].[��Ʒ����].&[������װ], [Dim��Ʒ].[��Ʒ���].[��Ʒ����].&[����ɱ��] } * { [Measures].[������] } } } ON COLUMNS ,

NON EMPTY { [Dim����].[��-����-��-���ڲ��].[����].&[2009���4����]&[2009��] } ON ROWS  

FROM [SMSBank]')