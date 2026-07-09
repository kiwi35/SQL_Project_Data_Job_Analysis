/*
Top 10 most in-demand skills for Data Analyst roles.
-Counts how many job postings require each skill, then ranks skills by frequency.
-Joins: skills_job_dim links job postings to skill IDs; skills_dim translates 
 skill IDs into skill names.
-Why? To help job seekers see which skills appear most frequently in postings for 
 their desired role.
*/
SELECT skills, count(*) as count_
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE  job_title_short = 'Data Analyst' 
Group by skills
order by count_ DESC
Limit 10;