CREATE TABLE `bellabeat-495609.Sleepy.April_formated` AS

SELECT
  SAFE_CAST(Id AS INT64) AS id,
  DATE(SAFE.PARSE_DATE('%m/%d/%Y', SPLIT(SleepDay, ' ')[SAFE_OFFSET(0)]))
    AS sleep_date,
  SAFE_CAST(TotalSleepRecords AS INT64) AS total_sleep_records,
  SAFE_CAST(TotalMinutesAsleep AS INT64) AS total_minutes_asleep,
  SAFE_CAST(TotalTimeInBed AS INT64) AS total_time_in_bed
FROM `bellabeat-495609.Sleepy.April`;
