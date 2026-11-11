-- Xom Data · Next session with a higher price
-- Problem: https://xomdata.com/practice/nightmare-nextgreater-001
-- Solved: 2026-11-11

with s as (
    select 
        p1.day,
        p1.price,
        min(p2.day) as next_higher_day,
        min(p2.day) - p1.day as days_until
    from prices p1 
    left join prices p2 on p2.day > p1.day and p2.price > p1.price
    GROUP BY 1,2
)
select * from s order by 1
