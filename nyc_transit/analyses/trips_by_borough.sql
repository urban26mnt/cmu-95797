select
    pu_borough,
    count(*) as trips
from
    {{ ref('mart__fact_trips_by_borough') }}
group by all
