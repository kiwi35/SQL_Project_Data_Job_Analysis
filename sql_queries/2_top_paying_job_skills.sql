/*
Top skills associated with the highest-paying jobs for a selected role.

- Identifies the skills listed in the top-paying job postings for a chosen role.
- Uses CTEs and JOINs to connect job postings with their required skills.
- This analysis helps understand which skills appear in high-paying opportunities
  within a specific role.

The extracted data can be used to create visualizations showing the skills
associated with top-paying jobs. For a visual analysis of skill demand and
high-paying roles, refer to the Power BI dashboard included in this project.
*/
WITH
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
            job_title_short = 'Data Analyst' -- Replace with desired role (see README for available roles)
            AND salary_year_avg IS NOT NULL
        ORDER BY
            salary_year_avg DESC
        LIMIT
            10
    )
SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

