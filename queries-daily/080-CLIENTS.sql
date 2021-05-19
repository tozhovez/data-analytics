
-- number of clients
select '@YDAY' ReportDate, 'CLIENTS' DataId, count(*) Val 
from CLIENTS where date(CREATION_DATE)=date('@YDAY')
