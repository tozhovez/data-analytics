-- number of docs created yesterday
 select '@TMD1' ReportDate, 'DOCS_CREATED' DataId, count(*) Val 
 from DOCUMENTS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
 and year=2020
-- count(distinct BUSINESS_TAX_ID) CDB,  count(distinct USER_GUID) CDU
union
 select '@TMD1' ReportDate, 'DOCS_CREATED_USERS' DataId, count(distinct USER_GUID) Val 
 from DOCUMENTS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
 and year=2020
 union
 select '@TMD1' ReportDate, 'DOCS_CREATED_BUSINESSES' DataId, count(distinct BUSINESS_TAX_ID) Val 
 from DOCUMENTS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
and year=2020
union
-- number of payment links
select '@TMD1' ReportDate, 'PAYMENT_LINKS' DataId, count(*) Val 
from PAYMENTS_LINKS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union

select '@TMD1' ReportDate, 'PAYMENT_LINKS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from PAYMENTS_LINKS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union
select '@TMD1' ReportDate, 'PAYMENT_LINKS_USERS' DataId, count(distinct b.USER_ID) Val 
from PAYMENTS_LINKS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date_format(e.CREATION_DATE,'%Y-%m')='@TMY'
 and e.CREATION_DATE>= date '@TMD1'

union
-- number of retainers 
select '@TMD1' ReportDate, 'RETAINERS' DataId, count(*) Val 
from DOCUMENTS_RETAINERS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union

select '@TMD1' ReportDate, 'RETAINERS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from DOCUMENTS_RETAINERS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union
select '@TMD1' ReportDate, 'RETAINERS_USERS' DataId, count(distinct b.USER_ID) Val 
from DOCUMENTS_RETAINERS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date_format(e.CREATION_DATE,'%Y-%m')='@TMY'
 and e.CREATION_DATE>= date '@TMD1'

union
-- number of perm. payment
select '@TMD1' ReportDate, 'RECURRING_CHARGES' DataId, count(*) Val 
from RECURRING_CHARGES where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union
select '@TMD1' ReportDate, 'RECURRING_CHARGES_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from RECURRING_CHARGES where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union
select '@TMD1' ReportDate, 'RECURRING_CHARGES_USERS' DataId, count(distinct b.USER_ID) Val 
from RECURRING_CHARGES e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date_format(e.CREATION_DATE,'%Y-%m')='@TMY'
 and e.CREATION_DATE>= date '@TMD1'

union
-- number of expenses
select '@TMD1' ReportDate, 'EXPENSES' DataId, count(*) Val 
from EXPENSES where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
  and description!='%חשבונית ירוקה%' 
  and description!='%רכישת מינוי%'
 
union
select '@TMD1' ReportDate, 'EXPENSES_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from EXPENSES where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
and description!='%חשבונית ירוקה%' 
  and description!='%רכישת מינוי%'
union
select '@TMD1' ReportDate, 'EXPENSES_USERS' DataId, count(distinct b.USER_ID) Val 
from EXPENSES e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date_format(e.CREATION_DATE,'%Y-%m')='@TMY'
 and e.CREATION_DATE>= date '@TMD1'
 and description!='%חשבונית ירוקה%' 
  and description!='%רכישת מינוי%'

union
-- number of clients
select '@TMD1' ReportDate, 'CLIENTS' DataId, count(*) Val 
from CLIENTS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union
select '@TMD1' ReportDate, 'CLIENTS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from CLIENTS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union
select '@TMD1' ReportDate, 'CLIENTS_USERS' DataId, count(distinct b.USER_ID) Val 
from CLIENTS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date_format(e.CREATION_DATE,'%Y-%m')='@TMY'
 and e.CREATION_DATE>= date '@TMD1'

union
-- number of API keys
select '@TMD1' ReportDate, 'API_KEYS' DataId, count(*) Val 
from API_KEYS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union
select '@TMD1' ReportDate, 'API_KEYS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from API_KEYS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
union
select '@TMD1' ReportDate, 'API_KEYS_USERS' DataId, count(distinct b.USER_ID) Val 
from API_KEYS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date_format(e.CREATION_DATE,'%Y-%m')='@TMY'
 and e.CREATION_DATE>= date '@TMD1'
union

-- number of items
select '@TMD1' ReportDate, 'ITEMS' DataId, count(*) Val 
from ITEMS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'
UNION

select '@TMD1' ReportDate, 'ITEMS_BUSINESSES' DataId, count(distinct BUSINESS_ID) Val 
from ITEMS where date_format(CREATION_DATE,'%Y-%m')='@TMY'
 and CREATION_DATE>= date '@TMD1'

UNION

select '@TMD1' ReportDate, 'ITEMS_USERS' DataId, count(distinct b.USER_ID) Val 
from ITEMS e join BUSINESSES b 
on e.BUSINESS_ID=b.ID
where date_format(e.CREATION_DATE,'%Y-%m')='@TMY'
 and e.CREATION_DATE>= date '@TMD1'
