select pageview_url,min(website_pageview_id),created_at
from website_pageviews
where pageview_url='/billing-2'
group by pageview_url,created_at
order by min(website_pageview_id)

select * from website_pageviews website where website_pageview_id>=53550 and created_at<'2012-11-10'

-- select 
-- case when pageview_url='/billing' then 'billing_sessions'
--      when pageview_url='/billing-2' then 'billing_sessions_2'
--      
--      end as segment,
-- count(case when pageview_url='/thank-you-for-your-order'then website_session_id else null end) as Thankyou_sessions
-- from  website_pageviews 
-- where  website_pageview_id>=53550 and created_at<'2012-11-10'
-- group by 1
-- --  
-- --  select * from website_pageviews where pageview_url='/billing-2'
create temporary table unity 
select website_session_id,
max(billing_sessions) as saw_billing_ssesion,
max(billing_sessions_2) as saw_biiling_2,
max(thanku_sessions) as saw_thanku_session
from(
select website_session_id,
case when pageview_url='/billing' then 1 else 0 end as billing_sessions,
case when pageview_url='/billing-2' then 1 else 0 end as billing_sessions_2,
case when pageview_url='/thank-you-for-your-order' then 1 else 0 end as thanku_sessions
from website_pageviews
where website_pageview_id>=53550 and created_at<'2012-11-10'
) as temp_tab
group by 1

select
case when saw_billing_ssesion=1 then 'en_billing'


when saw_biiling_2=1 then 'en_billing2' 
else 'no-billing-sessions'
end as segment,
count(distinct website_session_id),
count(distinct case when saw_thanku_session=1 then website_session_id else null end) as thank_sessions
from unity
group by 1