use mavenfuzzyfactory;
select we.device_type,count(distinct(we.website_session_id)) as sessions,
count(distinct(o.order_id)) as orders,
count(distinct(o.order_id))/count(distinct(we.website_session_id)) as con_rate
from website_sessions we
left join orders o
on we.website_session_id=o.website_session_id
where we.created_at<'2012-05-11'
and we.utm_source='gsearch'
and we.utm_campaign='nonbrand'
group by we.device_type;