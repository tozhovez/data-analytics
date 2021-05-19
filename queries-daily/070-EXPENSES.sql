
-- number of expenses
select '@YDAY' ReportDate, 'EXPENSES' DataId, count(*) Val 
from EXPENSES where date(CREATION_DATE)=date('@YDAY')
 and description!='%חשבונית ירוקה%'
 and description!= '%רכישת מינוי%'
