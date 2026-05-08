WITH activity_per_user AS (
    SELECT
        id,
        COUNT(DISTINCT ActivityDate) AS active_days_per_user,
        ROUND(AVG(TotalSteps),0) AS avg_steps,
        ROUND(AVG(Calories),0) AS avg_calories
    FROM `bellabeat-495609.Activity.April`
    GROUP BY id
),

sleep_per_user AS (
    SELECT
        id,

        -- Number of days with sleep data
        COUNT(DISTINCT sleep_date) AS sleep_days_logged,

        -- Sleep metrics calculated ONLY on days with sleep records
        ROUND(AVG(total_minutes_asleep),0) AS avg_minutes_asleep,
        ROUND(AVG(total_time_in_bed),0) AS avg_time_in_bed,

        ROUND(AVG(total_minutes_asleep)/60,2) AS avg_sleep_hours

    FROM `bellabeat-495609.Sleepy.April_formated`
    GROUP BY id
),

final_model AS (
    SELECT
        a.id,

        -- Activity metrics
        a.active_days_per_user,
        a.avg_steps,
        a.avg_calories,

        -- Sleep tracking consistency
        s.sleep_days_logged,

        -- Sleep metrics
        s.avg_minutes_asleep,
        s.avg_time_in_bed,
        s.avg_sleep_hours,

        -- Steps segmentation
        CASE
            WHEN a.avg_steps < 5000 THEN 'LOW'
            WHEN a.avg_steps < 10000 THEN 'MEDIUM'
            ELSE 'HIGH'
        END AS activity_segment,

        -- Engagement segmentation
        CASE
            WHEN a.active_days_per_user > 35 THEN 'Consistent Users'
            WHEN a.active_days_per_user BETWEEN 10 AND 35 THEN 'Casual Users'
            ELSE 'Low Engagement'
        END AS engagement_segment

    FROM activity_per_user a
    LEFT JOIN sleep_per_user s
        ON a.id = s.id
)

SELECT *
FROM final_model
ORDER BY avg_steps DESC;
