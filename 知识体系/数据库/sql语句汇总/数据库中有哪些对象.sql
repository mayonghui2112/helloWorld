--���ݿ�������Щ����
select name,xtype from sysobjects where type = 'U' or type='V' order by xtype,name

--����ϵͳ��sysobjects����Ķ������ݿ����,����type��ʾ���ֶ�������ͣ��������: 
--U = �û��� 
--S = ϵͳ�� 
--C = CHECK Լ�� 
--D = Ĭ��ֵ�� DEFAULT Լ�� 
--F = FOREIGN KEY Լ�� 
--L = ��־ 
--FN = �������� 
--IF = ��Ƕ���� 
--P = �洢���� 
--PK = PRIMARY KEY Լ���������� K�� 
--RF = ����ɸѡ�洢���� 
--TF = ���� 
--TR = ������ 
--UQ = UNIQUE Լ���������� K�� 
--V = ��ͼ 
--X = ��չ�洢���̼���صĶ�����Ϣ�� 
