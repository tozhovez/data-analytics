select '@YDAY' ReportDate, 'CLIENTS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from CLIENTS where date(CREATION_DATE)=date('@YDAY')
