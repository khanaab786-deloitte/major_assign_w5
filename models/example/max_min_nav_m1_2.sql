with in_date as (
select code, nav_date from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."NAV_HISTORY"
group by code, nav_date)

select nav_history.code,date.nav_date as date, max(nav) as max_nav, min(nav) as min_nav
from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."NAV_HISTORY" as nav_history
inner join in_date as date on date.code = nav_history.code
group by nav_history.code,date