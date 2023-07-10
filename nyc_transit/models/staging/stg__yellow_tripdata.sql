with source as (
    SELECT * FROM {{ source('main', 'yellow_tripdata') }}
),

renamed as (
    SELECT
        VendorID,
        tpep_pickup_datetime::datetime start_dt,
        tpep_dropoff_datetime::datetime end_dt,
        passenger_count::double passenger_count,
        trip_distance::double trip_distance,
        RatecodeID,
        store_and_fwd_flag::boolean store_and_fwd_flag,
        PUlocationID::double pickup_loc_id,
        DOlocationID::double dropoff_loc_id,
        fare_amount::double fare_amount,
        extra::double extra,
        mta_tax::double mta_tax,
        tip_amount::double tip_amount,
        tolls_amount::double tolls_amount,
        Improvement_surcharge::double imprv_surcharge,
        total_amount::double total_amount,
        payment_type::double payment_type,
        congestion_surcharge::double congestion_surcharge,
        airport_fee::double airport_fee,
        filename
    FROM
        source
    WHERE
        passenger_count <> 0
)

SELECT * FROM renamed