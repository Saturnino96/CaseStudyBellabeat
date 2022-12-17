/* averages_daily */
SELECT
	DISTINCT (CAST(ActivityDate AS date)) AS ActivityDate,
	AVG(CAST(TotalSteps AS float)) AS StepsAverage,
	AVG(CAST(TotalDistance AS float)) AS DistanceAverage,
	AVG(CAST(TrackerDistance AS float)) AS TrackerDistanceAverage,
	AVG(CAST(LoggedActivitiesDistance AS float)) AS LoggedActivitiesAverage,
	AVG(CAST(VeryActiveDistance AS float)) AS VeryActiveDistanceAverage,
	AVG(CAST(ModeratelyActiveDistance AS float)) AS ModeratelyActiveDistanceAverage,
	AVG(CAST(LightActiveDistance AS float)) AS LightActiveDistanceAverage,
	AVG(CAST(SedentaryActiveDistance AS float)) AS SedentaryActiveDistanceAverage,
	AVG(CAST(VeryActiveMinutes AS float)) AS VeryActiveMinutesAverage,
	AVG(CAST(FairlyActiveMinutes AS float)) AS FairlyActiveMinutesAverage,
	AVG(CAST(LightlyActiveMinutes AS float)) AS LightlyActiveMinutesAverage,
	AVG(CAST(SedentaryMinutes AS float)) AS SedentaryMinutesAverage,
	AVG(CAST(Calories AS float)) AS CaloriesAverage,
	AVG(CAST(WeightKg AS float)) AS WeightKGAverage,
	AVG(CAST(WeightPounds AS float)) AS WeightPoundsAverage,
	AVG(CAST(BMI AS float)) AS BMI_Average,
	AVG(CAST(TotalMinutesAsleep AS float)) AS TotalMinutesAsleepAverage,
	AVG(CAST(TotalTimeInBed AS float)) AS TotalTimeInBedAverage,
	AVG(CAST(HB_Daily_Avg AS float)) AS HB_DailyAverage,
	COUNT(TotalSteps) AS DailyActivityEntryCount,
	COUNT(BMI) AS WeightEntryCount,
	COUNT(TotalMinutesAsleep) AS SleepEntryCount,
	COUNT(HB_Daily_Avg) AS HB_EntryCount
INTO
	averages_daily
FROM
	daily_merged
GROUP BY
	CAST(ActivityDate AS date)
ORDER BY
	CAST(ActivityDate AS date)