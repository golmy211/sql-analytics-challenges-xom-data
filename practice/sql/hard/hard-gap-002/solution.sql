-- Xom Data · The longest silence period for each customer
-- Problem: https://xomdata.com/practice/hard-gap-002
-- Solved: 2026-10-27

with s as (
    select 
        customer_id
    from orders 
    group by 1
    having count(*) >= 2 
),
a as (
    select 
        s.customer_id,
        o.order_date as gap_start,
        lead(o.order_date)over(
            partition by s.customer_id
            order by o.order_date asc
        ) as gap_end
    from s 
    join orders o on s.customer_id = o.customer_id
),
f as (
    select 
         customer_id,
         gap_start,
         gap_end,
         cast(gap_end as date) - cast(gap_start as date) as gap_days
    from a 
    where gap_end is not null 
    
),
r as (
    select 
        customer_id,
        gap_start,
        gap_end,
        gap_days,
        row_number()over(
            partition by customer_id
            order by gap_days desc, gap_start asc
        ) as rn 
    from f 
) 
    select 
        customer_id,
        gap_start,
        gap_end,
        gap_days 
    from r  
    where rn = 1
    order by gap_days desc, customer_id
