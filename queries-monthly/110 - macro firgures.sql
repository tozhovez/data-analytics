
select '@TMD1' ReportDate, count(*) Val, 'ALL_ACTIVE_PAYERS' DataId
from ACCOUNT_SUBSCRIPTIONS
where date(CREATION_DATE)<=date_add('day', -1, date_add('month', 1, date '@TMD1')) 
and PACKAGE_ID>0
and  
	( 
	EXPIRATION_DATE is null
	or 
	date(EXPIRATION_DATE)>date_add('day', -1, date_add('month', 1, date '@TMD1'))
	) 
and 
	(
	CANCELLATION_DATE is null
	or 
	date(CANCELLATION_DATE)>date_add('day', -1, date_add('month', 1, date '@TMD1'))
    )
union
-- 1 month ago date_add('month',-1, date '@TMD1') 
select '@TMD1' ReportDate, count(*) Val, 'ALL_ACTIVE_PAYERS_LAST_MO' DataId
from ACCOUNT_SUBSCRIPTIONS
where date(CREATION_DATE)<date '@TMD1'
and PACKAGE_ID>0
and  
	( 
	EXPIRATION_DATE is null
	or 
	date(EXPIRATION_DATE)>=date '@TMD1'
	) 
and 
	(
	CANCELLATION_DATE is null
	or 
	date(CANCELLATION_DATE)>= date '@TMD1'
    )

union
-- 1 month ago date_add('month',-1, date '@TMD1') 
select '@TMD1' ReportDate, count(*) Val, 'ALL_ACTIVE_PAYERS_LAST_YR' DataId
from ACCOUNT_SUBSCRIPTIONS
where date(CREATION_DATE)<date_add('month',-11,date '@TMD1') 
and PACKAGE_ID>0
and  
	( 
	EXPIRATION_DATE is null
	or 
	date(EXPIRATION_DATE)>=date_add('month',-11,date '@TMD1')
	) 
and 
	(
	CANCELLATION_DATE is null
	or 
	date(CANCELLATION_DATE)>=date_add('month',-11,date '@TMD1')
    )

-- ------- Trials
union
select '@TMD1' ReportDate, count(*) Val, 'ALL_ACTIVE_TRIALS' DataId
from ACCOUNT_SUBSCRIPTIONS
where date(CREATION_DATE)<=date_add('day', -1, date_add('month', 1, date '@TMD1')) 
and PACKAGE_ID=0
and  
	( 
	EXPIRATION_DATE is null
	or 
	date(EXPIRATION_DATE)> date '@TMD1'
	) 
and 
	(
	CANCELLATION_DATE is null
	or 
	date(CANCELLATION_DATE)> date '@TMD1'
    )
union
-- 1 month ago date_add('month',-1, date '@TMD1') 
select '@TMD1' ReportDate, count(*) Val, 'ALL_ACTIVE_TRIALS_LAST_MO' DataId
from ACCOUNT_SUBSCRIPTIONS
where date(CREATION_DATE)< date '@TMD1'
and PACKAGE_ID=0
and  
	( 
	EXPIRATION_DATE is null
	or 
	date(EXPIRATION_DATE)>=date_add('month',-1, date '@TMD1')
	) 
and 
	(
	CANCELLATION_DATE is null
	or 
	date(CANCELLATION_DATE)>=date_add('month',-1, date '@TMD1')
    )

union
-- 1 month ago date_add('month',-1, date '@TMD1') 
select '@TMD1' ReportDate, count(*) Val, 'ALL_ACTIVE_TRIALS_LAST_YR' DataId
from ACCOUNT_SUBSCRIPTIONS
where date(CREATION_DATE)<date_add('month',-11,date '@TMD1') 
and PACKAGE_ID=0
and  
	( 
	EXPIRATION_DATE is null
	or 
	date(EXPIRATION_DATE)>=date_add('month',-12,date '@TMD1')
	) 
and 
	(
	CANCELLATION_DATE is null
	or 
	date(CANCELLATION_DATE)>=date_add('month',-12,date '@TMD1')
    )

union
select '@TMD1' ReportDate, count(*) Val, 'TRIALS_CREATED_TM' DataId
from ACCOUNT_SUBSCRIPTIONS
where date(CREATION_DATE)<=date(date_add('day', -1, date_add('month', 1, date '@TMD1')))
and PACKAGE_ID=0
and date(CREATION_DATE)>= date '@TMD1'
union
select '@TMD1' ReportDate, count(*) Val, 'TRIALS_CREATED_LM' DataId
from ACCOUNT_SUBSCRIPTIONS
where date(CREATION_DATE)< date '@TMD1'
and PACKAGE_ID=0
and date(CREATION_DATE)>=date(date_add('month',-1, date '@TMD1'))
union
select '@TMD1' ReportDate, count(*) Val, 'TRIALS_CREATED_LAST_YR' DataId
from ACCOUNT_SUBSCRIPTIONS
where date(CREATION_DATE)<date(date_add('month',-11,date '@TMD1'))
and PACKAGE_ID=0
and date(CREATION_DATE)>=date(date_add('month',-12,date '@TMD1'))




union

-- trials
-- plugins 
select '@TMD1' ReportDate, count(*) Val, 'ALL_ACTIVE_PLUGINS' DataId
from PLUGINS
where ACTIVATION_DATE<=date_add('day', -1, date_add('month', 1, date '@TMD1')) 
-- and ACTIVATION_DATE>= '@TMD1' 
and  
	( 
	REMOVAL_DATE is null
	or 
	date(REMOVAL_DATE)>date_add('day', -1, date_add('month', 1, date '@TMD1'))
	) 

union

select '@TMD1' ReportDate, count(*) Val, 'ALL_ACTIVE_PLUGINS_LAST_MNTH' DataId
from PLUGINS
where ACTIVATION_DATE<= date '@TMD1'
-- and ACTIVATION_DATE>= '@TMD1' 
and  
	( 
	REMOVAL_DATE is null
	or 
	date(REMOVAL_DATE)> date '@TMD1'
	) 
union

select '@TMD1' ReportDate, count(*) Val, 'ALL_ACTIVE_PLUGINS_LAST_YR' DataId
from PLUGINS
where ACTIVATION_DATE<=date_add('month',-11,date '@TMD1')
-- and ACTIVATION_DATE>= '@TMD1' 
and  
	( 
	REMOVAL_DATE is null
	or 
	date(REMOVAL_DATE)>date_add('month',-11,date '@TMD1')
	) 
union
-- plugins clearance
select '@TMD1' ReportDate, count(distinct ID) Val, 'ALL_ACTIVE_PLUGINS_CLR' DataId
from PLUGINS
where ACTIVATION_DATE<=date_add('day', -1, date_add('month', 1, date '@TMD1')) 
-- and ACTIVATION_DATE>= '@TMD1' 
and  
	( 
	REMOVAL_DATE is null
	or 
	date(REMOVAL_DATE)>date_add('day', -1, date_add('month', 1, date '@TMD1'))
	) 
and TYPE in (12100,12120,12130,12170) 
union

select '@TMD1' ReportDate, count(distinct ID) Val, 'ALL_ACTIVE_PLUGINS_LAST_MNTH_CLR' DataId
from PLUGINS
where ACTIVATION_DATE<= date '@TMD1'
-- and ACTIVATION_DATE>= '@TMD1' 
and  
	( 
	REMOVAL_DATE is null
	or 
	date(REMOVAL_DATE)> date '@TMD1'
	)
and TYPE in (12100,12120,12130,12170) 
union

select '@TMD1' ReportDate, count(distinct ID) Val, 'ALL_ACTIVE_PLUGINS_LAST_YR_CLR' DataId
from PLUGINS
where ACTIVATION_DATE<=date_add('month',-11,date '@TMD1')
-- and ACTIVATION_DATE>= '@TMD1' 
and  
	( 
	REMOVAL_DATE is null
	or 
	date(REMOVAL_DATE)>date_add('month',-11,date '@TMD1')
	) 
and TYPE in (12100,12120,12130,12170) 
 

-- all new purchases
union 
select '@TMD1' ReportDate, count(distinct ID) Val, 'FIRST_PURCHASE_THIS_MNTH'  DataId from USERS 
where date(FIRST_PURCHASE_DATE)<=date(date_add('day', -1, date_add('month', 1, date '@TMD1')))
and date(FIRST_PURCHASE_DATE)>= date '@TMD1' 

union 
select '@TMD1' ReportDate, count(distinct ID) Val, 'FIRST_PURCHASE_LAST_MNTH'  DataId from USERS 
where date(FIRST_PURCHASE_DATE)<= date '@TMD1'
and date(FIRST_PURCHASE_DATE)>=date(date_add('month',-1, date '@TMD1'))


union 
select '@TMD1' ReportDate, count(distinct ID) Val, 'FIRST_PURCHASE_LAST_YR'  DataId from USERS 
where date(FIRST_PURCHASE_DATE)<=date(date_add('month',-11,date '@TMD1'))
and date(FIRST_PURCHASE_DATE)>=date(date_add('month',-12,date '@TMD1'))



-- all new slika 


-- ---
union 
select '@TMD1' ReportDate, count(distinct ID) Val, 'NEW_CLR_PLUGINS' DataId -- select * 
from PLUGINS
where ACTIVATION_DATE<=date_add('day', -1, date_add('month', 1, date '@TMD1')) 
and ACTIVATION_DATE>= date '@TMD1' 
and  
	( 
	REMOVAL_DATE is null
	or 
	date(REMOVAL_DATE)>date_add('day', -1, date_add('month', 1, date '@TMD1'))
	) 
and TYPE in (12100,12120,12130,12170) 
union

select '@TMD1' ReportDate, count(distinct ID) Val, 'NEW_CLR_PLUGINS_LAST_MNTH' DataId -- select *
from PLUGINS
where ACTIVATION_DATE<= date '@TMD1'
and ACTIVATION_DATE>=date_add('month',-1, date '@TMD1') 
-- and ACTIVATION_DATE>= '@TMD1' 
and  
	( 
	REMOVAL_DATE is null
	or 
	date(REMOVAL_DATE)> date '@TMD1'
	) 
    and TYPE in (12100,12120,12130,12170) 
union

select '@TMD1' ReportDate, count(distinct ID) Val, 'NEW_CLR_PLUGINS_LAST_YR' DataId
from PLUGINS
where ACTIVATION_DATE<=date_add('month',-11,date '@TMD1')
and ACTIVATION_DATE>=date_add('month',-12,date '@TMD1') 
and  
	( 
	REMOVAL_DATE is null
	or 
	date(REMOVAL_DATE)>date_add('month',-11,date '@TMD1')
	) 
and TYPE in (12100,12120,12130,12170) 
-- ---
