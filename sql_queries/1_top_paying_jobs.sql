/*
What are the top paying jobs for a given role?
-Identifies the top paying jobs for a given role by analyzing the job postings data. 
-Why? To help job seekers identify high-paying opportunities in their desired field.
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
    job_title_short = 'Data Analyst' AND   -- Replace with desired role (see README for available roles)
    salary_year_avg IS NOT NULL AND 
    job_location = 'Anywhere'              -- Replace 'Anywhere'(Remote||Work From Home) with the desired location
ORDER BY
    salary_year_avg DESC
LIMIT
    10;                                    -- Replace 10 with the desired number of results
