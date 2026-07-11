/*
Top 10 most in-demand skills for Data Analyst roles in India.

Purpose:
- Identify the skills that appear most frequently in Data Analyst job postings located in India.

Method:
- Join job_postings_fact with skills_job_dim to map jobs to their required skills.
- Join skills_dim to retrieve readable skill names.
- Count the number of job postings associated with each skill.
- Rank skills by demand and return the top 10.

Insight:
- SQL is the most in-demand skill for Data Analyst roles in India, appearing in over 3,100 job postings and reinforcing its role as a core technical requirement.
- Python, Excel, Tableau, and Power BI consistently rank among the most requested skills, highlighting the importance of programming, data analysis, and visualization capabilities.
- Cloud platforms such as Azure and AWS appear in the top 10, indicating a growing demand for Data Analysts with cloud computing knowledge.
- The results suggest that employers value a combination of database management, programming, visualization, and cloud skills, making a well-rounded technical skill set highly desirable.
*/
SELECT skills, count(*) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE  job_title_short = 'Data Analyst' AND
       job_country = 'India'
Group by skills
order by demand_count DESC
Limit 10;