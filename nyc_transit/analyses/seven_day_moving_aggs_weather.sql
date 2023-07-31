SELECT
	date,
	min(prcp) over seven_days as min_prcp,
	max(prcp) over seven_days as max_prcp,
	avg(prcp) over seven_days as avg_prcp,
	sum(prcp) over seven_days as sum_prcp,
	min(snow) over seven_days as min_snow,
	max(snow) over seven_days as max_snow,
	avg(snow) over seven_days as avg_snow,
	sum(snow) over seven_days as sum_snow
FROM {{ ref('stg__central_park_weather') }} wx
WINDOW seven_days as (
	ORDER BY date ASC 
	RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND 
			    INTERVAL 3 DAYS FOLLOWING)
