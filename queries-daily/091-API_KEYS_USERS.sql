select '@YDAY' ReportDate, 'API_KEYS_USERS' DataId, count(distinct b.USER_ID) Val 
from API_KEYS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date(e.CREATION_DATE)=date('@YDAY')
