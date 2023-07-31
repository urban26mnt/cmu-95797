select 
	date,
	prcp,
	((prcp + lag(prcp,1) + lag(prcp, 2) + lag(prcp, 3) + lead(prcp, 1) + lead(prcp, 2)  + lead(prcp, 3)) / 7.0)
		OVER (order by date) as avg
from {{ ref('stg__central_park_weather') }} wx
