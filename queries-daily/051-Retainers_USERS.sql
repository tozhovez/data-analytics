select '@YDAY' ReportDate, 'RETAINERS_USERS' DataId, count(distinct b.USER_ID) Val 
from DOCUMENTS_RETAINERS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date(e.CREATION_DATE)=date('@YDAY')
