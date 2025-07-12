-- same database of exercise 1 
SELECT  department, sum( case when salary < 70000 then 1 else 0 end) as low_salary_count, 
      sum(case when salary between 70000 and  79999 then 1 else 0 end) as medium_salary_count, 
	 sum( case when salary >= 80000 then 1 else 0 end) as high_salary_count ,
      avg( case when salary < 70000 then age else null end) as avg_age_low, 
    avg(case when salary between 70000 and  79999 then age else null end) as avg_age_medium ,
	 avg( case when salary >= 80000 then  age else null end) as avg_age_high,
	 max(salary)- min(salary) salary_spread
	 FROM employee
	group by department
