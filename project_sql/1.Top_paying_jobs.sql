/*Question:What are the top paying data scientist jobs?
-Identify the top 10 highest-paying Data scientist roles that are available remotely.
-Focuses on job postings with speciied salaries(remove nulls).
-Why?Highlight the top payig opportunities for Data Scientists,offering insights into employment
*/
SELECT
    j.job_id,
    j.job_title,
    j.job_location,
    j.job_schedule_type,
    j.salary_year_avg,
    j.job_posted_date,
    c.name
FROM job_postings_fact j
LEFT JOIN company_dim c ON j.company_id = c.company_id
WHERE 
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;
