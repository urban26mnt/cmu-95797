with source as (
    SELECT * FROM {{ source('main', 'central_park_weather') }}
),

renamed as (
    SELECT
        station station_id,
        name,
        date::date date,
        AWND::double wind_speed_avg,
        PRCP::double precipitation,
        SNOW::double snowfall,
        SNWD::double snow_depth,
        TMAX::double temp_max,
        TMIN::double temp_min,
        filename
    FROM
        source
)

SELECT * FROM renamed