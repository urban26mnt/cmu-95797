### week-1-start

1. awscli command:

    ```aws s3 sync s3://cmu-95797-23m6 . --no-sign-request```

    feedback: please tell students up front about --no-sign-request before we register for aws

2. Create ingest.sql to load files into tables. cmd exec:
    
    `duckdb main.db`
    
    `.read '.\sql\ingest.sql'`
    
    note:  do not include ';' at end of statement, will not read param.

3. create ingest.py to load files into tables cmd exec.  (duplicate of .sql)

    `.\scripts\ingest.py`

    note: For CSV, use 'union_by_name' where the files have different header / column names.

4. Create `dump_raw_schemas.sql` to output results.

5. Create `dump_raw_counts.py` to output rowcounts for each table.

6. Update `.gitignore` to exclude main.db

### week-1-end
---