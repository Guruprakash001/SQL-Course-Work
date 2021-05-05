select min(created_at),
count(Case when device_type='mobile' then 'mobile' else null end) as mobile_sessions,
count(distinct case when device_type='desktop' then 'desktop' else null end) as desktop_sessions
 from website_sessions
 where utm_source='gsearch'
 and utm_campaign='nonbrand' 
 and created_at>'2012-04-15'
 and created_at<'2012-06-09'
group by week(created_at);

