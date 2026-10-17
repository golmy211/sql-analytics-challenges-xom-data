-- Xom Data · Each channel's poster child
-- Problem: https://xomdata.com/practice/hard-rfm-009
-- Solved: 2026-10-17

with r as(
    
    select 
        c.channel,
        o.customer_id,
        6 - ntile(5) over (order by max(o.order_date) desc, o.customer_id asc) as recency,
        6 - ntile(5) over (order by count(o.order_id) desc, o.customer_id asc) as frequency,
        6 - ntile(5) over (order by sum(o.amount) desc, o.customer_id asc) as monetary
    from customers c
    join orders o on c.customer_id = o.customer_id 
     where o.order_date <= '2024-06-30'
    group by 1,2
),
rfm as (
    select 
        channel,
        customer_id,
        recency + frequency + monetary as rfm_total,
        row_number() over(
            partition by channel
            order by recency + frequency + monetary desc, customer_id 
        ) as rn 
    from r
    order by channel asc
)

select 
    channel, 
    customer_id,
    rfm_total
from rfm 
where rn = 1
order by customer_id asc
