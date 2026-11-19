# MealBridge Application Query Timings & Plans (CP4)

| Query ID | Type | Run 1 (ms) | Run 2 (ms) | Run 3 (ms) | Average (ms) | Plan File |
| :--- | :--- | ---: | ---: | ---: | ---: | :--- |
| Q01_available_listings | READ | 0.167 | 0.093 | 0.078 | 0.113 | `dbms/plans/Q01_available_listings.txt` |
| Q02_donor_leaderboard | READ | 6.161 | 5.106 | 3.645 | 4.971 | `dbms/plans/Q02_donor_leaderboard.txt` |
| Q03_claim_history | READ | 0.086 | 0.226 | 0.250 | 0.187 | `dbms/plans/Q03_claim_history.txt` |
| Q04_city_summary | READ | 4.876 | 4.561 | 2.682 | 4.040 | `dbms/plans/Q04_city_summary.txt` |

## Benchmark Verification
- Verified all READ and WRITE queries on PostgreSQL 18 using `EXPLAIN (ANALYZE, BUFFERS)`.
- Wrapped WRITE queries in `BEGIN; ... ROLLBACK;` to keep dataset state unchanged.
