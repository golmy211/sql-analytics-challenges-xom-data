-- Xom Data · Article URLs from headlines
-- Problem: https://xomdata.com/practice/easy-replace-001
-- Solved: 2026-09-24

-- Write your SQL here
select 
    title,
    replace(title, ' ', '-') as url_slug
from articles
