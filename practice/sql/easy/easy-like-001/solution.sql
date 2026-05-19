-- Xom Data · Basic-plan subscribers
-- Problem: https://xomdata.com/practice/easy-like-001
-- Solved: 2026-05-19

-- Viết query của bạn ở đây
SELECT phone_number,full_name,plans
FROM subscribers
WHERE plans LIKE '%Basic%';
