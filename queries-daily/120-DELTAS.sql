select '@YDAY' ReportDate, 'JOINED_DAILY_DELTA' DataId, JOINED - @{JOINED} Val 
from WIDE_GLOBAL_DAILY  where ReportDate=date '@Y2DAY'

UNION

select '@YDAY' ReportDate, 'JOINED_VIA_APP_DAILY_DELTA' DataId, JOINED_VIA_APP - @{JOINED_VIA_APP} Val
from WIDE_GLOBAL_DAILY  where ReportDate=date '@Y2DAY' 

UNION

select '@YDAY' ReportDate, 'TRIAL_ENDED_DAILY_DELTA' DataId, TRIAL_ENDED - @{TRIAL_ENDED} Val 
from WIDE_GLOBAL_DAILY  where ReportDate=date '@Y2DAY' 
