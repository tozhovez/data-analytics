
-- number of perm. payment
select '@YDAY' ReportDate, 'RECURRING_CHARGES' DataId, count(*) Val 
from RECURRING_CHARGES where date(CREATION_DATE)=date('@YDAY')
