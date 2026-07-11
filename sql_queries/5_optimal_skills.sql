/*
Optimal skills for Data Analyst roles based on demand and salary.

Purpose:
- Identify skills that provide a strong balance between market demand and earning potential for Data Analyst positions.
- Focus on skills with sufficient demand to highlight opportunities that are both financially rewarding and relevant in the job market.

Method:
- Join job_postings_fact with skills_job_dim to map job postings to their required skills.
- Join skills_dim to retrieve readable skill names.
- Calculate the average salary and demand count for each skill.
- Store the aggregated results in a Common Table Expression (CTE).
- Filter skills whose demand is greater than or equal to the average demand across all skills.
- Rank the remaining skills by average salary in descending order.

Insight:
- Specialized technologies such as Spark, Snowflake, Hadoop, and cloud platforms tend to provide higher salary potential while maintaining meaningful market demand.
- Skills like Python and SQL stand out as strong career choices due to their combination of high demand and competitive salaries.
- Visualization and BI tools such as Tableau and Power BI remain highly relevant, offering strong demand with moderate salary levels.
- Filtering by demand helps remove skills with limited job availability and highlights skills that provide a better balance between career opportunities and financial benefits.
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