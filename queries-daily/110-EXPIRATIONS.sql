
-- expired annual and monthly breakdown
select '@YDAY' ReportDate, 
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
        ELSE 'Unknown'
    END PACKAGE_NAME,
    CASE
        WHEN acs.CYCLE_ID = 1 THEN 'Annual_expired_yesterday'
        WHEN acs.CYCLE_ID = 2 THEN 'Monthly'
        WHEN acs.CYCLE_ID = 0 THEN 'Trial'
        ELSE 'Unknown'
    END CYCLE_NAME, 
    COUNT(acs.ID) CNT 
FROM
    ACCOUNT_SUBSCRIPTIONS acs 
        LEFT JOIN
    (SELECT 
        USER_ID,
            DATE_FORMAT(MAX(EXPIRATION_DATE), '%Y-%m-%d') MAX_EXP
    FROM
        ACCOUNT_SUBSCRIPTIONS ACS
    GROUP BY 1) MXP ON acs.USER_ID = MXP.USER_ID
WHERE
    DATE_FORMAT(EXPIRATION_DATE, '%Y-%m-%d')='@YDAY' -- expired yesterday
        -- AND PACKAGE_ID > 0 -- not trial
        AND acs.CYCLE_ID in (0,1) -- because we're counting the monthly's cancelation below, and we don't want to double count.
        AND DATE_FORMAT(acs.EXPIRATION_DATE, '%Y-%m-%d') = MXP.MAX_EXP -- and they don't have a new package already in place
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
        ELSE 'Unknown'
    END PACKAGE_NAME,
    CASE
        WHEN acs.CYCLE_ID = 1 THEN 'Canceled_annual'
        WHEN acs.CYCLE_ID = 2 THEN 'Monthly_expires_this_month'
        WHEN acs.CYCLE_ID = 0 THEN 'Trial'
        ELSE 'Unknown'
    END CYCLE_NAME, 
    COUNT(acs.ID) CNT 
FROM
    ACCOUNT_SUBSCRIPTIONS acs 
        LEFT JOIN
    (SELECT 
        USER_ID,
            DATE_FORMAT(MAX(CANCELLATION_DATE), '%Y-%m-%d') MAX_CNCL
    FROM
        ACCOUNT_SUBSCRIPTIONS ACS
    GROUP BY 1) MXP ON acs.USER_ID = MXP.USER_ID
WHERE
    DATE_FORMAT(CANCELLATION_DATE, '%Y-%m-%d')='@YDAY' -- expired yesterday
        -- AND PACKAGE_ID > 0 -- not trial
        and STATUS=2 -- this is for monthly that have canceled, but are still able to use, until the end of the paid period.
        AND DATE_FORMAT(acs.CANCELLATION_DATE, '%Y-%m-%d') = MXP.MAX_CNCL -- and they don't have a new package already in place
GROUP BY 1 , 2
) expirals

