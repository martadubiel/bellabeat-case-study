WITH
  user_avg AS (
    SELECT Id, AVG(TotalSteps) AS avg_steps
    FROM `bellabeat-495609.Activity.all_steps_and_calories`
    GROUP BY Id
  ),
  segmented AS (
    SELECT
      Id,
      avg_steps,
      CASE
        WHEN avg_steps < 5000 THEN 'LOW'
        WHEN avg_steps < 10000 THEN 'MEDIUM'
        ELSE 'HIGH'
        END
        AS segment
    FROM user_avg
  )
SELECT segment, COUNT(DISTINCT Id) AS users_count
FROM segmented
GROUP BY segment
ORDER BY users_count DESC;
