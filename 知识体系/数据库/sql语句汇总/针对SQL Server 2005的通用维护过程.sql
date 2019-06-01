SET NOCOUNT ON;
DECLARE @objectid int;
DECLARE @indexid int;
DECLARE @partitioncount bigint;
DECLARE @schemaname sysname;
DECLARE @objectname sysname;
DECLARE @indexname sysname;
DECLARE @partitionnum bigint;
DECLARE @partitions bigint;
DECLARE @frag float;
DECLARE @command varchar(8000);

IF EXISTS (SELECT name FROM sys.objects WHERE name = 'work_to_do')
DROP TABLE work_to_do;
SELECT 
object_id AS objectid,
index_id AS indexid,
partition_number AS partitionnum,
avg_fragmentation_in_percent AS frag
INTO work_to_do
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, 'LIMITED')
WHERE avg_fragmentation_in_percent > 10.0 AND index_id > 0;
DECLARE partitions CURSOR FOR SELECT * FROM work_to_do;
OPEN partitions;
FETCH NEXT FROM partitions 
INTO @objectid, @indexid, @partitionnum, @frag;
WHILE @@FETCH_STATUS = 0 
	BEGIN;
		SELECT @objectname = o.name, @schemaname = s.name
		FROM sys.objects AS o 
		JOIN sys.schemas as s ON s.schema_id = o.schema_id 
		WHERE o.object_id = @objectid;
		
		SELECT @indexname = name 
		FROM sys.indexes 
		WHERE object_id = @objectid AND index_id = @indexid;
		
		SELECT @partitioncount = count (*)
		FROM sys.partitions 
		WHERE object_id = @objectid AND index_id = @indexid;
IF @frag < 30.0 and @frag>5 
BEGIN;
	SELECT @command = 'ALTER INDEX ' + @indexname + ' ON ' + @schemaname + '.' + @objectname + ' REORGANIZE';
	IF @partitioncount > 1
		SELECT @command = @command + ' PARTITION=' + CONVERT (CHAR, @partitionnum);
		EXEC (@command);
	END;
	IF @frag >= 30.0
	BEGIN;
		SELECT @command = 'ALTER INDEX ' + @indexname +' ON ' + @schemaname + '.' + @objectname + ' REBUILD';
		IF @partitioncount > 1
		SELECT @command = @command + ' PARTITION=' + CONVERT (CHAR, @partitionnum);	
		EXEC (@command);
	END;
PRINT 'Executed ' + @command;	
	FETCH NEXT FROM partitions INTO @objectid, @indexid, @partitionnum, @frag;
END;
CLOSE partitions;
DEALLOCATE partitions;
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'work_to_do')
	DROP TABLE work_to_do;
