""" 
dump_raw_counts.py
"""

import duckdb

TABLE_NAMES = ['bike_data', 'central_park_weather', 'daily_citi_bike_trip_counts_and_weather',
               'fhv_bases', 'fhv_tripdata', 'fhvhv_tripdata',
               'green_tripdata', 'yellow_tripdata']

# Connect to database
db_con = duckdb.connect('main.db')

# Iterate tables and output rowcounts to file
out_lines = []
for table in TABLE_NAMES:
    count = db_con.execute(f"SELECT count(*) FROM {table};").df()
    output = f"{table}: {count.iloc[0,0]}\n"
    out_lines.append(output)
    
with open(r'.\answers\raw_counts.txt', mode='wt', encoding='utf-8') as f:
    f.writelines(out_lines)
