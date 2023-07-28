select
    {{ dbt_utils.star(ref('events')) }}
from 
    {{ ref('events') }}