/*Question:What are the most optimal skills to learn(aka in high demand and a high paying skill)
-Identify skills in high demand and associated with high avg salaries for Data scientist roles.
-Concentrate on remote positions with specified salaries.
-Why?Targets skills that offer that offer job security(high demand) and 
financial benefits(high salaries),offering strategic insights for career deployment in data analysis
*/

WITH skills_demand AS (
    SELECT
        sjd.skill_id,
        sd.skills,
        COUNT(sjd.job_id) AS demand_count
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd
        ON sjd.skill_id = sd.skill_id
    WHERE
        jpf.job_title_short = 'Data Scientist'
        AND jpf.job_work_from_home = TRUE
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY
        sjd.skill_id,
        sd.skills
),

average_salary AS (
    SELECT
        sjd.skill_id,
        ROUND(AVG(jpf.salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd
        ON jpf.job_id = sjd.job_id
    WHERE
        jpf.job_title_short = 'Data Scientist'
        AND jpf.job_work_from_home = TRUE
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY
        sjd.skill_id
)

SELECT
    sd.skill_id,
    sd.skills,
    sd.demand_count,
    asal.avg_salary
FROM skills_demand sd
INNER JOIN average_salary asal
    ON sd.skill_id = asal.skill_id
WHERE
     sd.demand_count > 10
ORDER BY
    sd.demand_count DESC,
    asal.avg_salary DESC
LIMIT 25;