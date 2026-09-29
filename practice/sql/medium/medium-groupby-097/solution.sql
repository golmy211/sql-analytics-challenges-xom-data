-- Xom Data · Top 10 most-engaged posts
-- Problem: https://xomdata.com/practice/medium-groupby-097
-- Solved: 2026-09-29

with t as (
    select
        u.full_name,
        p.post_type,
        p.post_date,
        p.like_count + p.comment_count + p.share_count as total_interactions
    from users u
    join posts p on u.id = p.user_id
)
select
    full_name,
    post_type,
    post_date,
    total_interactions,
    rank() over (order by total_interactions desc) as overall_rank,
    row_number() over (
        partition by full_name
        order by total_interactions desc, post_date asc
    ) as rank_in_author,
    round(100.0 * total_interactions / max(total_interactions) over (), 2) as pct_of_top
from t
order by overall_rank asc, full_name asc, rank_in_author asc
limit 10;
