-- same database of multi level grouping exercise 
/*Exercise  1: Basic HAVING Clause

Find all departments that have more than 2 employees.
Expected Output: department, employee_count*/
Select department, count(*) employee_count From employee
group by department 
having count(*)  > 2
/*
Exercise 2 
Find departments that have more than 2 employees AND an average salary greater than $80,000.
Expected Output: department, employee_count, avg_salary
*/
Select department, count(*) employee_count , avg(salary) avg_salary From employee
group by department 
having count(*)  > 2 and avg(salary) > 80000
/*Exercise 3
Find departments whose average salary is higher than the company's overall average salary.
Expected Output: department, avg_salary*/
Select department,  avg(salary) avg_salary From employee
group by department 
having  avg(salary) > (select avg(salary) From employee)

/*
Exercise 4
Find departments that rank in the top 3 for average salary.
Expected Output: department, avg_salary, salary_rank
*/
Select  top 3  department,  avg(salary) avg_salary, RANK() over (order by avg(salary) desc)salary_rank
From employee
group by department 
order by avg(salary)  desc
