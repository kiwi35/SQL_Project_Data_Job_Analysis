/*
Top 10 most in-demand skills for Data Analyst roles.

Purpose:
- Identify the skills that appear most frequently in Data Analyst job postings globally.

Method:
- Join job_postings_fact with skills_job_dim to map jobs to their required skills.
- Join skills_dim to retrieve readable skill names.
- Count the number of job postings associated with each skill.
- Rank skills by demand and return the top 10.

Insight:
- SQL is the most in-demand skill for Data Analyst roles, appearing in over 92,000 job postings, reinforcing its role as the core technical requirement for the profession.
- Excel and Python follow closely behind, showing that spreadsheet proficiency remains just as critical as programming ability for Data Analyst roles.
- Tableau and Power BI round out the top 5, highlighting the importance of data visualization and business intelligence skills alongside core technical competencies.
- R, SAS, PowerPoint, Word, and SAP complete the top 10, showing that statistical tools and general office software still play a meaningful role in Data Analyst job requirements.
*/
SELECT skills, count(*) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE  job_title_short = 'Data Analyst'
Group by skills
order by demand_count DESC
Limit 10;