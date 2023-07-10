with source as (
    SELECT * FROM {{ source('main', 'bike_data') }}
),

renamed as (
SELECT 
    start_dt,
    end_dt,
    start_station_id,
    start_station_name,
    start_lat,
    start_lng,
    end_station_id,
    end_station_name,
    end_lat,
    end_lng,
    ride_id,
    filename
FROM 
    (SELECT 
        starttime::datetime start_dt,
        stoptime::datetime end_dt,
        "start station id"::varchar start_station_id,
        "start station name"::varchar start_station_name,
        "start station latitude"::double start_lat,
        "start station longitude"::double start_lng,
        "end station id"::varchar end_station_id,
        "end station name"::varchar end_station_name,
        "end station latitude"::double end_lat,
        "end station longitude"::double end_lng,
        bikeid::varchar ride_id,
        filename
    FROM source
    WHERE starttime IS NOT NULL)
    UNION ALL
    (SELECT
        started_at::datetime start_dt,
        ended_at::datetime end_dt,
        start_station_id,
        start_station_name,
        start_lat::double,
        start_lng::double,
        end_station_id,
        end_station_name,
        end_lat::double,
        end_lng::double,
        ride_id::varchar,
        filename::varchar filename
    FROM source
    WHERE start_dt IS NOT NULL)
)

SELECT * FROM renamed