SELECT 
	pickup_datetime,
	pu_zone,
	pickup_datetime - lag(pickup_datetime, 1) OVER 
		(PARTITION BY pu_zone ORDER BY pickup_datetime ASC)
		as pu_diff,
	avg(pu_diff) OVER
		(PARTITION BY pu_zone)
		as zone_avg
FROM {{ ref('mart__fact_trips_by_borough') }}
