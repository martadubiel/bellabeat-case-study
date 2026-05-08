CREATE TABLE `bellabeat-495609.Activity.all_steps_and_calories` AS

SELECT
  Id,
  ActivityDate,
  TotalSteps,
  Calories

FROM `bellabeat-495609.Activity.April` 

UNION ALL

SELECT
  Id,
  ActivityDate,
  TotalSteps,
  Calories

FROM `bellabeat-495609.Activity.March`
