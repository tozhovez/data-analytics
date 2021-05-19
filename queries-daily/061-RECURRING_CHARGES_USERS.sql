select '@YDAY' ReportDate, 'RECURRING_CHARGES_USERS' DataId, count(distinct b.USER_ID) Val 
from RECURRING_CHARGES e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date(e.CREATION_DATE)=date('@YDAY')
