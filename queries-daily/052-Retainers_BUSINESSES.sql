select '@YDAY' ReportDate, 'RETAINERS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from DOCUMENTS_RETAINERS where date(CREATION_DATE)=date('@YDAY')
