# Documentation:
## Description about different tables with queries:
### Table1: calls
```markdown
Query:
```sql
SELECT *
FROM calls;

PRAGMA table_info(calls);
```
After execution:

| Column Name         | Data Type   | Not Null | Default Value       | Primary Key |
|---------------------|-------------|----------|---------------------|-------------|
| `id`                | integer     | Yes      | NULL                | Yes         |
| `queue_id`          | integer     | Yes      | NULL                | No          |
| `service_id`        | integer     | Yes      | NULL                | No          |
| `counter_id`        | integer     | Yes      | NULL                | No          |
| `user_id`           | integer     | Yes      | NULL                | No          |
| `token_letter`      | varchar(191)| Yes      | NULL                | No          |
| `token_number`      | integer     | Yes      | NULL                | No          |
| `called_date`       | date        | Yes      | NULL                | No          |
| `started_at`        | datetime    | No       | current_timestamp   | No          |
| `ended_at`          | datetime    | No       | NULL                | No          |
| `waiting_time`      | time        | No       | NULL                | No          |
| `served_time`       | time        | No       | NULL                | No          |
| `turn_around_time`  | time        | No       | NULL                | No          |
| `created_at`        | timestamp   | No       | NULL                | No          |
| `updated_at`        | timestamp   | No       | NULL                | No          |
| `call_status_id`    | integer     | No       | NULL                | No          |

#### Column Details:
- **id**: Primary key for the table. It is integer. Integer numbers are a number without decimal points.
- **queue_id**: It is also interger. It is a foreign key referencing the queue.
- **service_id**: It is also integer. It is a foreign key referencing the service.
- **counter_id**: It is a integer number. It is a foreign key for another table referencing the counter.
- **user_id**: It is also a integer number. It is a foreign key referencing the user.
- **token_letter**: This describes about the letter associated with the token. The data type of this column is varchar(191) which means the characters maxmimum length must be 191 and cannot be null.
- **token_number**: It is number associated with the token.
- **called_date**: Date when the token was called. It is date datatype. Date data type only includes year, month and day and exclude time information.
- **started_at**: When actually the service started. It is Timestamp datatype. It includes both data and time.
- **ended_at**: When the service ended. It is also Timestamp datatype.
- **waiting_time**: Time taken or time spent waiting. It is time datatype which only includes the time without year, month and day.
- **served_time**: Time spent being served. It is time datatype.
- **turn_around_time**: Total time from the call to the end of the service. It is time datatype.
- **created_at**: Timestamp when the record was created.
- **updated_at**: Timestamp when the record was last updated.
- **call_status_id**: Status of the call.