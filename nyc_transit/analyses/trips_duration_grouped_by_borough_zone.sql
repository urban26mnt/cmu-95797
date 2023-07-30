select
    t.pu_borough,
    t.pu_zone,
    sum(t.duration_min) as total_trip_duration_mins,
    avg(t.duration_min) as avg_trip_duration_mins
from
    {{ ref('mart__fact_trips_by_borough') }} t
group by all
order by t.pu_borough, t.pu_zone