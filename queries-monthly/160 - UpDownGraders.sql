

with 

prelast as (
select acs.USER_ID, max(acs.CREATION_DATE) pre_last
-- select * 
FROM
 ACCOUNT_SUBSCRIPTIONS acs
 left join (select USER_ID, MAX(CREATION_DATE) CREATION_DATE FROM ACCOUNT_SUBSCRIPTIONS acs where PACKAGE_ID in (10010,10020,10030,10040) and date(CREATION_DATE)<=date_add('day', -1, date_add('month', 1,date '@TMD1')) group by 1 ) lst
 on acs.USER_ID=lst.USER_ID and acs.CREATION_DATE=lst.CREATION_DATE
  where
acs.PACKAGE_ID in (10010,10020,10030,10040)
and lst.USER_ID is null
and date(acs.CREATION_DATE)<=date_add('day', -1, date_add('month', 1,date '@TMD1'))
group by 1
),

acs as
(select USER_ID, CREATION_DATE,CANCELLATION_DATE,EXPIRATION_DATE,PACKAGE_ID,CYCLE_ID
-- select * 
FROM
 ACCOUNT_SUBSCRIPTIONS acs 
  where
PACKAGE_ID in (10010,10020,10030,10040)

),
last_purchase as 
(
select acs.USER_ID, acs.CREATION_DATE, CANCELLATION_DATE, EXPIRATION_DATE,PACKAGE_ID,CYCLE_ID
-- select * 
FROM
 ACCOUNT_SUBSCRIPTIONS acs
 join (select USER_ID, MAX(CREATION_DATE) CREATION_DATE FROM ACCOUNT_SUBSCRIPTIONS acs where PACKAGE_ID in (10010,10020,10030,10040) and date(CREATION_DATE)<=date_add('day', -1, date_add('month', 1,date '@TMD1')) group by 1 ) lst
 on acs.USER_ID=lst.USER_ID and acs.CREATION_DATE=lst.CREATION_DATE
  where
acs.PACKAGE_ID in (10010,10020,10030,10040)
and 
date(acs.CREATION_DATE)>=date '@TMD1'
and 
DATE_FORMAT(acs.CREATION_DATE,'%Y-%m')='@TMY'
),

data as (
select '@TMD1' as ReportDate, cnt as Val,concat(SRC_CYC,'_',SRC_PKG,'_TO_',DST_CYC,'_',DST_PKG) DataId from (

select 
case lc.CYCLE_ID when 1 then 'ANNUAL' when 2 then 'MONTHLY' end as SRC_CYC,
case rc.CYCLE_ID when 1 then 'ANNUAL' when 2 then 'MONTHLY' end as DST_CYC,
case lc.PACKAGE_ID when 10010 then 'LIGHT' when 10020 then 'POPULAR' when 10030 then 'BUSINESS' when 10040 then 'PRIME' end as SRC_PKG, 
case rc.PACKAGE_ID when 10010 then 'LIGHT' when 10020 then 'POPULAR' when 10030 then 'BUSINESS' when 10040 then 'PRIME' end as DST_PKG, 
count(distinct rc.USER_ID) as CNT
-- lc.*,rc.* 

from 
acs lc 
join prelast pl
on lc.USER_ID=pl.USER_ID
and lc.CREATION_DATE=pl.pre_last
join last_purchase rc
on lc.USER_ID=rc.USER_ID

where
date(lc.CREATION_DATE)<date(rc.CREATION_DATE)
and
rc.CREATION_DATE>=date '@TMD1'
and 
DATE_FORMAT(rc.CREATION_DATE,'%Y-%m')='@TMY'
and
(lc.CANCELLATION_DATE<=rc.CREATION_DATE
or 
lc.EXPIRATION_DATE<=rc.CREATION_DATE
) 

group by 1,2,3,4
) updown)
-- select * from data

select ReportDate,MAX(case when DataId='ANNUAL_LIGHT_TO_ANNUAL_LIGHT' then Val else 0 end) as Val,'ANNUAL_LIGHT_TO_ANNUAL_LIGHT' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_LIGHT_TO_ANNUAL_POPULAR' then Val else 0 end) as Val,'ANNUAL_LIGHT_TO_ANNUAL_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_LIGHT_TO_ANNUAL_BUSINESS' then Val else 0 end) as Val,'ANNUAL_LIGHT_TO_ANNUAL_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_LIGHT_TO_ANNUAL_PRIME' then Val else 0 end) as Val,'ANNUAL_LIGHT_TO_ANNUAL_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_LIGHT_TO_MONTHLY_POPULAR' then Val else 0 end) as Val,'ANNUAL_LIGHT_TO_MONTHLY_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_LIGHT_TO_MONTHLY_BUSINESS' then Val else 0 end) as Val,'ANNUAL_LIGHT_TO_MONTHLY_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_LIGHT_TO_MONTHLY_PRIME' then Val else 0 end) as Val,'ANNUAL_LIGHT_TO_MONTHLY_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_POPULAR_TO_ANNUAL_LIGHT' then Val else 0 end) as Val,'ANNUAL_POPULAR_TO_ANNUAL_LIGHT' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_POPULAR_TO_ANNUAL_POPULAR' then Val else 0 end) as Val,'ANNUAL_POPULAR_TO_ANNUAL_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_POPULAR_TO_ANNUAL_BUSINESS' then Val else 0 end) as Val,'ANNUAL_POPULAR_TO_ANNUAL_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_POPULAR_TO_ANNUAL_PRIME' then Val else 0 end) as Val,'ANNUAL_POPULAR_TO_ANNUAL_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_POPULAR_TO_MONTHLY_POPULAR' then Val else 0 end) as Val,'ANNUAL_POPULAR_TO_MONTHLY_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_POPULAR_TO_MONTHLY_BUSINESS' then Val else 0 end) as Val,'ANNUAL_POPULAR_TO_MONTHLY_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_POPULAR_TO_MONTHLY_PRIME' then Val else 0 end) as Val,'ANNUAL_POPULAR_TO_MONTHLY_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_BUSINESS_TO_ANNUAL_LIGHT' then Val else 0 end) as Val,'ANNUAL_BUSINESS_TO_ANNUAL_LIGHT' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_BUSINESS_TO_ANNUAL_POPULAR' then Val else 0 end) as Val,'ANNUAL_BUSINESS_TO_ANNUAL_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_BUSINESS_TO_ANNUAL_BUSINESS' then Val else 0 end) as Val,'ANNUAL_BUSINESS_TO_ANNUAL_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_BUSINESS_TO_ANNUAL_PRIME' then Val else 0 end) as Val,'ANNUAL_BUSINESS_TO_ANNUAL_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_BUSINESS_TO_MONTHLY_POPULAR' then Val else 0 end) as Val,'ANNUAL_BUSINESS_TO_MONTHLY_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_BUSINESS_TO_MONTHLY_BUSINESS' then Val else 0 end) as Val,'ANNUAL_BUSINESS_TO_MONTHLY_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_BUSINESS_TO_MONTHLY_PRIME' then Val else 0 end) as Val,'ANNUAL_BUSINESS_TO_MONTHLY_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_PRIME_TO_ANNUAL_LIGHT' then Val else 0 end) as Val,'ANNUAL_PRIME_TO_ANNUAL_LIGHT' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_PRIME_TO_ANNUAL_POPULAR' then Val else 0 end) as Val,'ANNUAL_PRIME_TO_ANNUAL_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_PRIME_TO_ANNUAL_BUSINESS' then Val else 0 end) as Val,'ANNUAL_PRIME_TO_ANNUAL_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_PRIME_TO_ANNUAL_PRIME' then Val else 0 end) as Val,'ANNUAL_PRIME_TO_ANNUAL_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_PRIME_TO_MONTHLY_POPULAR' then Val else 0 end) as Val,'ANNUAL_PRIME_TO_MONTHLY_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_PRIME_TO_MONTHLY_BUSINESS' then Val else 0 end) as Val,'ANNUAL_PRIME_TO_MONTHLY_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='ANNUAL_PRIME_TO_MONTHLY_PRIME' then Val else 0 end) as Val,'ANNUAL_PRIME_TO_MONTHLY_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_POPULAR_TO_ANNUAL_LIGHT' then Val else 0 end) as Val,'MONTHLY_POPULAR_TO_ANNUAL_LIGHT' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_POPULAR_TO_ANNUAL_POPULAR' then Val else 0 end) as Val,'MONTHLY_POPULAR_TO_ANNUAL_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_POPULAR_TO_ANNUAL_BUSINESS' then Val else 0 end) as Val,'MONTHLY_POPULAR_TO_ANNUAL_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_POPULAR_TO_ANNUAL_PRIME' then Val else 0 end) as Val,'MONTHLY_POPULAR_TO_ANNUAL_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_POPULAR_TO_MONTHLY_POPULAR' then Val else 0 end) as Val,'MONTHLY_POPULAR_TO_MONTHLY_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_POPULAR_TO_MONTHLY_BUSINESS' then Val else 0 end) as Val,'MONTHLY_POPULAR_TO_MONTHLY_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_POPULAR_TO_MONTHLY_PRIME' then Val else 0 end) as Val,'MONTHLY_POPULAR_TO_MONTHLY_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_BUSINESS_TO_ANNUAL_LIGHT' then Val else 0 end) as Val,'MONTHLY_BUSINESS_TO_ANNUAL_LIGHT' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_BUSINESS_TO_ANNUAL_POPULAR' then Val else 0 end) as Val,'MONTHLY_BUSINESS_TO_ANNUAL_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_BUSINESS_TO_ANNUAL_BUSINESS' then Val else 0 end) as Val,'MONTHLY_BUSINESS_TO_ANNUAL_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_BUSINESS_TO_ANNUAL_PRIME' then Val else 0 end) as Val,'MONTHLY_BUSINESS_TO_ANNUAL_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_BUSINESS_TO_MONTHLY_POPULAR' then Val else 0 end) as Val,'MONTHLY_BUSINESS_TO_MONTHLY_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_BUSINESS_TO_MONTHLY_BUSINESS' then Val else 0 end) as Val,'MONTHLY_BUSINESS_TO_MONTHLY_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_BUSINESS_TO_MONTHLY_PRIME' then Val else 0 end) as Val,'MONTHLY_BUSINESS_TO_MONTHLY_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_PRIME_TO_ANNUAL_LIGHT' then Val else 0 end) as Val,'MONTHLY_PRIME_TO_ANNUAL_LIGHT' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_PRIME_TO_ANNUAL_POPULAR' then Val else 0 end) as Val,'MONTHLY_PRIME_TO_ANNUAL_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_PRIME_TO_ANNUAL_BUSINESS' then Val else 0 end) as Val,'MONTHLY_PRIME_TO_ANNUAL_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_PRIME_TO_ANNUAL_PRIME' then Val else 0 end) as Val,'MONTHLY_PRIME_TO_ANNUAL_PRIME' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_PRIME_TO_MONTHLY_POPULAR' then Val else 0 end) as Val,'MONTHLY_PRIME_TO_MONTHLY_POPULAR' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_PRIME_TO_MONTHLY_BUSINESS' then Val else 0 end) as Val,'MONTHLY_PRIME_TO_MONTHLY_BUSINESS' as DataId from data group by 1,3 union
select ReportDate, 	MAX(case when DataId='MONTHLY_PRIME_TO_MONTHLY_PRIME' then Val else 0 end) as Val,'MONTHLY_PRIME_TO_MONTHLY_PRIME' as DataId from data group by 1,3 
