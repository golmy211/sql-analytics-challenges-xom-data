-- Xom Data · Most common 3-step user path
-- Problem: https://xomdata.com/practice/hard-pathanalysis-001
-- Solved: 2026-11-16

 with s as(
    select 
        user_id,
        page,
        lead(page)over(PARTITION BY user_id order by viewed_at) as p2,
        lead(page,2)over(PARTITION BY user_id order by viewed_at) as p3 
    from page_views
 )
 select 
     page || ' ' || '>' || ' ' || p2 || ' ' || '>' || ' ' || p3 as path,
     count(*) as n_users
 from s
 where p3 IS NOT NULL
 group by 1
 order by n_users desc, path
 limit 10
