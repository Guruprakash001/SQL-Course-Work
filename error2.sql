select * from website_sessions 
-- select 
-- case when website_sessions.utm_source='gsearch' then website_sessions.utm_source
--      when website_sessions.utm_source='bsearch' then website_sessions.utm_source
--      end as type_of_search,
-- count(distinct( website_sessions.website_session_id)) as sessions,
-- count(distinct(orders.website_session_id)) as orders
-- from website_sessions
-- left join orders
-- on website_sessions.website_session_id=orders.website_session_id
-- where website_sessions.created_at>'2012-09-22'
-- and website_sessions.created_at<'2012-29-11'
-- group by 1

select min(date(created_at)),
count(distinct case when utm_source='gsearch' then website_session_id else null end) as gsearch_sessions,
count(distinct case when utm_source='bsearch' then website_session_id else null end) as bsearch_sessions
from website_sessions
where created_at between '2012-08-22' and '2012-11-29'
and utm_campaign='nonbrand'
group by yearweek(created_at)

select min(date(created_at)),
count(distinct(website_session_id))
from website_sessions
where created_at between '2012-08-22' and '2012-11-29'
and utm
group by week(created_at)


select utm_source,
count(distinct(website_session_id)) as sessions,
count(distinct(case when device_type='mobile' then website_session_id else null end)) as mobile_sessions
from website_sessions
where utm_source in ('gsearch'or 'bsearch')
and created_at between '2012-08-22' and '2012-11-30'
and utm_campaign='nonbrand'
group by 1

select website_sessions.utm_source,website_sessions.device_type,
count(distinct website_sessions.website_session_id),
count(distinct orders.order_id)
from website_sessions
left join orders
on website_sessions.website_session_id=orders.website_session_id
where website_sessions.utm_campaign= 'nonbrand'
and website_sessions.created_at >'2012-08-22'  
and website_sessions.created_at<'2012-09-18'
group by 1,2

select min(date(created_at)),
count(distinct case when website_sessions.utm_source='gsearch' and website_sessions.device_type='desktop' then website_sessions.website_session_id else null end) as d_top_gsearch,
count(distinct case when website_sessions.utm_source='gsearch' and website_sessions.device_type='mobile' then website_sessions.website_session_id else null end) as mobile_gsearch,
count(distinct case when website_sessions.utm_source='bsearch' and website_sessions.device_type='desktop' then website_sessions.website_session_id else null end) as d_top_bsearch,
count(distinct case when website_sessions.utm_source='bsearch' and website_sessions.device_type='mobile' then website_sessions.website_session_id else null end) as mobile_bsearch
from website_sessions
where website_sessions.created_at between '2012-11-04' and '2012-12-22'
and utm_campaign='nonbrand'
group by week(created_at)

select year(created_at) as year,
month(created_at) as month,
count(distinct case when utm_source is null and http_referer is null then website_session_id else null end) as direct_search,
count(distinct case when utm_source is null and http_referer in('https://www.gsearch.com','https://www.bsearch.com') then website_session_id else null end) as paid_organic_search,
count(distinct case when utm_campaign='brand' then website_session_id else null end) as paid_brand_search,
count(distinct case when utm_campaign='nonbrand' then website_session_id else null end) as paid_nonbrand_search
from website_sessions where created_at<'2012-12-23'
group by 1,2

select month(website_sessions.created_at),
year(website_sessions.created_at),
count(website_sessions.website_session_id) as sessions,
count(orders.order_id) as orders
from website_sessions
left join orders on
website_sessions.website_session_id=orders.website_session_id
where website_sessions.created_at<'2013-01-03'
group by 1,2
order by date(website_sessions.created_at)

select min(date(website_sessions.created_at)),
count(website_sessions.website_session_id) as sessions,
count(orders.order_id) as orders
from website_sessions
left join orders on
website_sessions.website_session_id=orders.website_session_id
where website_sessions.created_at<'2013-01-03'
group by week(website_sessions.created_at)
order by date(website_sessions.created_at)

select hr,
avg(case when wkday=0 then sessions else null end) as mon,
avg(case when wkday=1 then sessions else null end) as Tue,
avg(case when wkday=2 then sessions else null end) as Wed,
avg(case when wkday=3 then sessions else null end) as Thur,
avg(case when wkday=4 then sessions else null end) as Fri,
avg(case when wkday=5 then sessions else null end) as Sat,
avg(case when wkday=6 then sessions else null end) as Sun
from(select date(created_at) as dt,
	weekday(created_at) as wkday,
	hour(created_at) as hr,
    count(website_session_id) as sessions
    from website_sessions
    where created_at between '2012-09-15' and '2012-11-15'
    group by 1,2,3) as to_ses
    group by 1
    
   select year(created_at) as yaer,month(created_at) as mo,
   count(distinct order_id) as num_sales,
   sum(price_usd) as tot_rev,
   sum(price_usd-cogs_usd) as margin
   from orders
   where created_at<'2013-01-4'
   group by 1,2
   order by 1,2
   
   select * from orders
   
   select year(created_at) as ye,month(created_at) as mo,
   count(distinct order_id) as orders,
   sum(price_usd) as revnue,
   count(distinct case when primary_product_id=1 then order_id else null end) as product_1_sessions,
   count(distinct case when primary_product_id=2 then order_id else null end) as product_2_sessions
   from orders
   where created_at between '2012-04-01' and '2013-04-05'
   group by 1,2


create temporary table numb_sites10
select website_session_id,
 case 
when created_at between '2012-10-6' and '2013-01-06'  then 'pre_produ'
when created_at between '2013-01-06' and '2013-04-06' then 'post_produ'
end as time_period,
count(website_pageview_id) as num_sites_visited,
pageview_url
from website_pageviews
where created_at between '2012-10-6' and '2013-04-06'
group by 1

create temporary table numb_sites11
select time_period,count(distinct website_session_id) as sessions,
count(case when num_sites_visited>1 then website_session_id else null end) as ses_nex_pg
from numb_sites10
group by 1


create temporary table fuzzy_bear_10
select 
case 
when created_at between '2012-10-6' and '2013-01-06'  then 'pre_produ'
when created_at between '2013-01-06' and '2013-04-06' then 'post_produ'
end as time_period,
count(distinct case when pageview_url='/the-original-mr-fuzzy' then website_session_id else null end) as fuzzy_seasons,
count(distinct case when pageview_url='/the-forever-love-bear' then website_session_id else null end) as lov_ber_seasons
from website_pageviews
where created_at <'2013-04-06'
and  created_at >'2012-10-06'
group by 1

select numb_sites11.time_period,numb_sites11.sessions,numb_sites11.ses_nex_pg,
fuzzy_bear_10.fuzzy_seasons,fuzzy_bear_10.lov_ber_seasons
from fuzzy_bear_10
inner join  numb_sites11 on 
fuzzy_bear_10.time_period=numb_sites11.time_period


















