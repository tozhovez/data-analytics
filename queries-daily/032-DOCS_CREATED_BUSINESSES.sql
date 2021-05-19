 select '@YDAY' ReportDate, 'DOCS_CREATED_BUSINESSES' DataId, count(distinct BUSINESS_TAX_ID) Val 
 from DOCUMENTS where 
 year(date '@YDAY')=year and month(date '@YDAY')=month 
and date(CREATION_DATE)=date('@YDAY')