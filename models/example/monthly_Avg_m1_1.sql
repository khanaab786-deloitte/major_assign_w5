select month(nav_date) as nav_month,code,avg(nav) as nav_avg, avg(repurchase_price) 
as repurchase_avg, avg(sale_price) as 
sale_avg from "MAJOR_ASSIGN"."MAJOR_SCHEMA"."NAV_HISTORY" group by code,nav_month