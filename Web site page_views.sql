-- select pageview_url,count(distinct(website_pageview_id))
-- from website_pageviews
-- where created_at<'2012-06-09'
-- group by pageview_url; 
select *
from website_pageviews