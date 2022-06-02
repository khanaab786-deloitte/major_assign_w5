with
first_month as (select code as c,sum(nav) as first_nav from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."NAV_HISTORY"
where nav_date='2018-12-01'
group by code
),
last_month as (select code as c,sum(nav) as last_nav from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."NAV_HISTORY"
where nav_date='2019-02-28'
group by code
),
calculate_performance as (select first_month.c as fm, ((last_month.last_nav-first_month.first_nav)/first_month.first_nav)*100 as cal
from last_month inner join first_month on last_month.c = first_month.c
order by cal desc
),
best as (select c.cal as best_cal, mf.name as best_funds from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."MUTUAL_FUNDS" as mf inner join calculate_performance as c on c.fm = mf.code
order by cal desc limit 1
),
worst as (select c.cal as worst_cal, mf.name as worst_funds from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."MUTUAL_FUNDS" as mf inner join calculate_performance as c on c.fm = mf.code
order by c.cal asc limit 1
)

select best.best_cal as CAGR_Value,best.best_funds as Best_Worst_Funds from best
union
select worst.worst_cal, worst.worst_funds from worst