 Expected Output Format
department total_employees avg_salary max_salary    recent_hires pct_over_30
Finance     3              80666.67   85000166.67   1            66.67
IT          3              75000.00   78000233.33   2            33.33

## 💡 Hints
- Use conditional aggregation with CASE statements
- Remember to filter departments using HAVING clause
- Calculate percentages using decimal division (multiply by 100.0)
- Use proper date comparison for "hired after 2019"

## 🔧 Key SQL Concepts
- GROUP BY with multiple aggregations
- HAVING clause for group filtering
- Conditional aggregation (SUM with CASE WHEN)
- Date comparisons
- Percentage calculations
