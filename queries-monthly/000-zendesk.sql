select '@LASTMONTHFIRSTDAY' ReportDate, count(*) Val , 'ZENDESK_OPENED' DataId
   from events where year=year(date '@LASTMONTHFIRSTDAY')  and month=month(date '@LASTMONTHFIRSTDAY')
    and category='zendesk' and label='ticket_created' and action='request'
   
UNION 

select '@LASTMONTHFIRSTDAY' ReportDate, count(*) Val , 'ZENDESK_CLOSED' DataId
   from events where year=year(date '@LASTMONTHFIRSTDAY')  and month=month(date '@LASTMONTHFIRSTDAY')
    and category='zendesk' and label='ticket_closed' and action='request'
      
UNION 

select '@LASTMONTHFIRSTDAY' ReportDate, count(*) Val , 'ZENDESK_SOLVED' DataId
   from events where year=year(date '@LASTMONTHFIRSTDAY')  and month=month(date '@LASTMONTHFIRSTDAY')
    and category='zendesk' and label='ticket_solved' and action='request'
   
UNION 

select '@LASTMONTHFIRSTDAY' ReportDate, count(*) Val , 'ZENDESK_AGENT_COMMENT_CREATED' DataId
   from events where year=year(date '@LASTMONTHFIRSTDAY')  and month=month(date '@LASTMONTHFIRSTDAY')
    and category='zendesk' and label='agent_comment_created' and action='request'
