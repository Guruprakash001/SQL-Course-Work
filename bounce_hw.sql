create temporary table land_sites2
select website_session_id,min(website_pageview_id) as l_pg_id,count(website_pageview_id) as no_of_sites,pageview_url
from website_pageviews
where created_at<'2012-06-14'
group by 1;

select * from land_sites2

select lan.website_session_id,


create temporary table tot_sessions
select pageview_url,count(no_of_sites) as tot_sessions
from land_sites2
group by pageview_url

create temporary table boun_sessions2
select pageview_url,count(no_of_sites) as boun_sessions
from land_sites2
where no_of_sites=1
group by pageview_url

create temporary table boun_rate
select tot.tot_sessions,bou.boun_sessions,bou.boun_sessions/tot.tot_sessions as bounce_rate
from tot_sessions tot
inner join boun_sessions2 bou
on tot.pageview_url=bou.pageview_url
