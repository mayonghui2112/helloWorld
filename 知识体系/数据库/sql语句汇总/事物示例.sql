select * from dbo.abc

--ɾ��ִ��
alter proc pabc
as
BEGIN TRAN
delete abc where a='CPS_WSRPPortletToFragmentUpgrade'
insert into abc select 'ANS_ANSHighLeveSpec','fefef',2
COMMIT

--ɾ����ִ��
alter proc pabc
as
BEGIN TRAN
delete abc where a='CPS_WSRPPortletToFragmentUpgrade'
if (@@Error<>0)
	ROLLBACK
else
begin
	insert into abc select 'ANS_ANSHighLeveSpec','fefef',2
	if (@@Error<>0)
		ROLLBACK
	else
		COMMIT
end

exec pabc