### week-1-start

1. awscli command:

    ```aws s3 sync s3://cmu-95797-23m6 . --no-sign-request```

    feedback: please tell students up front about --no-sign-request before we register for aws

2. Create ingest.sql to load files into tables. cmd exec:
    
    `duckdb main.db`
    
    `.read '.\sql\ingest.sql'`
    
    note:  do not include ';' at end of statement, will not read param.

3. create ingest.py to load files into tables cmd exec.  (duplicate of .sql)

    `.\scripts\ingest.py`

    note: For CSV, use 'union_by_name' where the files have different header / column names.

4. Create `dump_raw_schemas.sql` to output results.

5. Create `dump_raw_counts.py` to output rowcounts for each table.

6. Update `.gitignore` to exclude main.db

### week-1-end
---

### week-2-start

1. Initialize dbt project:  `dbt init nyc_transit`

2. Create connection profile file `profiles.yml` for minimal duckdb, add path to database location.

3. Edit top level `dbt_project.yml`, adding schema: staging and replacing example models dir with staging dirs

4. Create `packages.yml` to create code-gen dependency. Install at CLI using `dbt deps`.

5. Use code-gen to create sources definition:
    
    `dbt run-operation generate_source --args "{"schema_name": "main", "generate_columns": "true", "include_data_types": "true"}"`

    Output is saved in `models\staging\sources.yml`

6. Use `dbt list` to check connected resources.

7. Create .sql to clean data files:

    - `bike_data`: combine data from two different schemas, dropping uncommon columns.
    - `fhv_bases`: rename base number to correspond with other fhv data.
    - `fhv_tripdata`: remove SR_flag as its 100% null, rename others.
    - `fhvhv_tripdata`: updated types, no 100% null fields removed. Remove zero distance trips.
    - `green_tripdata`: drop 'ehail_fee' column for being 100% null. Update types. Remove zero passenger count trips.
    - `yellow_tripdata`: updated types, no 100% null fields removed. Remove zero passenger count trips.
    - `central_park_weather`:  rename to lowercase, no null removals.
    - `daily_citi_bike_...`:  remove date conversions (dow, year, month) as duplicate of date column that could lead to errors.

8. Use `dbt run` to create staging views of data.

### week-2-end
---

Update with week 2 answers

---
### week-3-start
