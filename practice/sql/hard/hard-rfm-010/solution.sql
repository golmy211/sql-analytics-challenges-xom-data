-- Xom Data · The map of eleven customer tribes
-- Problem: https://xomdata.com/practice/hard-rfm-010
-- Solved: 2026-11-18

 with s as (
    select 
        customer_id,
        max(order_date) as r,
        count(*) as f 
    from orders 
    GROUP BY 1 
 ),
 f as (
    SELECT
        customer_id,
        6- ntile(5)over(order by r desc,customer_id) as r_score,
        6 - ntile(5)over(order by f desc,customer_id) as f_score
    from s 
 )
 select 
    case 
        when r_score = 5 and f_score >= 4 then 'Champions'
        when r_score >= 4 and f_score >= 3 then 'Loyal'
        when r_score >=4 and f_score >= 1 then 'Potential Loyalist'
        when r_score = 3 and f_score >= 4 then 'Need Attention'
        when r_score = 3 and f_score >= 2 then 'About To Sleep' 
        when r_score = 3  then 'Promising'
        when r_score = 2 and f_score >= 4 then 'At Risk'
        when r_score = 2 and f_score >= 2 then 'Hibernating'
        when r_score = 2  then 'Lost Cheap'
        when r_score = 1 and f_score >= 3 then 'Cannot Lose Them' 
        else 'Lost'
        end as segment,
    count(*) as customer_count
 from f
 group by 1
 order by customer_count desc, segment
