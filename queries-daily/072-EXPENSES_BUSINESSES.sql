select '@YDAY' ReportDate, 'EXPENSES_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from EXPENSES where date(CREATION_DATE)=date('@YDAY')
 and description!='%חשבונית ירוקה%'
 and description!= '%רכישת מינוי%'