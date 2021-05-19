select '@YDAY' ReportDate, 'RECURRING_CHARGES_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from RECURRING_CHARGES where date(CREATION_DATE)=date('@YDAY')
