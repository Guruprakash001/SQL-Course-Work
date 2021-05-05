SET GLOBAL max_allowed_packet = 1073741824;
use mavenfuzzyfactory;
create temporary table first_created
select min(created_at) as first_created,pageview_url
from website_pageviews
where pageview_url='/home'
or pageview_url='/lander-1'
group by pageview_url

create temporary table lan_num_sites_2
select wep.website_session_id,min(wep.website_pageview_id) as l_pg,count(wep.website_pageview_id) as num_pg,wep.pageview_url
from website_pageviews wep
inner join website_sessions wes
on wes.website_session_id=wep.website_session_id
where wes.created_at <'2012-07-28'
and website_pageview_id>=23504
and wes.utm_source='gsearch'
and wes.utm_campaign='nonbrand'
group by website_session_id ;

select * from lan_num_sites2

create temporary table boun_sess_2
select count(website_session_id) as boun_sessions,pageview_url
from lan_num_sites_2
where num_pg=1
group by pageview_url

create temporary table tot_sess2
select count(website_session_id) as boun_sessions,pageview_url
from lan_num_sites_2
group by pageview_url

select bo.boun_sessions,tot.boun_sessions as tot_sessions,
bo.boun_sessions/tot.boun_sessions as bou_rt
from tot_sess2 tot
left join boun_sess_2 bo
on tot.pageview_url=bo.pageview_url




