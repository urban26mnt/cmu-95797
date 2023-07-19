SELECT DISTINCT
    UPPER(TRIM(fhv.dispatching_base_num)),
    bases.base_number
FROM
    fhv_tripdata fhv
    LEFT JOIN fhv_bases bases ON (UPPER(TRIM(fhv.dispatching_base_num)) == UPPER(bases.base_number))
WHERE
    base_number is null;