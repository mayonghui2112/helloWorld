--����   
    
  --��������   
  create   table   ��(ID   int,�Ƿ�Ϊ����   char(1),������   varchar(10),�ϼ�ID   int)   
  insert   ��   select   1   ,'y','����0'   ,1   
  union   all   select   31,'y','����1'   ,1   
  union   all   select   32,'n','����'   ,31   
  union   all   select   33,'n','���'   ,31   
  union   all   select   34,'y','����2',31   
  union   all   select   35,'n','����'   ,34   
  union   all   select   35,'y','����3',34   
  union   all   select   36,'n','С��'   ,35   
  go   
    
  --������ѯ����   
  create   function   f_id(   
  @id   int --Ҫ��ѯ��id   
  )returns   @re   table(id   int,level   int)   
  as   
  begin   
  declare   @l   int   
  set   @l=0   
  insert   @re   select   id,@l   
  from   ��     
  where   �ϼ�id=@id   
  while   @@rowcount>0   
  begin   
  set   @l=@l+1   
  insert   @re   select   a.id,@l   
  from   ��   a   join   @re   b   on   a.�ϼ�id=b.id   and   b.level=@l-1   
  end   
  return   
  end   
  go   
    
  --���ú������в�ѯ   
  select   a.*   from   ��   a   join   f_id(35)   b   on   a.id=b.id   
  go   
    
  --ɾ������   
  drop   table   ��   
  drop   function   f_id   
    
  /*--���Խ��   
    
  ID                     �Ƿ�Ϊ����   ������                 �ϼ�ID                   
  -----------   -----   ----------   -----------     
  36                     n           С��                   35   
    
  ����Ӱ�������Ϊ   1   �У�   
  --*/