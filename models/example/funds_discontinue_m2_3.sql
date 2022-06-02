with mutual_fund_first as (select code, sum(nav) as sum_nav_first from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."NAV_HISTORY" where nav_date = '2018-12-01'
group by code),
mutual_fund_last as (select code, sum(nav) as sum_nav_last from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."NAV_HISTORY" where nav_date = '2019-02-28'
group by code),
calculate_performance as (
select mutual_fund_last.code as cal_code, ((mutual_fund_last.sum_nav_last - mutual_fund_first.sum_nav_first)/mutual_fund_first.sum_nav_first)*100 as cal from
mutual_fund_last inner join mutual_fund_first on mutual_fund_first.code = mutual_fund_last.code order by cal desc
)
select name from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."MUTUAL_FUNDS" as mutual_fund inner join calculate_performance on mutual_fund.code = calculate_performance.cal_code
where calculate_performance.cal < 0
order by calculate_performance.cal desc