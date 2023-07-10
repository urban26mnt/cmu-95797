with source as (
    SELECT * FROM {{ source('main', 'daily_citi_bike_trip_counts_and_weather') }}
),

renamed as (
    SELECT
        date::date date,
        trips::double trips,
        precipitation::double precipitation,
        snow_depth::double snow_depth,
        snowfall::double snowfall,
        max_temperature::double temp_max,
        min_temperature::double temp_min,
        average_wind_speed::double wind_speed_avg,
        stations_in_service::int stations_in_service,
        holiday::boolean holiday,
        filename
    FROM
        source
)

SELECT * FROM renamed