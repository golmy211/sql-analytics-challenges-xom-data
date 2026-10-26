-- Xom Data · YoY and QoQ sales growth
-- Problem: https://xomdata.com/practice/hard-yoy-001
-- Solved: 2026-10-26

 with s as ( 
    select 
        year,
        quarter,
        revenue,
        lag(revenue)over(
            order by year,quarter 
        ) as prev_quarter_revenue,
        lag(revenue,4)over(
            order by year,quarter 
        ) as prev_year_revenue
    from quarterly_sales
 ) 
    select 
        year,
        quarter,
        revenue,
        prev_quarter_revenue,
        prev_year_revenue,
        round(100.00*(revenue - prev_quarter_revenue)/nullif(prev_quarter_revenue,0),2) as qoq_pct,
        round(100.00*(revenue - prev_year_revenue)/nullif(prev_year_revenue,0),2) as yoy_pct
    from s 
    order by year, quarter
