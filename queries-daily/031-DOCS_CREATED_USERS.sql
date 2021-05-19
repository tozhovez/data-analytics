 select '@YDAY 'ReportDate, 'DOCS_CREATED_USERS' DataId, count(distinct USER_GUID) Val 
 from DOCUMENTS where 
 year(date '@YDAY')=year and month(date '@YDAY')=month 
and date(CREATION_DATE)=date('@YDAY')
