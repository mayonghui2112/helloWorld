SET NOCOUNT ON
DECLARE @TblName  VARCHAR(100)
DECLARE @UpdateString NVARCHAR(1000)
DECLARE @SelectString NVARCHAR(1000)
DECLARE @COlName VARCHAR(100)
DECLARE @COUNT  INT
SET @TblName = 'member_property_bak'--ָ����Ҫ�޸ĵı���
--�����α�ȡ��ָ�����ڵ�����������VARCHAR,char,nVARCHAR���ֶ�����
DECLARE cur_ColName  CURSOR
FOR
SELECT col.name
FROM syscolumns AS col
inner join sysobjects  AS obj  ON col.ID = obj.ID 
INNER join systypes  AS typ  ON col.xtype = typ.xtype
WHERE obj.xtype ='U'
AND obj.name = @TblName
AND typ.name IN ('VARCHAR','CHAR','NVARCHAR','NCHAR')
FOR READ ONLY
--���α�
OPEN cur_ColName
FETCH NEXT FROM cur_ColName INTO @ColName
IF @@FETCH_STATUS<>0
BEGIN 
PRINT 'û�ж�Ӧ����ֶΣ�
'PRINT '��ȷ�ϵ�ǰ���ݿ�����' + @TblName + '��
' PRINT '��ñ�����VARCHAR��CHAR��NVARCHAR��NCHAR���͵��ֶΣ�
' GOTO LABCLOSE
END--ѭ���޸�
WHILE @@FETCH_STATUS=0
BEGIN 
--ƴ�޸��ַ��� 
--ȥ����ߵĲ��ɼ��ַ� 
SET @SelectString = 'SELECT @COU=COUNT(*)     
FROM ' + @TblName +'    
WHERE ASCII(LEFT(' + @ColName +',1))<32
AND '+ @ColName + ' IS NOT NULL' 
EXEC sp_executesql @SelectString,N'@COU INT OUTPUT',
@COUNT OUTPUT WHILE @COUNT>0 
BEGIN  
SET @UpdateString =   
' UPDATE ' + @TblName +   
' SET ' + @ColName + '=RIGHT(' + @ColName + ',LEN(' + @ColName + ')-1)    
WHERE ASCII(LEFT(' + @ColName + ',1))<32    
AND ' + @ColName + ' IS NOT NULL'  
EXEC sp_executesql @UpdateString  
EXEC sp_executesql @SelectString,N'@COU INT OUTPUT',@COUNT OUTPUT 
END 
--ȥ���ұߵĲ��ɼ��ַ� 
SET @SelectString = 'SELECT @COU=COUNT(*)     
FROM ' + @TblName +'    
WHERE ASCII(RIGHT(' + @ColName +',1))<32    
AND '+ @ColName + ' IS NOT NULL' 
EXEC sp_executesql @SelectString,N'@COU INT OUTPUT',
@COUNT OUTPUT WHILE @COUNT>0 
BEGIN  
SET @UpdateString =   ' UPDATE ' + @TblName +   ' SET ' 
+ @ColName + '=LEFT(' + @ColName + ',LEN(' + @ColName + ')-1)    
WHERE ASCII(RIGHT(' + @ColName + ',1))<32    
AND ' + @ColName + ' IS NOT NULL'  
EXEC SP_EXECUTESQL @UpdateString  
EXEC sp_executesql @SelectString,N'@COU INT OUTPUT',
@COUNT OUTPUT 
END 
PRINT 'column: ' + @ColName + '������ok' 
FETCH NEXT FROM cur_ColName INTO @ColName
END
--�رա��ͷ��α�
LABCLOSE: CLOSE cur_ColName  
DEALLOCATE cur_ColName