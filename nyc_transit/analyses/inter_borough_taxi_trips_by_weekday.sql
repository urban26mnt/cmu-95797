with boro_trips as (
    select *
    from
        {{ ref('mart__fact_all_taxi_trips')}} trips
    join
        {{ ref('mart__dim_locations')}} locs
    on 
        trips.dolocationid = locs.locationid
    where
        service_zone in ('Boro Zone')
)

select
    weekday(pickup_datetime) as weekday,
    count(*) as trip_count
from
    boro_trips
    join
    (select 
        weekday(pickup_datetime) as weekday,
        count(*) as inter_boro_trips
    from boro_trips
    where pulocationid <> dolocationid
    group by all
    ) boro_trips_interonly

group by all