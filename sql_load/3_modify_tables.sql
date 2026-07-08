/*
Data Loading Script

Note:
PostgreSQL COPY requires the database server to have access to the file path.
On Windows, this may fail due to file permissions or server-side access restrictions.

If COPY does not work, use pgAdmin's Import/Export Data feature to load the CSV files.

Update the file paths below according to your local dataset location.
*/

COPY company_dim
FROM 'path/to/csv_files/company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'path/to/csv_files/skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'path/to/csv_files/job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'path/to/csv_files/skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
