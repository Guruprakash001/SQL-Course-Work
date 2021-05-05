select count(lander_1_sessions) as lander_1_sessions,count(products_sessions) as products_sessions ,count(mr_fuzzy_sessions) as mr_fuzzy_sessions ,count(cart_sessions) as cart_sessions,count(billing_sessions) as billing_sessions,count(thanku_sessions) as thanku_sessions
from(
select web.website_session_id,web.pageview_url,web.website_pageview_id,
case when web.pageview_url='/lander-1'then 1 else null end as lander_1_sessions,
case when web.pageview_url='/products' then 1 else null end as products_sessions,
case when web.pageview_url='/the-original-mr-fuzzy' then 1 else null end as mr_fuzzy_sessions,
case when web.pageview_url='/cart' then 1 else null end as cart_sessions,
case when web.pageview_url='/billing' then 1 else null end as billing_sessions,
case when web.pageview_url='/thank-you-for-your-order' then 1  else null end as thanku_sessions
from website_pageviews web
inner join website_sessions wes
on wes.website_session_id=web.website_session_id
where web.created_at between '2012-08-05' and '2012-09-05'
and wes.utm_source='gsearch'
and wes.utm_campaign='nonbrand'
) as pg_viewlevel
