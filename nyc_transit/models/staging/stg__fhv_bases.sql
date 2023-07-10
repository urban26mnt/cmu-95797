with source as (
    SELECT * FROM {{ source('main', 'fhv_bases') }}
),

renamed as (
    SELECT
        base_number base_num,
        base_name,
        dba,
        dba_category,
        filename
    FROM
        source
)

SELECT * FROM renamed