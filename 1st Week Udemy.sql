use mavenfuzzyfactory;
select min(date(created_at)),count(distinct(website_session_id)) as sessions
from website_sessions
where utm_source='gsearch'
and utm_campaign='nonbrand'
and created_at<'2012-05-12'
group by week(created_at),year(created_at);
-- select *
-- from website_sessions;