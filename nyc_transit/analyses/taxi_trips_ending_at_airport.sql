select
    service_zone,
    count(*) as trips
from
    {{ ref('mart__fact_all_taxi_trips')}} trips
join
    {{ ref('mart__dim_locations')}} locs
on 
    trips.dolocationid = locs.locationid
where
    service_zone  in ('EWR', 'Airports')
group by all