
select '@YDAY' ReportDate, count(case when u.USER_TYPE=2 then u.ID end) Val, 'ALL_ACTIVE_PAYERS' DataId from USERS u 
UNION
select '@YDAY' ReportDate, count(case when u.USER_TYPE=5 then u.ID end) Val, 'ALL_ACTIVE_EXTERNAL_PAYERS' DataId from USERS u 

-- all active payers

-- active users per tier
UNION
select '@YDAY', count(case when u.USER_TYPE in (2,5) and u.SUBSCRIPTION_TYPE=10010 then u.ID end), 'ALL_ACTIVE_LITE' from USERS u
UNION
select '@YDAY', count(case when u.USER_TYPE in (2,5) and u.SUBSCRIPTION_TYPE=10020 then u.ID end), 'ALL_ACTIVE_POPULAR' from USERS u
UNION
select '@YDAY', count(case when u.USER_TYPE in (2,5) and u.SUBSCRIPTION_TYPE=10030 then u.ID end), 'ALL_ACTIVE_BUSINESS' from USERS u
UNION
select '@YDAY', count(case when u.USER_TYPE in (2,5) and u.SUBSCRIPTION_TYPE=10040 then u.ID end), 'ALL_ACTIVE_PRIME' from USERS u

-- active trial period
UNION
select '@YDAY', count(case when u.USER_TYPE=0 then u.ID end), 'ALL_ACTIVE_TRIALS' from USERS u

-- new users funnel
UNION
select '@YDAY', count(case when date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' then u.ID end), 'JOINED'  from USERS u
UNION
select '@YDAY', count(case when date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and date_format(ACTIVATION_DATE,'%Y-%m-%d')='@YDAY' and USER_TYPE!=20 then u.ID end), 'ACTIVATED' from USERS u 
UNION
select '@YDAY', count(case when date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and date_format(ACTIVATION_DATE,'%Y-%m-%d')='@YDAY' and USER_TYPE!=20 and BUSINESS_COUNT>0 then u.ID end), 'SET_BUSINESS' from USERS u -- can you create a business before activating?
UNION
select '@YDAY', count(case when date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and date_format(ACTIVATION_DATE,'%Y-%m-%d')='@YDAY' and USER_TYPE!=20 and DOCUMENT_COUNT>0 then u.ID end), 'CREATED_DOC' from USERS u -- can you create a business before activating?
-- wow wow
-- app funnel - should clarify that the actions are not necassary via app, just the source
UNION
select '@YDAY', count(case when SOURCE='mobile-app' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' then u.ID end), 'JOINED_VIA_APP' from USERS u
UNION
select '@YDAY', count(case when SOURCE='mobile-app' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and date_format(ACTIVATION_DATE,'%Y-%m-%d')='@YDAY' and USER_TYPE!=20 then u.ID end), 'ACTIVATED_VIA_APP' from USERS u 
UNION
select '@YDAY', count(case when SOURCE='mobile-app' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and BUSINESS_COUNT>0 then u.ID end), 'SET_BUSINESS_VIA_APP' from USERS u -- can you create a business before activating?
UNION
select '@YDAY', count(case when SOURCE='mobile-app' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and DOCUMENT_COUNT>0 then u.ID end), 'CREATED_DOC_VIA_APP' from USERS u -- can you create a DOC before activating/business?
-- from google
UNION
select '@YDAY', count(case when SOURCE='google' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' then u.ID end), 'JOINED_VIA_GOOGLE' from USERS u
UNION
select '@YDAY', count(case when SOURCE='google' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and date_format(ACTIVATION_DATE,'%Y-%m-%d')='@YDAY' and USER_TYPE!=20 then u.ID end), 'ACTIVATED_VIA_GOOGLE' from USERS u 
UNION
select '@YDAY', count(case when SOURCE='google' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and BUSINESS_COUNT>0 then u.ID end), 'SET_BUSINESS_VIA_GOOGLE' from USERS u -- can you create a business before activating?
UNION
select '@YDAY', count(case when SOURCE='google' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and DOCUMENT_COUNT>0 then u.ID end), 'CREATED_DOC_VIA_GOOGLE' from USERS u -- can you create a DOC before activating/business?
-- from facebook
UNION
select '@YDAY', count(case when SOURCE='facebook' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' then u.ID end), 'JOINED_VIA_FACEBOOK' from USERS u
UNION
select '@YDAY', count(case when SOURCE='facebook' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and date_format(ACTIVATION_DATE,'%Y-%m-%d')='@YDAY' and USER_TYPE!=20 then u.ID end), 'ACTIVATED_VIA_FACEBOOK' from USERS u 
UNION
select '@YDAY', count(case when SOURCE='facebook' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and BUSINESS_COUNT>0 then u.ID end), 'SET_BUSINESS_VIA_FACEBOOK' from USERS u -- can you create a business before activating?
UNION
select '@YDAY', count(case when SOURCE='facebook' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and DOCUMENT_COUNT>0 then u.ID end), 'CREATED_DOC_VIA_FACEBOOK' from USERS u -- can you create a DOC before activating/business?
-- from email
UNION
select '@YDAY', count(case when SOURCE='mail' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' then u.ID end), 'JOINED_VIA_MAIL' from USERS u
UNION
select '@YDAY', count(case when SOURCE='mail' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and date_format(ACTIVATION_DATE,'%Y-%m-%d')='@YDAY' and USER_TYPE!=20 then u.ID end), 'ACTIVATED_VIA_MAIL' from USERS u 
UNION
select '@YDAY', count(case when SOURCE='mail' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and BUSINESS_COUNT>0 then u.ID end), 'SET_BUSINESS_VIA_MAIL' from USERS u -- can you create a business before activating?
UNION
select '@YDAY', count(case when SOURCE='mail' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and DOCUMENT_COUNT>0 then u.ID end), 'CREATED_DOC_VIA_MAIL' from USERS u -- can you create a DOC before activating/business?
-- from magazine
UNION
select '@YDAY', count(case when SOURCE='magazine' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' then u.ID end), 'JOINED_VIA_MAGAZINE' from USERS u
UNION
select '@YDAY', count(case when SOURCE='magazine' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and date_format(ACTIVATION_DATE,'%Y-%m-%d')='@YDAY' and USER_TYPE!=20 then u.ID end), 'ACTIVATED_VIA_MAGAZINE' from USERS u 
UNION
select '@YDAY', count(case when SOURCE='magazine' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and BUSINESS_COUNT>0 then u.ID end), 'SET_BUSINESS_VIA_MAGAZINE' from USERS u -- can you create a business before activating?
UNION
select '@YDAY', count(case when SOURCE='magazine' and date_format(CREATION_DATE,'%Y-%m-%d')='@YDAY' and DOCUMENT_COUNT>0 then u.ID end), 'CREATED_DOC_VIA_MAGAZINE' from USERS u -- can you create a DOC before activating/business?
-- new purchases made yesterday - annual
UNION
select '@YDAY', count(case when date_format(FIRST_PURCHASE_DATE,'%Y-%m-%d')='@YDAY' and SUBSCRIPTION_CYCLE=1 then u.ID end), 'NEW_ANNUAL_PURCHASES' from USERS u
-- new purchases made yesterday - monthly
UNION
select '@YDAY', count(case when date_format(FIRST_PURCHASE_DATE,'%Y-%m-%d')='@YDAY' and SUBSCRIPTION_CYCLE=2 then u.ID end), 'NEW_MONTHLY_PURCHASES' from USERS u
-- trial ended and no purchase -- I need to compare with creation date to make sure this is what's changed, but can't make this comparison within the count
UNION
select '@YDAY', count(case when u.USER_TYPE=1 and date_format(LAST_UPDATE_DATE,'%Y-%m-%d')='@YDAY' and date_format(CREATION_DATE,'%Y-%m-%d')='@NMN' then u.ID end), 'TRIAL_ENDED' from USERS u -- all active payers
