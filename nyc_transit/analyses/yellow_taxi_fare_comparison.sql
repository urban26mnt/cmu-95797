SELECT
	yel.fare_amount,
	loc.Borough as boro,
	avg(yel.fare_amount) 
		OVER (PARTITION BY boro)
		as boro_avg,
	loc.zone as zone,
	avg(yel.fare_amount)
		OVER (PARTITION BY ZONE)
		as zone_avg,
	avg(yel.fare_amount) 
		OVER (PARTITION BY TRUE)
		as all_trips_avg
FROM
	{{ ref('stg__yellow_tripdata') }} yel
	inner join
	{{ ref('mart__dim_locations') }} loc
		on yel.PULocationID = loc.LocationID
GROUP BY yel.fare_amount, loc.Borough, loc.zone
ORDER BY boro, zone