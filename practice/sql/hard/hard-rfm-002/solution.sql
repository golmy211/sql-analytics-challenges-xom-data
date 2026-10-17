-- Xom Data · Assigning customers to the right care segment
-- Problem: https://xomdata.com/practice/hard-rfm-002
-- Solved: 2026-10-17

 with s as (   
    select 
        customer_id,
        '2024-06-30'::date - max(order_date)::date as days_since,
        count(*) as order_count
    from orders
    where order_date <= '2024-06-30' 
    group by 1 
)

    select 
        customer_id,
        days_since,
        order_count,
        case 
            when days_since <= 60 and order_count >= 3 then 'Champions'
            when days_since > 60 and order_count >= 3 then 'At Risk'
            when days_since <= 60 and order_count < 3 then 'Promising'
            else 'Hibernating'
            end as segment
        from s
