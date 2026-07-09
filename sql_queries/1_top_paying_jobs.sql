/*
What are the top paying jobs for a given role?
-Identifies the top paying jobs for a given role (Data Analyst, in this case) by analyzing 
 the job postings data.
-Why? To help job seekers identify high-paying opportunities in their desired field.
-Role, location, and result count are hardcoded below, but can be swapped out to 
 re-run this analysis for a different role, location, or top-N.
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
