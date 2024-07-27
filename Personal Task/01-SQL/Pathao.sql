SELECT name
FROM sqlite_master
WHERE type='Table';

-- TABLE 1: calls
SELECT * 
FROM calls;

PRAGMA table_info(calls);

-- Table 2: call_statuses
SELECT *
FROM call_statuses;

PRAGMA table_info(call_statuses);

-- Table 3: counters
SELECT *
FROM counters;

PRAGMA table_info(counters);

-- Table 5: jobs
SELECT *
FROM jobs;

PRAGMA table_info(jobs);

-- TABLE 6: languages
SELECT *
FROM languages;

PRAGMA table_info(languages);

-- TABLE 7: permissions
SELECT *
FROM permissions;

PRAGMA table_info(permissions);

-- TABLE 8: queues
SELECT *
FROM queues;

SELECT COUNT(*) as total_row
FROM queues;

PRAGMA table_info(queues);

-- TABLE 9: roles
SELECT *
FROM roles;

PRAGMA table_info(roles);

--TABLE 10: role_has_permissions;
SELECT *
FROM role_has_permissions;

PRAGMA table_info(role_has_permissions);

-- TABLE 11: services
SELECT COUNT(*) AS Total_rows
FROM services;

SELECT *
FROM services;

PRAGMA table_info(services);

-- TABLE 12: sqlite sequences
SELECT *
FROM sqlite_sequence;

PRAGMA table_info(sqlite_sequence);

-- TABLE 13: users
SELECT *
FROM users;

PRAGMA table_info(users);



/* Write a SQL query to get a summary of counters for any given date, including the total queue 
called, serving, served, and no-show.
*/ 

SELECT 
    c.id AS counter_id,
    c.name AS counter_name,
    SUM(CASE WHEN DATE(ca.called_date)='2024-02-14' THEN q.called ELSE 0 END) AS total_queue_called,
    COUNT(CASE WHEN DATE(ca.called_date)='2024-02-14'
        AND ca.started_at IS NOT NULL
        AND ca.ended_at IS NULL
        THEN 1 ELSE NULL END) AS serving,
    COUNT(CASE WHEN cs.name='served' THEN 1 ELSE NULL END) AS served,
    COUNT(CASE WHEN cs.name='noshow' THEN 1 ELSE NULL END) AS total_no_show
FROM
    counters c 
LEFT JOIN
    calls AS ca ON c.id = ca.counter_id
LEFT JOIN
    call_statuses AS cs ON ca.call_status_id = cs.id
LEFT JOIN
    queues AS q ON ca.queue_id = q.id
WHERE
    DATE(ca.called_date)= '2024-02-14'
GROUP BY c.id, c.name;




/* Write an SQL query to get a summary of services for any given date, 
including the total visitors, queued, called, serving, served and no-show. 
*/
SELECT
    s.id AS service_id,
    s.name AS service_name,
    COUNT(DISTINCT ca.user_id) AS total_visitors,
    SUM(CASE WHEN j.queue THEN 1 ELSE NULL END) AS totalqueued,
    SUM(CASE WHEN q.called THEN 1 ELSE NULL END) AS total_called,
    COUNT(CASE 
        WHEN DATE(ca.called_date) = '2024-02-14'
            AND ca.started_at IS NOT NULL
            AND ca.ended_at IS NULL
        THEN 1 ELSE NULL 
    END) AS serving,
    COUNT(CASE WHEN cs.name = 'served' THEN 1 ELSE NULL END) AS served,
    COUNT(CASE WHEN cs.name = 'noshow' THEN 1 ELSE NULL END) AS total_no_show
FROM
    services AS s 
LEFT JOIN
    calls AS ca ON s.id = ca.service_id
LEFT JOIN
    call_statuses AS cs ON ca.call_status_id = cs.id
LEFT JOIN
    queues AS q ON ca.queue_id = q.id
LEFT JOIN
    jobs AS j ON q.id = j.queue -- Assuming jobs table links to queues by the queue ID
WHERE
    DATE(ca.called_date) = '2024-02-14'
GROUP BY
    s.id, s.name;


/* Write an SQL query to get a detailed summary of counters and services for any given date. */
SELECT
    c.id AS counter_id,
    c.name AS counter_name,
    s.id AS service_id,
    s.name AS service_name,
    COUNT(DISTINCT ca.user_id) AS total_visitors,
    SUM(CASE WHEN j.queue THEN 1 ELSE NULL END) AS total_queued,
    SUM(CASE WHEN q.called THEN 1 ELSE NULL END) AS total_called,
    COUNT(CASE 
        WHEN DATE(ca.called_date) = '2024-02-14'
            AND ca.started_at IS NOT NULL
            AND ca.ended_at IS NULL
        THEN 1 ELSE NULL 
    END) AS serving,
    COUNT(CASE WHEN cs.name = 'served' THEN 1 ELSE NULL END) AS served,
    COUNT(CASE WHEN cs.name = 'noshow' THEN 1 ELSE NULL END) AS total_no_show
FROM
    services AS s 
LEFT JOIN
    calls AS ca ON s.id = ca.service_id
LEFT JOIN
    call_statuses AS cs ON ca.call_status_id = cs.id
LEFT JOIN
    queues AS q ON ca.queue_id = q.id
LEFT JOIN
    jobs AS j ON q.id = j.queue 
LEFT JOIN
    counters AS c ON ca.counter_id = c.id
WHERE
    DATE(ca.called_date) = '2024-02-14'
GROUP BY
    c.id, c.name, s.id, s.name;

/* Write an SQL query to get a summary of agents for any given date,
including the total visitors, queued, called, serving, served, and no-show.*/
SELECT 
    u.id AS agent_id,
    u.name AS agent_name,
    COUNT(ca.id) AS total_visitors,
    SUM(CASE WHEN ca.call_status_id IS NULL THEN 1 ELSE NULL END) AS queued,
    SUM(CASE WHEN ca.call_status_id IS NOT NULL THEN 1 ELSE NULL END) AS called,
    SUM(CASE WHEN ca.call_status_id = 1 THEN 1 ELSE 0 END) AS serving,
    SUM(CASE WHEN cs.name = 'served' THEN 1 ELSE NULL END) AS served,
    SUM(CASE WHEN cs.name = 'noshow' THEN 1 ELSE NULL END) AS no_show
FROM 
    users AS u
LEFT JOIN 
    calls AS ca ON u.id = ca.user_id
LEFT JOIN 
    call_statuses AS cs ON ca.call_status_id = cs.id
WHERE 
    ca.called_date = '2024-02-14'
GROUP BY 
    u.id, u.name;
