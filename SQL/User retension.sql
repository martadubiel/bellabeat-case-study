WITH user_days AS (
    SELECT
        id,
        COUNT(DISTINCT ActivityDate) AS active_days_per_user
    FROM `bellabeat-495609.Activity.all_steps_and_calories`
    GROUP BY id
),

segmented_users AS (
    SELECT
        id,
        active_days_per_user,
        CASE
            WHEN active_days_per_user > 35 THEN 'Consistent Users'
            WHEN active_days_per_user BETWEEN 10 AND 35 THEN 'Casual Users'
            ELSE 'Low Engagement'
        END AS segment
    FROM user_days
)

SELECT
    segment,
    COUNT(id) AS users_count,
    ROUND(
        COUNT(id) * 100.0 / SUM(COUNT(id)) OVER(),
        1
    ) AS pct_share
FROM segmented_users
GROUP BY segment
ORDER BY users_count DESC;