 SELECT 
    department,
    COUNT(*) as total_employees,
    ROUND(AVG(salary), 2) as avg_salary,
    MAX(salary) as max_salary,
    SUM(CASE WHEN hire_date > '2019-12-31' THEN 1 ELSE 0 END) as recent_hires,
    ROUND(
        (SUM(CASE WHEN age > 30 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 
        2
    ) as pct_over_30
FROM employee
GROUP BY department
HAVING AVG(salary) > 70000
ORDER BY department;
