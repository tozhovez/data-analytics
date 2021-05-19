select '@YDAY' ReportDate, 'PAYMENT_LINKS_USERS' DataId, count(distinct b.USER_ID) Val 
from PAYMENTS_LINKS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date(e.CREATION_DATE)=date('@YDAY')
