create temporary table IDK4
select website_session_id,min(website_pageview_id) as l_pg_id,pageview_url
from website_pageviews
group by website_session_id

select count(id.l_pg_id),id.pageview_url 
from IDK4 id
inner join website_pageviews we on
we.website_session_id=id.website_session_id
where we.created_at<'2012-06-12'
group by id.pageview_url;


select pageview_url,count(website_session_id)
from website_pageviews
where created_at<'2012-06-12'
group by pageview_url