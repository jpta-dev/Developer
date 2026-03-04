SELECT
    company_dim.name AS company_name,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date
FROM 
    job_postings_fact
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    EXTRACT(QUARTER FROM job_postings_fact.job_posted_date) = 2
    AND EXTRACT(YEAR FROM job_postings_fact.job_posted_date) = 2023
    AND job_health_insurance = TRUE;