select ROWID, FUNCTION_NAME, [DESCRIPTION], PDSNUM, CUSTPARTNUM, CREATEBY, CREATEDATE, CREATETIME 
from TT_EVENT_LOG 
where PDSNUM = @PDSNO