create temporary table landingpage5
select min(wep.website_pageview_id) as l_pg_id,wep.pageview_url,wes.website_session_id
from website_pageviews wep
inner join website_sessions wes on
wes.website_session_id=wep.website_session_id
where date(wes.created_at) between '2014-01-01' and '2014-02-01'
group by wes.website_session_id

select wep.pageview_url,lan.website_session_id
from landingpage2 lan
left join website_pageviews wep
on lan.website_session_id=wep.website_session_id;

create temporary table sitesvisited
select count(wep.website_pageview_id) as no_of_sites_visited,wep.website_session_id,lan.pageview_url
from landingpage5 lan
left join website_pageviews wep 
on lan.website_session_id=wep.website_session_id
where created_at between '2014-01-01' and '2014-02-01'
group by lan.website_session_id;

create temporary table bouced_sites6
select count(no_of_sites_visited) as bounced_sites,pageview_url
from sitesvisited
where no_of_sites_visited=1
group by pageview_url;


create temporary table total_sites2
select count(no_of_sites_visited) as TotNo,pageview_url
from sitesvisited
group by pageview_url;

 






select * from total_sites
select * from bounced_sites2;
