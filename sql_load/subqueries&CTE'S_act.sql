-- 1.)"Find all jobs that pay more than the average salary" --
SELECT job_title_short, salary_year_avg
FROM job_postings_fact
WHERE
    salary_year_avg > ( 
        SELECT AVG(salary_year_avg)
        FROM job_postings_fact
    );

-- 2.) "List all companies that posted jobs requiring SQL"

SELECT DISTINCT name
FROM company_dim 
WHERE company_id IN (
    SELECT company_id
    FROM job_postings_fact
    WHERE job_id IN (
         SELECT job_id
         FROM skills_job_dim
         WHERE skill_id IN ( 
             SELECT skill_id
             FROM skills_dim
             WHERE skills ILIKE '%SQL%'
         )
    )
)
ORDER BY name;

-- CTE version of the above query
WITH sql_jobs AS (
    SELECT job_id
    FROM skills_job_dim
    WHERE skill_id IN (
        SELECT skill_id
        FROM skills_dim
        WHERE skills ILIKE '%SQL%' 
)
    ),
companies_with_sql_jobs AS (
    SELECT DISTINCT company_id
    FROM job_postings_fact
    WHERE job_id IN (
        SELECT job_id
        FROM sql_jobs
    )
)
SELECT DISTINCT name
FROM company_dim
WHERE company_id IN ( 
    SELECT company_id
    FROM companies_with_sql_jobs
)
ORDER BY name;

-- 3.) Find jobs that requires MORE skills than the average number of skills per job"

SELECT * FROM job_postings_fact
WHERE job_id IN (
    SELECT job_id
    FROM skills_job_dim
    GROUP BY job_id
    HAVING COUNT(skill_id > (
        SELECT AVG(skill_count)
        FROM (
            SELECT job_id, COUNT(skill_id) AS skill_count
            FROM skills_job_dim
            GROUP BY job_id
        ) AS job_skill_counts
    )));


