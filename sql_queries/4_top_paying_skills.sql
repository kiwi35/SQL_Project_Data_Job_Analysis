/*
Highest-paying skills for Data Analyst roles.

Purpose:
- Identify the skills associated with the highest average salaries for Data Analyst positions.
- Analyze how different technical skills correlate with salary levels.

Method:
- Join job_postings_fact with skills_job_dim to map job postings to their required skills.
- Join skills_dim to retrieve readable skill names.
- Calculate the average salary associated with each skill.
- Group results by skill and rank skills based on average salary in descending order.

Insight:
- Specialized technical skills such as programming languages, cloud platforms, big data technologies, and machine learning tools appear among the highest-paying skills.
- Foundational Data Analyst skills like SQL, Python, and Excel are widely used but generally have lower average salaries compared to niche technologies.
- Some high-paying skills may represent specialized roles or smaller groups of job postings, so salary values should be interpreted alongside demand and job volume.
- The analysis helps identify skills that are associated with higher compensation and can guide future skill development decisions.
*/

SELECT skills, Round(avg(salary_year_avg),0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE  job_title_short = 'Data Analyst' AND
       salary_year_avg IS NOT NULL
Group by skills
order by avg_salary DESC;