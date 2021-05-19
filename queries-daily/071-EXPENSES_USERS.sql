select '@YDAY' ReportDate, 'EXPENSES_USERS' DataId, count(distinct b.USER_ID) Val 
from EXPENSES e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date(e.CREATION_DATE)=date('@YDAY')
  and description!='%חשבונית ירוקה%'
 and description!= '%רכישת מינוי%'