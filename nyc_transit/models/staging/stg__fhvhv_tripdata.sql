with source as (
    SELECT * FROM {{ source('main', 'fhvhv_tripdata') }}
),

renamed as (
    SELECT
        hvfhs_license_num::varchar license_num,
        dispatching_base_num::varchar dispatching_base_num,
        originating_base_num::varchar originating_base_num,
        request_datetime::datetime request_dt,
        on_scene_datetime::datetime onscene_dt,
        pickup_datetime::datetime start_dt,
        dropoff_datetime::datetime end_dt,
        PUlocationID::double pickup_loc_id,
        DOlocationID::double dropoff_loc_id,
        trip_miles::double trip_miles,
        trip_time::bigint trip_time,
        base_passenger_fare::double base_passenger_fare,
        tolls::double tolls,
        bcf::double bcf,
        sales_tax::double sales_tax,
        congestion_surcharge::double congestion_surcharge,
        airport_fee::double airport_fee,
        tips::double tips,
        driver_pay::double driver_pay,
        shared_request_flag::boolean shared_request_flag,
        shared_match_flag::boolean shared_match_flag,
        access_a_ride_flag::boolean access_a_ride_flag,
        wav_request_flag::boolean wav_request_flag,
        wav_match_flag::boolean wav_match_flag,
        filename
    FROM
        source
    WHERE
        trip_miles <> 0
)

SELECT * FROM renamed