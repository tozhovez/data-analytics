
-- number of docs created yesterday
 select '@YDAY' ReportDate, 'DOCS_CREATED' DataId, count(*) Val 
 from DOCUMENTS where 
 year(date '@YDAY')=year and month(date '@YDAY')=month 
and date(CREATION_DATE)=date('@YDAY')
