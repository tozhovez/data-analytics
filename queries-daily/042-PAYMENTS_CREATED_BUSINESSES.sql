select '@YDAY' ReportDate, 'PAYMENT_LINKS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from PAYMENTS_LINKS where date(CREATION_DATE)=date('@YDAY')
