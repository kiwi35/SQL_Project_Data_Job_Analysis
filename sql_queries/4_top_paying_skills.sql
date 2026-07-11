/*
Highest-paying skills for Data Analyst roles with sufficient market demand.

Purpose:
- Identify the skills associated with the highest average salaries for Data Analyst positions.
- Focus on skills with above-average demand to reduce the impact of salary outliers.

Method:
- Join job_postings_fact with skills_job_dim to map jobs to their required skills.
- Join skills_dim to retrieve readable skill names.
- Calculate the average salary and demand count for each skill.
- Store the aggregated results in a Common Table Expression (CTE).
- Filter skills whose demand is greater than or equal to the average demand across all skills.
- Rank the remaining skills by average salary in descending order.

Insight:
- Specialized technologies such as Spark, Snowflake, Hadoop, and cloud platforms tend to offer the highest average salaries.
- Core skills like Python and SQL provide a strong balance between high salaries and high market demand.
- Common tools such as Excel remain highly demanded but generally command lower average salaries than specialized technologies.
- Filtering by average demand produces more reliable salary comparisons by excluding skills that appear in only a small number of job postings.
*/

WITH skill_counts AS (
    SELECT
        skills,
        COUNT(*) AS demand_count,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        skills
)
SELECT
    skills,
    avg_salary,
    demand_count
FROM skill_counts
WHERE demand_count >= (
    SELECT AVG(demand_count)
    FROM skill_counts
)
ORDER BY
    avg_salary DESC;