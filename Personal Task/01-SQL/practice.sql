SELECT name 
FROM sqlite_master
WHERE type = 'table';

PRAGMA table_info(calls);

PRAGMA table_info(call_statuses);

SELECT * FROM calls;

-- DROPPONG table if exists
DROP TABLE IF EXISTS job_got;

-- Creating table SQL with Foreign Key
CREATE TABLE job_got (
    job_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    date_job_got DATETIME NOT NULL,
    date_appointed DATETIME NOT NULL,
    salary REAL,
    FOREIGN KEY (job_id) REFERENCES jobs(id)
);

-- Getting any table information using PRAGMA
PRAGMA table_info(job_got);

-- Inserting Into table name all columns at one time.
INSERT INTO job_got (name, date_job_got, date_appointed, salary)
VALUES ('Prabin Thapa', '2024-08-07 01:30:23', '2024-08-15 01:30:23', 20000);

-- Selecting everuthing from a certain column
SELECT * 
FROM job_got;

-- Viewing table names involve in the database
SELECT name
FROM sqlite_master
WHERE type = 'table';

PRAGMA table_info(counters);

-- Using where clause to see certain thing of the table
SELECT name, status, created_at, updated_at
FROM counters
WHERE id=1;

-- Using Three tables to get out information
SELECT
    c.id as counter_id,
    c.name as counter_number,
    COUNT(CASE WHEN cs.name = 'served' THEN 1 ELSE NULL END) AS total_served_per_counter,
    COUNT(CASE WHEN cs.name = 'noshow' THEN 1 ELSE NULL END) AS total_no_showed_per_counter
FROM 
    counters AS c
LEFT JOIN
    calls AS ca ON c.id = ca.counter_id
LEFT JOIN 
    call_statuses AS cs ON ca.call_status_id = cs.id
WHERE 
    DATE(ca.called_date) = '2024-02-14'
GROUP BY
    c.id, c.name;

SELECT * FROM counters;

-- ALTER in sqlite
-- ALTER TABLE job_got
-- ALTER COLUMN name TYPE varchar(191);
/* Altering in sqlite has some limitation it cannot alter the column
inside the table. For this we have to follow the series of process. */

-- In Command
SELECT c.id, c.name, c.created_at, c.updated_at
FROM counters AS c 
LEFT JOIN
    calls AS ca ON c.id = ca.counter_id
WHERE 
    ca.served_time IN (c.created_at, c.updated_at)
LIMIT 10;

-- Between Command
SELECT c.id, c.name, c.created_at, c.updated_at
FROM counters AS c 
LEFT JOIN
    calls AS ca ON c.id = ca.counter_id
WHERE 
    ca.served_time BETWEEN '2024-02-14' AND '2024-02-17'
LIMIT 10;


-- COUNT Command
SELECT COUNT(id)
FROM calls;

-- Finding Null values in SQL
SELECT * 
FROM calls
WHERE 
    queue_id IS NULL
    OR service_id IS NULL
    OR counter_id IS NULL
    OR user_id IS NULL
    OR token_letter IS NULL
    OR called_date IS NULL;

/* 