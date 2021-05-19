
-- non-new purchases, annual and monthly, by tier
-- create temporary table renewals as 
select '@YDAY' ReportDate, 

concat('renewals_',
    case when acs.PACKAGE_ID=10010 then 'Lite'
    when acs.PACKAGE_ID=10020 then 'Popular'
    when acs.PACKAGE_ID=10030 then 'Business'
    when acs.PACKAGE_ID=10040 then 'Prime'
    else 'Unknown' end 
,'_',
    case when acs.CYCLE_ID =1 then 'Annual'
    when acs.CYCLE_ID =2 then 'Monthly'
    when acs.CYCLE_ID =0 then 'Trial'
    else 'Unknown' end
) DataId, 
count(acs.ID) Val 

from ACCOUNT_SUBSCRIPTIONS acs
left join
(
	select 
		ID, USER_ID, m_CREATION_DATE from (
			select 
			ID,USER_ID, 
			rank() OVER (partition by USER_ID order by CREATION_DATE asc ) mRANK, CREATION_DATE m_CREATION_DATE
			-- rank?
			from ACCOUNT_SUBSCRIPTIONS
		) a where mRANK=1
) facs
on 
acs.ID=facs.ID
where date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY'
and facs.USER_ID is null -- to remove all first time purchases
and PACKAGE_ID>0
group by 1,2

