select '@TMD1' ReportDate, 
concat('expirals_',PACKAGE_NAME,'_',CYCLE_NAME) DataId,
CNT Val
from(
SELECT 
    CASE
        WHEN acs.PACKAGE_ID = 10010 THEN 'Lite'
        WHEN acs.PACKAGE_ID = 10020 THEN 'Popular'
        WHEN acs.PACKAGE_ID = 10030 THEN 'Business'
        WHEN acs.PACKAGE_ID = 10040 THEN 'Prime'
        WHEN acs.PACKAGE_ID = 0 THEN 'Trial'
        ELSE ' Unknown'
    END PACKAGE_NAME,
    CASE
        WHEN acs.CYCLE_ID = 1 THEN 'Annual_expired_yesterday'
        WHEN acs.CYCLE_ID = 2 THEN 'Monthly_expired'
        WHEN acs.CYCLE_ID = 0 THEN 'Trial'
        ELSE 'Unknown'
    END CYCLE_NAME, 
    COUNT(distinct acs.ID) CNT 
FROM
    ACCOUNT_SUBSCRIPTIONS acs 
WHERE
    DATE_FORMAT(EXPIRATION_DATE, '%Y-%m') = '@TMY' -- expired this month
 and EXPIRATION_DATE>= date '@TMD1'    
         AND PACKAGE_ID > 0 -- not trial
         AND acs.CYCLE_ID in (0,1) -- because we're counting the monthly's cancelation below, and we don't want to double count.
        -- AND DATE_FORMAT(acs.EXPIRATION_DATE, ' %Y-%m-%d') = MXP.MAX_EXP -- and they don't have a new package already in place
        -- and status
GROUP BY 1 , 2

union all

SELECT 
    CASE
        WHEN acs.PACKAGE_ID = 10010 THEN 'Lite'
        WHEN acs.PACKAGE_ID = 10020 THEN 'Popular'
        WHEN acs.PACKAGE_ID = 10030 THEN 'Business'
        WHEN acs.PACKAGE_ID = 10040 THEN 'Prime'
        WHEN acs.PACKAGE_ID = 0 THEN 'Trial'
        ELSE ' Unknown'
    END PACKAGE_NAME,
    CASE
        WHEN acs.CYCLE_ID = 1 THEN 'Canceled_annual'
        WHEN acs.CYCLE_ID = 2 THEN 'Monthly_expires_this_month'
        WHEN acs.CYCLE_ID = 0 THEN 'Trial'
        ELSE 'Unknown'
    END CYCLE_NAME, 
    COUNT(distinct acs.ID) CNT 
FROM
    ACCOUNT_SUBSCRIPTIONS acs 
        
WHERE
	acs.CYCLE_ID =2
	AND PACKAGE_ID > 0 -- not trial
    and ((
    DATE_FORMAT(CANCELLATION_DATE, '%Y-%m') = '@TMY' -- expired yesterday
		and CANCELLATION_DATE>= date '@TMD1'
        and STATUS=2 -- this is for monthly that have canceled, but are still able to use, until the end of the paid period.
       ) 
       or 
       DATE_FORMAT(EXPIRATION_DATE, '%Y-%m') = '@TMY'
		and EXPIRATION_DATE>= date '@TMD1'
       ) -- AND DATE_FORMAT(acs.CANCELLATION_DATE, ' %Y-%m-%d') = MXP.MAX_CNCL -- and they don't have a new package already in place
GROUP BY 1 , 2
) expirals
	  -- renewals out of cancelatlions
union 
select '@TMD1' ReportDate, 
concat('renew_out_of_expirals_',PACKAGE_NAME,'_',CYCLE_NAME) DataId,
CNT Val
from(

select 
 expires.PACKAGE_NAME, 
 expires.CYCLE_NAME, 
    COUNT(distinct acs.ID) CNT  
FROM
    ACCOUNT_SUBSCRIPTIONS acs
join 
( select 
USER_ID, 
CASE
        WHEN acs.PACKAGE_ID = 10010 THEN 'Lite'
        WHEN acs.PACKAGE_ID = 10020 THEN 'Popular'
        WHEN acs.PACKAGE_ID = 10030 THEN 'Business'
        WHEN acs.PACKAGE_ID = 10040 THEN 'Prime'
        WHEN acs.PACKAGE_ID = 0 THEN 'Trial'
        ELSE ' Unknown'
    END PACKAGE_NAME,
    CASE
        WHEN acs.CYCLE_ID = 1 THEN 'annual'
        WHEN acs.CYCLE_ID = 2 THEN 'monthly'
        WHEN acs.CYCLE_ID = 0 THEN 'Trial'
        ELSE 'Unknown'
    END CYCLE_NAME, 
coalesce(CANCELLATION_DATE,EXPIRATION_DATE) END_DATE
FROM
    ACCOUNT_SUBSCRIPTIONS acs
WHERE
		(DATE_FORMAT(EXPIRATION_DATE, '%Y-%m') = '@TMY' -- expired this month
		and EXPIRATION_DATE>= date '@TMD1'
         AND PACKAGE_ID > 0 -- not trial
         AND acs.CYCLE_ID in (0,1) -- because we're counting the monthly's cancelation below, and we don't want to double count.
		) -- annual cancels
        or 
        (
			acs.CYCLE_ID =2
			and (
						(
						DATE_FORMAT(CANCELLATION_DATE, '%Y-%m') = '@TMY' -- expired yesterday
						and CANCELLATION_DATE>= date '@TMD1'
						and STATUS=2 -- this is for monthly that have canceled, but are still able to use, until the end of the paid period.
						) 
					   or 
					   DATE_FORMAT(EXPIRATION_DATE, '%Y-%m') = '@TMY'
						and EXPIRATION_DATE>=date '@TMD1'
			   ) 
		 ) -- monthly cancels
        --  group by 1
) expires
on acs.USER_ID=expires.USER_ID
where 
DATE_FORMAT(acs.CREATION_DATE, '%Y-%m') = '@TMY' 
and CREATION_DATE>=date '@TMD1'
and acs.CREATION_DATE>=END_DATE
and acs.PACKAGE_ID>0 -- because sometimes cancel date=creation date, and we don't want those trials
group by 1,2
) renew_exp
-- all other renewals
union 
select '@TMD1' ReportDate, 
concat('all_renewals_',PACKAGE_NAME,'_',CYCLE_NAME) DataId,
CNT Val
from(
-- renewals this month, not from this month cancelations
select 
 CASE
        WHEN acs.PACKAGE_ID = 10010 THEN 'Lite'
        WHEN acs.PACKAGE_ID = 10020 THEN 'Popular'
        WHEN acs.PACKAGE_ID = 10030 THEN 'Business'
        WHEN acs.PACKAGE_ID = 10040 THEN 'Prime'
        WHEN acs.PACKAGE_ID = 0 THEN 'Trial'
        ELSE ' Unknown'
    END PACKAGE_NAME,
    CASE
        WHEN acs.CYCLE_ID = 1 THEN  'renewed_annual'
        WHEN acs.CYCLE_ID = 2 THEN 'renewed_monthly'
        WHEN acs.CYCLE_ID = 0 THEN 'Trial'
        ELSE ' Unknown'
    END CYCLE_NAME, 
    COUNT(distinct acs.ID) CNT  
FROM
    ACCOUNT_SUBSCRIPTIONS acs -- multiple renewals!!!!
    left join (select USER_ID, min(CREATION_DATE) FIRST_PURCHASE from ACCOUNT_SUBSCRIPTIONS where PACKAGE_ID>0 group by 1)FRST
on acs.USER_ID=FRST.USER_ID
and acs.CREATION_DATE=FRST.FIRST_PURCHASE
where 
DATE_FORMAT(acs.CREATION_DATE, '%Y-%m') = '@TMY' 
and CREATION_DATE>=date '@TMD1'
and acs.PACKAGE_ID>0 -- because sometimes cancel date=creation date, and we don't want those trials
and FRST.USER_ID is null 
and (acs.CANCELLATION_DATE is null or acs.CANCELLATION_DATE>date_add('day', -1, date_add('month', 1,date '@TMD1'))) -- to remove quick cancellation cases
and (acs.EXPIRATION_DATE is null or acs.EXPIRATION_DATE>date_add('day', -1, date_add('month', 1,date '@TMD1'))) -- 
group by 1,2
) renew_other

union
/*
////////////////////////////////////////////////////////////////
//////////////////////////////// Renew YoY rate ////////////////
////////////////////////////////////////////////////////////////
*/

select '@TMD1' ReportDate, 
concat('expirals_YoY',PACKAGE_NAME,'_',CYCLE_NAME) DataId,
CNT Val
from(
SELECT 
    CASE
        WHEN acs.PACKAGE_ID = 10010 THEN 'Lite'
        WHEN acs.PACKAGE_ID = 10020 THEN 'Popular'
        WHEN acs.PACKAGE_ID = 10030 THEN 'Business'
        WHEN acs.PACKAGE_ID = 10040 THEN 'Prime'
        WHEN acs.PACKAGE_ID = 0 THEN 'Trial'
        ELSE ' Unknown'
    END PACKAGE_NAME,
    CASE
        WHEN acs.CYCLE_ID = 1 THEN 'Annual'
        WHEN acs.CYCLE_ID = 2 THEN 'Monthly'
        WHEN acs.CYCLE_ID = 0 THEN 'Trial'
        ELSE 'Unknown'
    END CYCLE_NAME, 
    COUNT(acs.ID) CNT 
FROM
    ACCOUNT_SUBSCRIPTIONS acs 
WHERE
    DATE_FORMAT(EXPIRATION_DATE, '%Y-%m') = '@YOY' -- expired this month
    AND EXPIRATION_DATE between date('@YOD1') and date('@YOD30') 
        -- AND PACKAGE_ID > 0 -- not trial
         AND acs.CYCLE_ID in (0,1) -- because we're counting the monthly's cancelation below, and we don't want to double count.
        -- AND DATE_FORMAT(acs.EXPIRATION_DATE, ' %Y-%m-%d') = MXP.MAX_EXP -- and they don't have a new package already in place
        -- and status
GROUP BY 1 , 2

union all

SELECT 
    CASE
        WHEN acs.PACKAGE_ID = 10010 THEN 'Lite'
        WHEN acs.PACKAGE_ID = 10020 THEN 'Popular'
        WHEN acs.PACKAGE_ID = 10030 THEN 'Business'
        WHEN acs.PACKAGE_ID = 10040 THEN 'Prime'
        WHEN acs.PACKAGE_ID = 0 THEN 'Trial'
        ELSE ' Unknown'
    END PACKAGE_NAME,
    CASE
        WHEN acs.CYCLE_ID = 1 THEN 'Canceled_annual'
        WHEN acs.CYCLE_ID = 2 THEN 'Monthly_expires_this_month'
        WHEN acs.CYCLE_ID = 0 THEN 'Trial'
        ELSE 'Unknown'
    END CYCLE_NAME, 
    COUNT(acs.ID) CNT -- select * 
FROM
    ACCOUNT_SUBSCRIPTIONS acs 
        
WHERE
	acs.CYCLE_ID =2
    and ((
    DATE_FORMAT(CANCELLATION_DATE, '%Y-%m') = '@YOY' -- expired yesterday
    and CANCELLATION_DATE  between date('@YOD1') and date('@YOD30')
        and STATUS=2 -- this is for monthly that have canceled, but are still able to use, until the end of the paid period.
       ) 
       or 
       DATE_FORMAT(EXPIRATION_DATE, '%Y-%m') = '@YOY'
       and EXPIRATION_DATE  between date('@YOD1') and date('@YOD30')
       ) -- AND DATE_FORMAT(acs.CANCELLATION_DATE, ' %Y-%m-%d') = MXP.MAX_CNCL -- and they don't have a new package already in place
GROUP BY 1 , 2
) expirals

union 
select '@TMD1' ReportDate, 
concat('renew_out_of_expirals_YoY_',PACKAGE_NAME,'_',CYCLE_NAME) DataId,
CNT Val
from(
-- renewals out of cancelatlions
select 
 expi.PACKAGE_NAME, 
 expi.CYCLE_NAME, 
    COUNT(distinct acs.ID) CNT  -- select * 
FROM
    ACCOUNT_SUBSCRIPTIONS acs
join -- select * from 
( select 
USER_ID, 
CASE
        WHEN acs.PACKAGE_ID = 10010 THEN 'Lite'
        WHEN acs.PACKAGE_ID = 10020 THEN 'Popular'
        WHEN acs.PACKAGE_ID = 10030 THEN 'Business'
        WHEN acs.PACKAGE_ID = 10040 THEN 'Prime'
        WHEN acs.PACKAGE_ID = 0 THEN 'Trial'
        ELSE ' Unknown'
    END PACKAGE_NAME,
    CASE
        WHEN acs.CYCLE_ID = 1 THEN 'annual'
        WHEN acs.CYCLE_ID = 2 THEN 'monthly'
        WHEN acs.CYCLE_ID = 0 THEN 'Trial'
        ELSE 'Unknown'
    END CYCLE_NAME, 
coalesce(CANCELLATION_DATE,EXPIRATION_DATE) END_DATE
FROM
    ACCOUNT_SUBSCRIPTIONS acs
WHERE
		(DATE_FORMAT(EXPIRATION_DATE, '%Y-%m') = '@YOY' -- expired this month
				and EXPIRATION_DATE  between date('@YOD1') and date('@YOD30')
         AND acs.CYCLE_ID in (0,1) -- because we're counting the monthly's cancelation below, and we don't want to double count.
		) -- annual cancels
        or 
        (
			acs.CYCLE_ID =2
			and (
						(
						DATE_FORMAT(CANCELLATION_DATE, '%Y-%m') = '@YOY' -- expired yesterday
						and CANCELLATION_DATE  between date('@YOD1') and date('@YOD30')
						and STATUS=2 -- this is for monthly that have canceled, but are still able to use, until the end of the paid period.
						) 
					   or 
					   DATE_FORMAT(EXPIRATION_DATE, '%Y-%m') = '@YOY'
						and EXPIRATION_DATE  between date('@YOD1') and date('@YOD30')
			   ) 
		 ) -- monthly cancels
        --  group by 1
) expi
on acs.USER_ID=expi.USER_ID
where 
DATE_FORMAT(acs.CREATION_DATE, '%Y-%m') = '@YOY' 
    and CREATION_DATE  between date('@YOD1') and date('@YOD30')
and acs.CREATION_DATE>=END_DATE
and acs.PACKAGE_ID>0 -- because sometimes cancel date=creation date, and we don't want those trials
group by 1,2
) renew_exp
;
