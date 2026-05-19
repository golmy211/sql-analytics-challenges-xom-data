-- Xom Data · Patients without a health-insurance declaration
-- Problem: https://xomdata.com/practice/easy-isnull-002
-- Solved: 2026-05-19

-- Viết query của bạn ở đây
SELECT full_name
FROM patients
WHERE health_insurance is NULL
