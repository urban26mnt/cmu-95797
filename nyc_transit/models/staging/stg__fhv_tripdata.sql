with source as (
    SELECT * FROM {{ source('main', 'fhv_tripdata') }}
),

renamed as (
    SELECT
        dispatching_base_num,
        pickup_datetime::datetime start_dt,
        dropOff_datetime::datetime end_dt,
        PUlocationID::double pickup_loc_id,
        DOlocationID::double dropoff_loc_id,
        Affiliated_base_number::varchar afflt_base_num,
        filename
    FROM
        source
)

SELECT * FROM renamed