/*
Skills required for the top 100 highest-paying Data Analyst jobs.

Purpose:
- Retrieve the skills associated with the highest-paying Data Analyst job postings.

Method:
- Select the top 100 Data Analyst postings by average yearly salary.
- Join with skills_job_dim to map jobs to their required skills.
- Join with skills_dim to retrieve skill names.
- Return one row per job-skill pair.

Notes:
- Salary and company information repeat because each row represents a single skill linked to a job.
- A fixed sample of the top 100 jobs provides a broader and more consistent dataset than using only the top 10 or a percentage-based cutoff, whose size varies with the number of available postings.

Insight:
- This query serves as the raw dataset for identifying which skills appear most frequently in high-paying Data Analyst roles.
- The aggregated results are visualized in the project's Power BI dashboard.
*/
WITH
    -- Top 100 highest-paying Data Analyst postings
    top_paying_jobs AS (
        SELECT
            job_id,
            job_title,
            salary_year_avg,
            NAME AS company_name
        FROM
            job_postings_fact
            LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
        WHERE
            job_title_short = 'Data Analyst' -- role analyzed here
            AND salary_year_avg IS NOT NULL
        ORDER BY
            salary_year_avg DESC
        LIMIT
            100
    )
-- Join top-paying postings with their required skills
SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id      
ORDER BY
    salary_year_avg DESC;

