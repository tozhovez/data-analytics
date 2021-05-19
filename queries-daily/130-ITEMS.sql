-- number of items
select '@YDAY' ReportDate, 'ITEMS' DataId, count(*) Val 
from ITEMS where date(CREATION_DATE)=date('@YDAY')

UNION

select '@YDAY' ReportDate, 'ITEMS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from ITEMS where date(CREATION_DATE)=date('@YDAY')

UNION

select '@YDAY' ReportDate, 'ITEMS_USERS' DataId, count(distinct b.USER_ID) Val 
from ITEMS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date(e.CREATION_DATE)=date('@YDAY')
