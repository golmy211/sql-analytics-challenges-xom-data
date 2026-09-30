-- Xom Data · Accounts with no posts
-- Problem: https://xomdata.com/practice/medium-leftjoin-096
-- Solved: 2026-09-30

select 
    u.full_name,
    u.username,
    u.account_type,
    row_number()over(
        order by u.created_at asc,u.username asc
    ) as signup_order,
    ntile(4)over(
        order by u.created_at asc
    ) as tenure_quartile
from users u
where not exists (
    select 1
    from posts p1
    where u.id = p1.user_id
)
order by signup_order asc
