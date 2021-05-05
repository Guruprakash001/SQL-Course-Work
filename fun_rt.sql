create temporary table pro_sessions_3
select website_session_id,website_pageview_id
from website_pageviews
where created_at between '2013-01-06' and '2013-04-10'
and pageview_url='/products'


create temporary table total_sessions5
select website_session_id,
max(saw_fuzzy) as seen_fuzzy,
max(saw_for_ber) as seen_ber,
max(saw_cart) as seen_car,
max(saw_shippi) as seen_shipping,
max(saw_billin) as seen_bill,
max(saw_thank_u) as seen_tanku
from(
select website_pageviews.website_session_id,
case when website_pageviews.pageview_url='/the-original-mr-fuzzy' then 1 else 0 end as saw_fuzzy,
case when website_pageviews.pageview_url='/the-forever-love-bear' then 1 else 0 end as saw_for_ber,
case when website_pageviews.pageview_url='/cart' then 1 else 0 end as saw_cart,
case when website_pageviews.pageview_url='/shipping' then 1 else 0 end as saw_shippi,
case when website_pageviews.pageview_url='/billing-2' then 1 else 0 end as saw_billin,
case when website_pageviews.pageview_url='/thank-you-for-your-order' then 1 else 0 end as saw_thank_u
from pro_sessions_3
inner join  website_pageviews  on 
pro_sessions_3.website_session_id=website_pageviews.website_session_id
and website_pageviews.website_pageview_id>pro_sessions_3.website_pageview_id
where website_pageviews.created_at between '2013-01-06' and '2013-04-10'
) as tot_ses6
group by 1


select
case
when seen_fuzzy=1 then 'fuzzy'
when seen_ber=1 then 'love_bear'
end as product_seen,
count(distinct(website_session_id)) as sessions,
count(distinct case when seen_car=1 then website_session_id else null end) AS cart_seasons,
count(distinct case when seen_shipping=1 then website_session_id else null end) AS shpping_seasons,
count(distinct case when seen_bill=1 then website_session_id else null end) AS billing_seasons,
count(distinct case when seen_tanku=1 then website_session_id else null end) AS thank_u_seasons
from total_sessions5
group by 1
