use mavenfuzzyfactory;
select min(created_at) from website_sessions

select min(date(website_sessions.created_at)) as date_of_entry,year(website_sessions.created_at) as year_of_entry,count(distinct(website_sessions.website_session_id)) as sessions,count(distinct(orders.order_id)) as orders,
count(orders.order_id)/count(website_sessions.website_session_id) as CTR
from website_sessions
left join orders
on website_sessions.website_session_id=orders.website_session_id
where website_sessions.utm_source='gsearch' and 
website_sessions.created_at<'2012-11-11'
group by month(website_sessions.created_at),2
order by date_of_entry,2

select min(date(website_sessions.created_at)) as date_of_entry,year(website_sessions.created_at) as year_of_entry,
count(distinct(case when website_sessions.utm_campaign='nonbrand' then website_sessions.website_session_id  else null end)) as nonbrand_sesssions,
count(distinct(case when website_sessions.utm_campaign='nonbrand' then orders.website_session_id else null end)) as nonbrand_orders,
count(distinct(case when website_sessions.utm_campaign='brand' then website_sessions.website_session_id  else null end)) as brand_sessions,
count(distinct(case when website_sessions.utm_campaign='brand' then orders.website_session_id   else null end)) as bran_orders
from website_sessions
left join orders
on website_sessions.website_session_id=orders.website_session_id
where website_sessions.utm_source='gsearch' and 
website_sessions.created_at<'2012-11-11'
group by month(website_sessions.created_at),2

select min(date(website_sessions.created_at)) as date_of_entry,year(website_sessions.created_at) as year_of_entry,
count(distinct(case when website_sessions.device_type='mobile' then website_sessions.website_session_id else null end)) as mobile_sessions, 
count(distinct(case when website_sessions.device_type='mobile' then orders.website_session_id  else null end)) as mobile_orders,
count(distinct(case when website_sessions.device_type='desktop' then website_sessions.website_session_id else null end)) as desktop_sessions,
count(distinct(case when website_sessions.device_type='desktop' then  orders.website_session_id else null end)) as desktop_orders
from website_sessions
left join orders
on website_sessions.website_session_id=orders.website_session_id
where website_sessions.utm_source='gsearch' and 
website_sessions.created_at<'2012-11-27' and
utm_campaign='nonbrand'
group by month(website_sessions.created_at),2

use mavenfuzzyfactory;
select min(date(created_at)),
count( distinct case when utm_source='gsearch' then website_session_id else null end) as g_search_sessions,
count( distinct case when utm_source<>'gsearch' then website_session_id else null end) as non_g_search_sessions,
count(distinct case when utm_source is null and http_referer is not null then website_session_id else null end) as organic_sessions,
count(distinct case when utm_source is  null and http_referer is  null then website_session_id else null end) as pure_sessions
from website_sessions
where created_at<'2012-11-27' 
group by month(created_at)

select month(website_sessions.created_at),count(website_sessions.website_session_id),count(orders.website_session_id),
count(orders.website_session_id)/count(website_sessions.website_session_id) as CTR
from website_sessions
left join orders
on website_sessions.website_session_id=orders.website_session_id
where website_sessions.created_at<'2012-11-27'
group by month(website_sessions.created_at)


select pageview_url,min(website_pageview_id) from website_pageviews
group by pageview_url

-- select pageview_url,max(website_pageview_id)

create temporary table l_pges4
select min(website_pageviews.website_pageview_id)as l_pg_id,website_pageviews.website_session_id as Session_id
from website_pageviews
inner join website_sessions
on website_sessions.website_session_id=website_pageviews.website_session_id
where website_pageviews.website_pageview_id>=23504 
and website_pageviews.created_at<='2012-07-28'
and utm_source='gsearch'
and utm_campaign='nonbrand'
group by website_pageviews.website_session_id;

select max(website_pageviews.website_session_id) from website_pageviews left join website_sessions on
website_pageviews.website_session_id=website_sessions.website_session_id
where website_pageviews.pageview_url='/home' 
and website_sessions.utm_source='gsearch'
and website_sessions.utm_campaign='nonbrand'
and website_sessions.created_at<='2012-11-27'

create temporary table total_sessions2
select website_pageviews.pageview_url,count(website_pageviews.website_session_id) as tot_ses,count(orders.order_id) as orders,
count(orders.order_id)/count(website_pageviews.website_session_id) as con_rt
from l_pges4
left join website_pageviews
on l_pges4.l_pg_id=website_pageviews.website_pageview_id
left join orders
on website_pageviews.website_session_id=orders.website_session_id
group by website_pageviews.pageview_url

select * from total_sessions2

select count(distinct(website_sessions.website_session_id)) from website_sessions left join website_pageviews
on website_sessions.website_session_id=website_pageviews.website_session_id
where website_sessions.utm_source='gsearch'
and website_sessions.utm_campaign='nonbrand'
and website_sessions.created_at<='2012-11-27'
and website_sessions.website_session_id>17145

-- next question



create temporary table count_of_sessions10
select website_session_id,
max(home_sessions) as saw_homepage,
max(lander_sessions) as saw_lander,
max(products_sessions) as saw_products,
max(fuzzy_sessions) as saw_fuzzy,
max(cart_sessions) as saw_cart_sessions,
max(shipping_sessions) as saw_shipping_sessions,
max(billing_sessions) as saw_billing_sessions,
max(thankyou_sessions) as saw_thanq_sessions
from(
select website_sessions.website_session_id,
website_pageviews.pageview_url,
case when pageview_url='/home' then 1 else 0 end as home_sessions,
case when pageview_url='/lander-1' then 1 else 0 end as lander_sessions,
case when pageview_url='/products' then 1 else 0 end as products_sessions,
case when pageview_url='/the-original-mr-fuzzy' then 1 else 0 end as fuzzy_sessions,
case when pageview_url='/cart' then 1 else 0 end as cart_sessions,
case when pageview_url='/shipping' then 1 else 0 end as shipping_sessions,
case when pageview_url='/billing' then 1 else 0 end as billing_sessions,
case when pageview_url='/thank-you-for-your-order' then 1 else 0 end as thankyou_sessions
from website_sessions
left join website_pageviews
on website_sessions.website_session_id=website_pageviews.website_session_id
where website_sessions.utm_source='gsearch'
and website_sessions.utm_campaign='nonbrand'
and website_sessions.created_at<'2012-07-28'
and website_sessions.created_at>'2012-06-19'
order by website_sessions.website_session_id,website_pageviews.website_session_id
) as count_sessions
group by website_session_id


select 
case 
when saw_homepage=1 then 'en_home' 
when saw_lander=1 then 'en_lande'
else 'wrong_logic'
end as segment,
count(distinct website_session_id) as sessions,
count(distinct case when saw_products=1 then website_session_id else null end) as product_sessions,
count(distinct case when saw_fuzzy=1 then website_session_id else null end) as fuzzy_sessions,
count(distinct case when saw_cart_sessions=1 then website_session_id else null end) as cart_sessions,
count(distinct case when saw_shipping_sessions=1 then website_session_id else null end) as shipping_sessions,
count(distinct case when saw_billing_sessions=1 then website_session_id else null end) as billing_sessions
from count_of_sessions10
group by 1

select um_source,
utm_camapign,
http_referer
count(