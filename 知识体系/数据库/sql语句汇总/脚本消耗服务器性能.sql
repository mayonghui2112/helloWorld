select top 10 
text,
plan_generation_num as �üƻ������ڻ�����ʱ�����±���Ĵ���,
creation_time as ����ƻ���ʱ��,
last_execution_time as �ϴ�ִ�мƻ���ʱ��,
execution_count as �ƻ����ϴα���������ִ�еĴ���, 
total_worker_time as �˼ƻ��Ա�������ִ�����õ�CPUʱ������,
last_worker_time as�ϴ�ִ�мƻ����õ�CPUʱ��,
min_worker_time as �˼ƻ��ڵ���ִ���ڼ���ռ�õ���СCPUʱ��,
max_worker_time as �˼ƻ��ڵ���ִ���ڼ���ռ�õ����CPUʱ��,
total_physical_reads as �˼ƻ��Ա������ִ���ڼ���ִ�е������ȡ�ܴ���,
last_physical_reads as�ϴ�ִ�мƻ�ʱ��ִ�е������ȡ����,
min_physical_reads as �üƻ��ڵ���ִ���ڼ���ִ�е����������ȡ����,
max_physical_reads as �üƻ��ڵ���ִ���ڼ���ִ�е���������ȡ����,
total_elapsed_time as ��ɴ˼ƻ���ִ����ռ�õ���ʱ��,
last_elapsed_time as �����ɴ˼ƻ���ִ����ռ�õ�ʱ��,
min_elapsed_time as����һ����ɴ˼ƻ���ִ����ռ�õ����ʱ��,
max_elapsed_time as ����һ����ɴ˼ƻ���ִ����ռ�õ��ʱ��
from sys.dm_exec_query_stats a CROSS APPLY sys.dm_exec_sql_text(sql_handle) 
order by execution_count desc
 
