SELECT
    COUNT(*) AS num_job_postings,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'America/New_York') AS month
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'America/New_York') = 2023
GROUP BY month
ORDER BY num_job_postings DESC;