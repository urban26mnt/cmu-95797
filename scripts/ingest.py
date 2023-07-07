import duckdb
import os

TABLE_NAMES = ['bike_data, central_park_weather', 'daily_citi_bike_trip_counts_and_weather',
               'fhv_bases', 'fhv_tripdata', 'fhvhv_tripdata',
               'green_tripdata', 'yellow_tripdata']

db_con = duckdb.connect('main.db')

# Load parquet files from data folder
db_con.sql(r"CREATE TABLE fhv_tripdata AS SELECT * FROM read_parquet('data\**\fhv_tripdata*.parquet', filename=1);")
db_con.sql(r"CREATE TABLE fhvhv_tripdata AS SELECT * FROM read_parquet('data\**\fhvhv_tripdata*.parquet', filename=1);")
db_con.sql(r"CREATE TABLE green_tripdata AS SELECT * FROM read_parquet('data\**\green_tripdata*.parquet', filename=1);")
db_con.sql(r"CREATE TABLE yellow_tripdata AS SELECT * FROM read_parquet('data\**\yellow_tripdata*.parquet, filename=1');")

# Load csv files
db_con.sql(r"CREATE TABLE bike_data AS SELECT * FROM read_csv_auto('data\bike\*.csv.gz', union_by_name=True, allvarchar=1, filename=1);")
db_con.sql(r"CREATE TABLE central_park_weather AS SELECT * FROM read_csv_auto('data\central_park_weather.csv', union_by_name=True, allvarchar=1, filename=1);")
db_con.sql(r"CREATE TABLE daily_citi_bike_trip_counts_and_weather AS SELECT * FROM read_csv_auto('data\daily_citi_bike_trip_counts_and_weather.csv', union_by_name=True, allvarchar=1,  filename=1);")
db_con.sql(r"CREATE TABLE fhv_bases AS SELECT * FROM read_csv_auto('data\fhv_bases.csv', union_by_name=True, allvarchar=1, filename=1, header=True);")
