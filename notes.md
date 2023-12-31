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

1. Update packages to include `dbt-expectations`, install using:
    
    > `dbt deps`

2. Update `sources.yml` to include descriptions and tests

3. Use code-gen to create schema.yml

    Confirm the project builds without error, then run-operation:
    > `dbt run`

    > `dbt run-operation generate_model_yaml --args "{"model_names": ["stg__bike_data", "stg__central_park_weather", "stg__daily_citi_bike_trip_counts_and_weather", "stg__fhv_bases", "stg__fhv_tripdata", "stg__fhvhv_tripdata", "stg__green_tripdata", "stg__yellow_tripdata"]}"`

    Place output in `schema.yml` file located at models\staging.

4. Update `schema.yml` with descriptions, quality checks

5. Use `dbt build` to check the entire project, address issues with sql staging ingest.

6. Create documentation using `dbt docs generate` then `dbt docs serve`

### week-3-end
---

### week-4-start

1. Load seed file to nyc_transit\seeds\   Use `dbt seed` or `dbt build` to run.

2. Load schema file template to `models\mart`.

3. Create mart sql files at `models\mart` for dimensions and fact tables creation.

4. Use `dbt run` / `dbt build` to create mart tables.

5. Create analysis sql file `bike_trips_and_duration_by_weekday.sql`

    - Use `dbt compile` to create the output
    - Run duckdb, `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\bike_trips_and_duration_by_weekday.sql'`

6. Create analysis sql file `taxi_trips_ending_at_airport.sql`

    - Use `dbt compile` to create the output
    - Run duckdb, `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\taxi_trips_ending_at_airport.sql'`

7. Create analysis sql file `inter_borough_taxi_trips_by_weekday.sql`

    - Use `dbt compile` to create the output
    - Run duckdb, `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\inter_borough_taxi_trips_by_weekday.sql'`

8. Save outputs to `answers`

### week-4-end
---

### week-5-start

1. Load seed file to nyc_transit\seeds\  Use `dbt seed`

2. Create `mart__fact_trips_by_borough` and update `schema.yml`. Used `dbt build`.

3. Create analysis sql `trips_by_borough.sql`. Use `dbt compile`. Run from target.

    - `.once '.\answers\trips_by_borough.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\trips_by_borough.sql'`


4. Create group by analysis - number of trips and average duration by borough and zone

    - `.once '.\answers\trips_duration_grouped_by_borough_zone.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\trips_duration_grouped_by_borough_zone.sql'`

5. Create anti join of trips without location

    - `.once '.\answers\taxi_trips_no_valid_pickup_location_id.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\taxi_trips_no_valid_pickup_location_id.sql'`

6. Create zones_with_less_than_100k_trips.sql

    - `.once '.\answers\zones_with_less_than_100k_trips.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\zones_with_less_than_100k_trips.sql'`

7. Create pivot_trips_by_borough.sql

    - `.once '.\answers\pivot_trips_by_borough.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\pivot_trips_by_borough.sql'`

8. Create comparison of an individual fare to the zone, borough and overall average fare using the fare_amount in yellow taxi trip data

    - `.once '.\answers\yellow_taxi_fare_comparison.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\yellow_taxi_fare_comparison.sql'`

9. Dedupe the events table

    - `.once '.\answers\dedupe.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\dedupe.sql'`

10. Create Seven day moving average weather

    - `.once '.\answers\seven_day_moving_average_prcp.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\seven_day_moving_average_prcp.sql'`
    (Needs debugging)

11. Create seven_day_moving_aggs_weather.sql

    - `.once '.\answers\seven_day_moving_aggs_weather.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\seven_day_moving_aggs_weather.sql'`

12. Create average_time_between_pickups.sql

    - `.once '.\answers\average_time_between_pickups.txt'`
    - `.read '.\nyc_transit\target\compiled\nyc_transit\analyses\average_time_between_pickups.sql'`
    (Needs debugging)

### week-5-end
---