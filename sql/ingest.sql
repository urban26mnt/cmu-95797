-- ingest.sql --

-- get parquet data
CREATE TABLE fhv_tripdata AS SELECT * FROM read_parquet('data\**\fhv_tripdata*.parquet', filename=1);
CREATE TABLE fhvhv_tripdata AS SELECT * FROM read_parquet('data\**\fhvhv_tripdata*.parquet', filename=1);
CREATE TABLE green_tripdata AS SELECT * FROM read_parquet('data\**\green_tripdata*.parquet', filename=1);
CREATE TABLE yellow_tripdata AS SELECT * FROM read_parquet('data\**\yellow_tripdata*.parquet', filename=1);

-- get csv data
CREATE TABLE bike_data AS SELECT * FROM read_csv_auto('data\bike\*.csv.gz', union_by_name=True, sample_size=-1, filename=1);
CREATE TABLE central_park_weather AS SELECT * FROM read_csv_auto('data\central_park_weather.csv', filename=1);
CREATE TABLE daily_citi_bike_trip_counts_and_weather AS SELECT * FROM read_csv_auto('data\daily_citi_bike_trip_counts_and_weather.csv', filename=1);
CREATE TABLE fhv_bases AS SELECT * FROM read_csv_auto('data\fhv_bases.csv', filename=1);
