--�������� 
CREATE TABLE tb(ID char(3),PID char(3),Name nvarchar(10)) 
INSERT tb SELECT '001',NULL ,'ɽ��ʡ' 
UNION ALL SELECT '002','001','��̨��' 
UNION ALL SELECT '004','002','��Զ��' 
UNION ALL SELECT '003','001','�ൺ��' 
UNION ALL SELECT '005',NULL ,'�Ļ���' 
UNION ALL SELECT '006','005','��Զ��' 
UNION ALL SELECT '007','006','С����' 
GO 

--��ѯָ���ڵ㼰�������ӽڵ�ĺ��� 
CREATE FUNCTION f_Cid(@ID char(3)) 
RETURNS @t_Level TABLE(ID char(3),Level int) 
AS 
BEGIN 
    DECLARE @Level int 
    SET @Level=1 
    INSERT @t_Level SELECT @ID,@Level 
    WHILE @@ROWCOUNT>0 
    BEGIN 
        SET @Level=@Level+1 
        INSERT @t_Level SELECT a.ID,@Level 
        FROM tb a,@t_Level b 
        WHERE a.PID=b.ID 
            AND b.Level=@Level-1 
    END 
    RETURN 
END 
GO 

--���ú�����ѯ002���������ӽڵ� 
SELECT a.* 
FROM tb a,f_Cid('002') b 
WHERE a.ID=b.ID 
/*--��� 
ID  PID  Name      
------ ------- ---------- 
002  001  ��̨�� 
004  002  ��Զ�� 
--*/ 
