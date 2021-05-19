with plu as (
select u.ID, p.ACTIVATION_DATE
from PLUGINS p join BUSINESSES b on p.BUSINESS_ID=b.ID join USERS u on u.ID=b.USER_ID
where p.TYPE in (12100,12120,12130,12170) 
) 


select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and date_format(CREATION_DATE,'%Y-%m')='@TMY' then u.ID end) Val, 'JOINED_VIA_APP' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(ACTIVATION_DATE,'%Y-%m')='@TMY' and USER_TYPE!=20 then u.ID end) Val, 'ACTIVATED_VIA_APP' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and date_format(CREATION_DATE,'%Y-%m')='@TMY' and BUSINESS_COUNT>0 then u.ID end) Val, 'SET_BUSINESS_VIA_APP' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and date_format(CREATION_DATE,'%Y-%m')='@TMY' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'CREATED_DOC_VIA_APP' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and date_format(CREATION_DATE,'%Y-%m')='@TMY'  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'NEW_PURCHASES_VIA_APP' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app'  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'PLUGIN_VIA_APP' DataId from USERS u join plu on u.ID=plu.ID where date_format(plu.ACTIVATION_DATE,'%Y-%m')='@TMY'
-- new purchases made yesterday - annual
-- 
union
select '@TMD1' ReportDate, count(case when SOURCE='google' and date_format(CREATION_DATE,'%Y-%m')='@TMY' then u.ID end) Val, 'JOINED_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(ACTIVATION_DATE,'%Y-%m')='@TMY' and USER_TYPE!=20 then u.ID end) Val, 'ACTIVATED_VIA_GGL' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and date_format(CREATION_DATE,'%Y-%m')='@TMY' and BUSINESS_COUNT>0 then u.ID end) Val, 'SET_BUSINESS_VIA_GGL' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and date_format(CREATION_DATE,'%Y-%m')='@TMY' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'CREATED_DOC_VIA_GGL' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google'  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'NEW_PURCHASES_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google'  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'PLUGIN_VIA_GGL' DataId from USERS u join plu on u.ID=plu.ID where date_format(plu.ACTIVATION_DATE,'%Y-%m')='@TMY'
-- fb
union
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and date_format(CREATION_DATE,'%Y-%m')='@TMY' then u.ID end) Val, 'JOINED_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(ACTIVATION_DATE,'%Y-%m')='@TMY' and USER_TYPE!=20 then u.ID end) Val, 'ACTIVATED_VIA_FB' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and date_format(CREATION_DATE,'%Y-%m')='@TMY' and BUSINESS_COUNT>0 then u.ID end) Val, 'SET_BUSINESS_VIA_FB' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and date_format(CREATION_DATE,'%Y-%m')='@TMY' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'CREATED_DOC_VIA_FB' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook'  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'NEW_PURCHASES_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook'  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'PLUGIN_VIA_FB' DataId from USERS u join plu on u.ID=plu.ID where date_format(plu.ACTIVATION_DATE,'%Y-%m')='@TMY'


union
select '@TMD1' ReportDate, count(case when SOURCE is null and date_format(CREATION_DATE,'%Y-%m')='@TMY' then u.ID end) Val, 'JOINED_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(ACTIVATION_DATE,'%Y-%m')='@TMY' and USER_TYPE!=20 then u.ID end) Val, 'ACTIVATED_VIA_ORG' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and date_format(CREATION_DATE,'%Y-%m')='@TMY' and BUSINESS_COUNT>0 then u.ID end) Val, 'SET_BUSINESS_VIA_ORG' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and date_format(CREATION_DATE,'%Y-%m')='@TMY' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'CREATED_DOC_VIA_ORG' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'NEW_PURCHASES_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'PLUGIN_VIA_ORG' DataId from USERS u join plu on u.ID=plu.ID where date_format(plu.ACTIVATION_DATE,'%Y-%m')='@TMY'

union
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and date_format(CREATION_DATE,'%Y-%m')='@TMY' then u.ID end) Val, 'JOINED_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(ACTIVATION_DATE,'%Y-%m')='@TMY' and USER_TYPE!=20 then u.ID end) Val, 'ACTIVATED_VIA_ELSE' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and date_format(CREATION_DATE,'%Y-%m')='@TMY' and BUSINESS_COUNT>0 then u.ID end) Val, 'SET_BUSINESS_VIA_ELSE' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and date_format(CREATION_DATE,'%Y-%m')='@TMY' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'CREATED_DOC_VIA_ELSE' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook')  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'NEW_PURCHASES_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook')  and date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'PLUGIN_VIA_ELSE' DataId from USERS u join plu on u.ID=plu.ID where date_format(plu.ACTIVATION_DATE,'%Y-%m')='@TMY'

union 

select '@TMD1' ReportDate, count(case when date_format(CREATION_DATE,'%Y-%m')='@TMY' then u.ID end) Val, 'JOINED'  from USERS u
UNION
select '@TMD1' ReportDate, count(case when date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(ACTIVATION_DATE,'%Y-%m')='@TMY' and USER_TYPE!=20 then u.ID end) Val, 'ACTIVATED' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(ACTIVATION_DATE,'%Y-%m')='@TMY' and USER_TYPE!=20 and BUSINESS_COUNT>0 then u.ID end) Val, 'SET_BUSINESS' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when date_format(CREATION_DATE,'%Y-%m')='@TMY' and date_format(ACTIVATION_DATE,'%Y-%m')='@TMY' and USER_TYPE!=20 and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'CREATED_DOC' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY' and date_format(CREATION_DATE,'%Y-%m')='@TMY'   then u.ID end) Val, 'NEW_PURCHASES' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when date_format(FIRST_PURCHASE_DATE,'%Y-%m')='@TMY' and date_format(CREATION_DATE,'%Y-%m')='@TMY'  then u.ID end) Val, 'PLUGIN' DataId from USERS u join plu on u.ID=plu.ID where date_format(plu.ACTIVATION_DATE,'%Y-%m')='@TMY'

-- need to clone 60->30 and 90->60

-- T-30-> T-60 
-- T60->T30
union
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_APP' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_APP' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_APP' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_APP' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES_VIA_APP' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN_VIA_APP' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'
-- new purchases made yesterday - annual
-- 
union
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_GGL' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_GGL' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_GGL' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN_VIA_GGL' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'
-- fb
union
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_FB' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_FB' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_FB' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN_VIA_FB' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'


union
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_ORG' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_ORG' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_ORG' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN_VIA_ORG' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'

union
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_ELSE' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_ELSE' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_ELSE' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN_VIA_ELSE' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'

union 

select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED'  from USERS u
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'
union
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE  between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_APP' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_APP' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE  between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_APP' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE  between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_APP' DataId from USERS u -- can you create a DOC before activating/business?

-- new purchases made yesterday - annual
-- 
union
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE  between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_GGL' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE  between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_GGL' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE  between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_GGL' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN_VIA_GGL' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'
-- fb
union
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE  between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_FB' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE  between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_FB' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE  between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_FB' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN_VIA_FB' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'


union
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_ORG' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_ORG' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_ORG' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN_VIA_ORG' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'

union
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED_VIA_ELSE' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T60' and date '@T30' and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS_VIA_ELSE' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T60' and date '@T30' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC_VIA_ELSE' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN_VIA_ELSE' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'

union 

select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T60' and date '@T30' then u.ID end) Val, 'T30_T60_JOINED'  from USERS u
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 then u.ID end) Val, 'T30_T60_ACTIVATED' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 and BUSINESS_COUNT>0 then u.ID end) Val, 'T30_T60_SET_BUSINESS' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T60' and date '@T30' and ACTIVATION_DATE between date '@T60' and date '@T30' and USER_TYPE!=20 and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T30_T60_CREATED_DOC' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_NEW_PURCHASES' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE between date '@T60' and date '@T30' and FIRST_PURCHASE_DATE between date '@T60' and date '@T30'  then u.ID end) Val, 'T30_T60_PLUGIN' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T60' and date '@T30'

-- T90->T60

-- T90->T60
union 
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_APP' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_APP' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_APP' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_APP' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T90' and date '@T60'  then u.ID end) Val, 'T60_T90_NEW_PURCHASES_VIA_APP' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE between date '@T90' and date '@T60'  then u.ID end) Val, 'T60_T90_PLUGIN_VIA_APP' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'

-- new purchases made yesterday - annual
-- 

union
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_GGL' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_GGL' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_GGL' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN_VIA_GGL' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'
-- fb
union
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_FB' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_FB' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_FB' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN_VIA_FB' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'


union
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_ORG' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_ORG' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_ORG' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN_VIA_ORG' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'

union
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_ELSE' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_ELSE' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_ELSE' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN_VIA_ELSE' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'

union 

select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED'  from USERS u
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'
union
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE  between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_APP' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_APP' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE  between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_APP' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='mobile-app' and CREATION_DATE  between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_APP' DataId from USERS u -- can you create a DOC before activating/business?
-- new purchases made yesterday - annual
-- 
union
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE  between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_GGL' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE  between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_GGL' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and CREATION_DATE  between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_GGL' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES_VIA_GGL' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='google' and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN_VIA_GGL' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'
-- fb
union
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE  between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_FB' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE  between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_FB' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and CREATION_DATE  between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_FB' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES_VIA_FB' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE='facebook' and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN_VIA_FB' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'


union
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_ORG' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_ORG' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and CREATION_DATE  between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_ORG' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES_VIA_ORG' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is null and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN_VIA_ORG' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'

union
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED_VIA_ELSE' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T90' and date '@T60' and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS_VIA_ELSE' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and CREATION_DATE  between date '@T90' and date '@T60' and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC_VIA_ELSE' DataId from USERS u -- can you create a DOC before activating/business?
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES_VIA_ELSE' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when SOURCE is not null and SOURCE not in ('mobile-app','google','facebook') and FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN_VIA_ELSE' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'

union	 

select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T90' and date '@T60' then u.ID end) Val, 'T60_T90_JOINED'  from USERS u
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 then u.ID end) Val, 'T60_T90_ACTIVATED' DataId from USERS u 
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 and BUSINESS_COUNT>0 then u.ID end) Val, 'T60_T90_SET_BUSINESS' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when CREATION_DATE  between date '@T90' and date '@T60' and ACTIVATION_DATE between date '@T90' and date '@T60' and USER_TYPE!=20 and TOTAL_DOCUMENT_COUNT>0 then u.ID end) Val, 'T60_T90_CREATED_DOC' DataId from USERS u -- can you create a business before activating?
UNION
select '@TMD1' ReportDate, count(case when FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_NEW_PURCHASES' DataId from USERS u
UNION
select '@TMD1' ReportDate, count(case when FIRST_PURCHASE_DATE between date '@T90' and date '@T60' and CREATION_DATE between date '@T90' and date '@T60'   then u.ID end) Val, 'T60_T90_PLUGIN' DataId from USERS u join plu on u.ID=plu.ID where plu.ACTIVATION_DATE between date '@T90' and date '@T60'

