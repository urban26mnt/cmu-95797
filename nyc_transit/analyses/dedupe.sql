select *
from {{ ref('mart__dim_events') }}
qualify row_number()
	over (partition by event_id
			order by insert_timestamp desc)
			= 1
order by event_id 