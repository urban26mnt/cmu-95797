with source as (

    select * from {{ source('main', 'fhv_tripdata') }}

),

renamed as (

    select
        upper(trim(dispatching_base_num)) dispatching_base_num, -- Clean source with upper and trim
        pickup_datetime,
        dropoff_datetime,
        pulocationid,
        dolocationid,
        --sr_flag, always null so chuck it
        affiliated_base_number,
        filename

    from source

)

select * from renamed