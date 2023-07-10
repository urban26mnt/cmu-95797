with source as (
    SELECT * FROM {{ source('main', 'green_tripdata') }}
),

renamed as (
    SELECT
        VendorID,
        lpep_pickup_datetime::datetime start_dt,
        lpep_dropoff_datetime::datetime end_dt,
        store_and_fwd_flag::boolean store_and_fwd_flag,
        RatecodeID,
        PUlocationID::double pickup_loc_id,
        DOlocationID::double dropoff_loc_id,
        passenger_count::double passenger_count,
        trip_distance::double trip_distance,
        fare_amount::double fare_amount,
        extra::double extra,
        mta_tax::double mta_tax,
        tip_amount::double tip_amount,
        tolls_amount::double tolls_amount,
        Improvement_surcharge::double imprv_surcharge,
        total_amount::double total_amount,
        payment_type::double payment_type,
        trip_type::double trip_type,
        congestion_surcharge::double congestion_surcharge, 
        filename
    FROM
        source
    WHERE
        passenger_count <> 0
)

SELECT * FROM renamed