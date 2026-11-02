-- Xom Data · A three-digit code says it all
-- Problem: https://xomdata.com/practice/hard-rfm-004
-- Solved: 2026-11-02

 with s as (
    select 
        customer_id,
        max(order_date) as recency,
        count(order_id) as frequency,
        sum(amount) as monetary
    from orders
    group by 1 
 ),
 f as (
    select 
        customer_id,
        cast(6- ntile(5)over(order by recency desc,customer_id asc) as text) as r,
        cast(6- ntile(5)over(order by frequency desc,customer_id asc) as text) as f,
        cast(6- ntile(5)over(order by monetary desc,customer_id asc) as text) as m
    from s 
 )


 select 
    customer_id,
    r || f || m as rfm_code
 from f
order by rfm_code desc, customer_id
