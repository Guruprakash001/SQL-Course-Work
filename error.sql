SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
create temporary table l_pges4
select web.website_session_id,web.pageview_url as l_pg,min(web.website_pageview_id) as l_pg_id,count(web.website_pageview_id)
date(wes.created_at) as date,week(wes.created_at) as st_wk
from website_pageviews web
left join website_sessions wes
on web.website_session_id=wes.website_session_id
where wes.created_at > '2012-06-01'
and wes.created_at<'2012-08-31'
and wes.utm_source='gsearch'
and wes.utm_campaign='nonbrand'
group by web.website_session_id

select  home_sessions,lander1_sessions,boun_home_sessions,boun_lander1_sessions from(
select min(date) as st_dt,
count(case when l_pg='/lander-1' then '/lander-1' else null end) as home_sessions,
count(case when l_pg='/home' then '/home' else null end) as lander1_sessions,
count(case when l_pg='/home' and num_pg=1 then l_pg else null end) as boun_home_sessions,
count(case when l_pg='/lander-1' and num_pg=1 then l_pg else null end) as boun_lander1_sessions 
from l_pges3
group by st_wk
) as temp


-- select *
-- from website_pageviews
-- where created_at>'2012-06-01'
