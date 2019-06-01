truncate table MonSMSSubScribe
truncate table MonBankSubScribe
truncate table MonSSOSubScribe

--���ű��е�����
insert into dbo.MonSMSSubScribe
Select * From OpenRowset('MSOLAP', 'Data Source=.;Initial Catalog=TimeSMSBank;', 
'SELECT { [Measures].[���Ŷ�����], [Measures].[ʵʱ���Ŷ�����] } ON COLUMNS ,

{ { { [����Сʱ].[DimСʱ].[All].CHILDREN } * { [Dim����ƽ̨].[��Ʒ].&[PC����], [Dim����ƽ̨].[��Ʒ].&[������װ], [Dim����ƽ̨].[��Ʒ].&[����ɱ��] } } } ON ROWS  

FROM [TimeSMSBank]
')

--���п�
insert into dbo.MonBankSubScribe
Select * From OpenRowset('MSOLAP', 'Data Source=.;Initial Catalog=TimeSMSBank;', 
'SELECT { [Measures].[��������], [Measures].[ʵʱ��������] } ON COLUMNS ,
{ { { [����Сʱ].[DimСʱ].[All].CHILDREN } * { [Dim֧������].[֧�����Ͳ��].[֧��������].&[���п�], 
[Dim֧������].[֧�����Ͳ��].[֧������].&[ಸ�֧��]&[���п�], [Dim֧������].[֧�����Ͳ��].[֧������].&[����]&[���п�], 
[Dim֧������].[֧�����Ͳ��].[֧������].&[֧����]&[���п�], 
[Dim֧������].[֧�����Ͳ��].[֧������].&[֧��������]&[���п�] } } } ON ROWS  
FROM [TimeSMSBank]')

--SSO
insert into MonSSOSubScribe
Select * From OpenRowset('MSOLAP', 'Data Source=.;Initial Catalog=TimeSMSBank;', 'SELECT { [Measures].[ʵʱSSO������], [Measures].[ʵʱSSO������], [Measures].[SSO������], [Measures].[SSO������] } ON COLUMNS ,
{ { { [����Сʱ].[DimСʱ].[All].CHILDREN } * { [Dim֧��ҳ��].[Puidpsid].&[12_9], [Dim֧��ҳ��].[Puidpsid].&[12_11], [Dim֧��ҳ��].[Puidpsid].&[12_1], [Dim֧��ҳ��].[Puidpsid].&[10_5], [Dim֧��ҳ��].[Puidpsid].&[11_1] } } } ON ROWS  
FROM [TimeSMSBank]')

alter proc MonTime @tablename varchar(20)
as
begin
	declare @hour int,@a int,@b int,@Ta int,@Tb int,@type varchar(50),@Ba int,@Bb int,@result varchar(100)
	set @result=''
	if @tablename='MonSMSSubScribe'
	begin
		set @hour=DATEPART(hh,getdate())
		declare mycursor cursor for 
		select a.type,a.sms,a.smstime,b.sms BSms from MonSMSSubScribe a inner join (select type,Sms,SmsTime from MonSMSSubScribe where HourNum='7') b on a.Type=b.type 
		where a.HourNum=convert(varchar(2),@hour)
		open mycursor
		fetch  next from mycursor into @type,@a,@Ta,@Ba
			while (@@fetch_status=0)
			begin 	
				if (abs((@a-isnull(@Ta,0))/@a)>0.1) and (abs(@a-isnull(@Ta,0))>@Ba*0.1)
				begin
					set @result=@result+';���Ŷ�������'+convert(varchar(2),@hour)+'��,����������鿴�ʼ�'
					break
				end
				fetch  next from mycursor into @type,@a,@Ta,@Ba
			end
		close mycursor 
		deallocate mycursor
	end
	if @tablename='MonBankSubScribe'
	begin
		set @hour=DATEPART(hh,getdate())
		declare mycursor cursor for 
			select a.type,a.Num,a.NumTime,b.Num BNum from MonBankSubScribe a inner join 
			(select type,Num from MonBankSubScribe where HourNum='7') b on a.Type=b.type 
			where a.HourNum=convert(varchar(2),@hour)
		open mycursor
		fetch  next from mycursor into @type,@a,@Ta,@Ba
			while (@@fetch_status=0)
			begin 	
				if (abs((@a-isnull(@Ta,0))/@a)>0.1) and (abs(@a-isnull(@Ta,0))>@Ba*0.1)
				begin
					set @result=@result+';���п�����'+convert(varchar(2),@hour)+'��,����������鿴�ʼ�'
					break
				end
				fetch  next from mycursor into @type,@a,@Ta,@Ba
			end
		close mycursor 
		deallocate mycursor
	end
	if @tablename='MonSSOSubScribe'
	begin
		set @hour=DATEPART(hh,getdate())
		declare mycursor cursor for 
			select a.type,a.Input,a.[Order],a.InputTime,a.OrderTime,b.Input,b.[Order] from MonSSOSubScribe a inner join 
			(select type,Input,[Order] from MonSSOSubScribe where HourNum='7') b on a.Type=b.type 
			where a.HourNum=convert(varchar(2),@hour)
		open mycursor
		fetch  next from mycursor into @type,@a,@b,@Ta,@Tb,@Ba,@Bb
			while (@@fetch_status=0)
			begin 	
				if (abs((@a-isnull(@Ta,0))/@a)>0.1) and (abs(@a-isnull(@Ta,0))>@Ba*0.1)
				begin
					set @result=@result+';SSO������'+convert(varchar(2),@hour)+'��,����������鿴�ʼ�'
					break
				end
				if (abs((@b-isnull(@Tb,0))/@b)>0.1) and (abs(@b-isnull(@Tb,0))>@Bb*0.1)
				begin
					set @result=@result+';SSO������'+convert(varchar(2),@hour)+'��,����������鿴�ʼ�'
					break
				end
				fetch next from mycursor into @type,@a,@b,@Ta,@Tb,@Ba,@Bb
			end
		close mycursor 
		deallocate mycursor
	end
	select @result as num
end




exec MonTime 'MonSMSSubScribe'
