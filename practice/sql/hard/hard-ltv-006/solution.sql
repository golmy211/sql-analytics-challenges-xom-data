-- Xom Data · Which customer segment really feeds the store
-- Problem: https://xomdata.com/practice/hard-ltv-006
-- Solved: 2026-10-24

with s as (

    select 
        customer_id,
        max(order_date) as r,
        count(order_id) as f,
        sum(amount) as revenue
    from orders 
    group by 1
),
agg as (
    
    select 
        customer_id,
        6-ntile(5) over(
            order by r desc, customer_id asc 
        ) as r_score, 
        6-ntile(5)over(
            order by f desc, customer_id asc
        ) as f_score, 
        revenue
    from s 
)

    select 
        case when r_score >= 4 and f_score >= 4 then 'Champions'
            when r_score >= 4 then 'Recent'
            when f_score >= 4 then 'At Risk'
            else 'Others'
            end as segment,
        count(customer_id) as customers,
        sum(revenue) as total_revenue,
        round(sum(revenue)/count(customer_id),2) as avg_ltv  
    from agg 
    group by 1 
    order by avg_ltv desc, segment asc
