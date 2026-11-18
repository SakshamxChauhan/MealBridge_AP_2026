# Query Execution Timings

## 1. Testing Environment

- **DBMS:** PostgreSQL 18.4
- **Project:** MealBridge
- **Timing Unit:** Milliseconds (ms)
- **Testing Method:** PostgreSQL `\timing on`
- **Number of Executions:** Each query was executed 3 times.
- **Reported Result:** Average execution time of 3 runs.

## 2. Testing Methodology

1. Enabled PostgreSQL query timing using `\timing on`.
2. Executed every READ query three times.
3. Executed every WRITE query three times.
4. Used `BEGIN` and `ROLLBACK` for WRITE query tests to prevent permanent changes to the sample data.
5. Recorded the execution time displayed by PostgreSQL for each query.
6. Calculated the average execution time using:

   **Average = (Run 1 + Run 2 + Run 3) / 3**

**Note:** Transaction setup (`BEGIN`) and cleanup (`ROLLBACK`) timings are excluded. Only the actual SQL query execution times are reported.

## 3. READ Query Timings

| Query | Run 1 (ms) | Run 2 (ms) | Run 3 (ms) | Average (ms) |
|---|---:|---:|---:|---:|
| READ 1 | 0.389 | 0.363 | 0.260 | 0.337 |
| READ 2 | 0.471 | 0.524 | 0.511 | 0.502 |
| READ 3 | 0.598 | 0.602 | 0.608 | 0.603 |
| READ 4 | 0.367 | 0.373 | 0.455 | 0.398 |
| READ 5 | 0.348 | 0.357 | 0.363 | 0.356 |
| READ 6 | 0.381 | 0.387 | 0.400 | 0.389 |
| READ 7 | 0.392 | 0.378 | 0.397 | 0.389 |

## 4. WRITE Query Timings

| Query | Run 1 (ms) | Run 2 (ms) | Run 3 (ms) | Average (ms) |
|---|---:|---:|---:|---:|
| WRITE 1 | 0.408 | 0.331 | 0.302 | 0.347 |
| WRITE 2 | 0.581 | 0.570 | 0.545 | 0.565 |
| WRITE 3 | 0.520 | 0.412 | 0.426 | 0.453 |
| WRITE 4 | 0.535 | 0.416 | 0.428 | 0.460 |
| WRITE 5 | 0.527 | 0.548 | 0.544 | 0.540 |
| WRITE 6 | 0.356 | 0.382 | 0.435 | 0.391 |

## 5. Summary

- Total READ queries tested: 7
- Total WRITE queries tested: 6
- Total queries tested: 13
- Executions per query: 3
- Total query executions: 39

All timings are actual measurements collected from PostgreSQL during testing. Average execution times are rounded to three decimal places.

## 6. Observations

1. All 13 queries were successfully executed and timed three times.
2. READ 3 had the highest average execution time among READ queries (0.603 ms).
3. WRITE 2 had the highest average execution time among WRITE queries (0.565 ms).
4. WRITE 1 had the lowest average execution time among WRITE queries (0.347 ms).
5. WRITE queries were tested inside transactions and rolled back to preserve the original sample data.

**Conclusion:** The execution timings provide a baseline for the MealBridge database queries in the tested PostgreSQL environment. These results can be used for future query optimization and performance comparison.