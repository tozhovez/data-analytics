
-- number of API keys
select '@YDAY' ReportDate, 'API_KEYS' DataId, count(*) Val 
from API_KEYS where date(CREATION_DATE)=date('@YDAY');
