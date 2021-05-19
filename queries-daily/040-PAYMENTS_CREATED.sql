
-- number of payment links
select '@YDAY' ReportDate, 'PAYMENT_LINKS' DataId, count(*) Val 
from PAYMENTS_LINKS where date(CREATION_DATE) =date('@YDAY')
