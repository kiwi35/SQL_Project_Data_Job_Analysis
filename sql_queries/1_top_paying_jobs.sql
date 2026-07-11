/*
Top-paying Data Analyst jobs in India.

Purpose:
- Identify the highest-paying Data Analyst job postings located in India.

Method:
- Filter Data Analyst postings with available salary data.
- Rank postings by average yearly salary.
- Return the top 10 highest-paying jobs.

Notes:
- The role, location, and result limit are hardcoded for this analysis but can be modified to analyze other roles, locations, or sample sizes.

Insight:
- Higher salaries are associated with senior and specialized Data Analyst roles rather than general entry-level positions.
- Industry specialization, particularly in finance, healthcare, and enterprise analytics, contributes to higher earning potential.
- Top-paying opportunities are concentrated among established global companies, reflecting strong investment in data-driven decision-making.
- Career progression through domain expertise and senior-level responsibilities appears to have a greater impact on salary than the job title "Data Analyst" alone.

*/
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    NAME AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND   -- role analyzed here
    salary_year_avg IS NOT NULL AND 
    job_location = 'India'              -- location analyzed here
ORDER BY
    salary_year_avg DESC
LIMIT
    10;                                    -- top 10 highest-paying postings
