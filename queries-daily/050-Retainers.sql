
-- number of retainers 
select '@YDAY' ReportDate, 'RETAINERS' DataId, count(*) Val 
from DOCUMENTS_RETAINERS where date(CREATION_DATE)=date('@YDAY')
