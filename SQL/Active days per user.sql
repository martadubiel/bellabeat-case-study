WITH
  user_days AS (
    SELECT id, COUNT(DISTINCT ActivityDate) AS active_days_per_user
    FROM `bellabeat-495609.Activity.all_steps_and_calories`
    GROUP BY id
  )
SELECT * 
FROM user_days 
ORDER BY active_days_per_user
