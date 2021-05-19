select '@YDAY' ReportDate, 'CLIENTS_USERS' DataId, count(distinct b.USER_ID) Val 
from CLIENTS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date(e.CREATION_DATE)=date('@YDAY')
