/*
Fetch skills associated with the highest-paying jobs for a selected role.
-Retrieves one row per skill for each of the top 100 highest-paying Data Analyst 
 postings (job-skill pairs, not yet aggregated).
-Note: salary/company repeat across rows since each row is one job-skill pair 
 (e.g. a job with 5 skills appears as 5 rows).
-Top 100 chosen over top 10 for a broader, less outlier-prone sample. A percentage-based 
 cutoff (e.g. top 1%) was considered but rejected, since posting counts vary widely by 
 role — a percentage would yield inconsistent sample sizes depending on how common 
 the role is.
-Why? This raw data feeds further aggregation to identify which skills appear most 
 among top-paying postings, helping job seekers prioritize what to learn.
-For the aggregated, visual breakdown, see the Power BI dashboard in this project.
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

