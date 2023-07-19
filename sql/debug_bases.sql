SELECT DISTINCT
    count(*)
    -- fhv.dispatching_base_num,
    -- bases.base_number
FROM
    fhv_tripdata fhv
    LEFT JOIN fhv_bases bases ON (fhv.dispatching_base_num == bases.base_number)
WHERE
    base_number is null;