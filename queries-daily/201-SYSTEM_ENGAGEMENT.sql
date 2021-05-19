-- number of items
select '@YDAY' ReportDate, 'SYSTEM_ACTIVE_USERS' DataId, count(distinct uda.user_id) Val 
from aggregates.user_daily_activity uda
where date(act_date)=date('@YDAY')

UNION

select '@YDAY' ReportDate, 'SYSTEM_ACTIVE_TRIALS' DataId, count(distinct case when uda.account_type = 0 then uda.user_id end ) Val 
from aggregates.user_daily_activity uda
where date(act_date)=date('@YDAY')

UNION

select '@YDAY' ReportDate, 'system_active_subscribers' DataId, count(distinct case when uda.account_type in (2,5,6) then uda.user_id end ) Val 
from aggregates.user_daily_activity uda
where date(act_date)=date('@YDAY')



