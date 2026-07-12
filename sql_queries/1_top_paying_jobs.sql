/*
Top-paying Data Analyst jobs.

Purpose:
- Identify the highest-paying Data Analyst job postings with available salary information.

Method:
- Filter Data Analyst postings with reported yearly salaries.
- Restrict results to job titles containing "Analyst", since job_title_short
  can sometimes include adjacent or misclassified roles.
- Rank postings by average yearly salary.
- Return the top 10 highest-paying Data Analyst jobs.

Notes:
- The role and result limit are hardcoded for this analysis but can be modified
  to analyze other roles or sample sizes.
- job_title_short is a pre-classified category and may not always perfectly
  represent the actual job title; adding a job_title filter improves relevance.
- This query is not location-restricted, so results span multiple countries and
  include both remote ("Anywhere") and on-site postings.

Insight:
- The top result ($650K, Mantys) is a notable outlier, nearly double the next-highest
  posting; excluding it, high-paying Data Analyst roles range from roughly $232K to $375K.
- Several high-paying positions are associated with senior or specialized titles,
  such as Senior Data Analyst, Principal Data Analyst, and Lead Data Analyst,
  suggesting that experience and scope of responsibility influence compensation.
- High-paying opportunities span multiple industries, including tech (Anthropic,
  TikTok, Pinterest, Walmart), staffing (Coda Search), and government-adjacent
  services (Illuminate Mission Solutions).
- Some extreme salary values may represent specialized roles, unique compensation
  structures, or outliers, so these results are more useful for identifying
  high-paying opportunities rather than defining a typical Data Analyst salary.
*/
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_title ILIKE '%analyst%' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;