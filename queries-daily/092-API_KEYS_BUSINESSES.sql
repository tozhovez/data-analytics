select '@YDAY' ReportDate, 'API_KEYS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from API_KEYS where date(CREATION_DATE)=date('@YDAY')
