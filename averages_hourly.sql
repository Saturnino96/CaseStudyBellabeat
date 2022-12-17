/* averages_hourly */
SELECT
	DISTINCT (CAST(Hour AS datetime)) AS ActivityHour,
	AVG(CAST(StepTotal AS float)) AS StepsAverage,
	AVG(CAST(TotalIntensity AS float)) AS TotalIntensityAverage,
	AVG(CAST(AverageIntensity AS float)) AS AverageIntensityAverage,
	AVG(CAST(Calories AS float)) AS CaloriesAverage,
	AVG(CAST(HB_Hour_Avg AS float)) AS HB_HourlyAverage,
	COUNT(StepTotal) AS StepIntesityCaloriesEntryCount,
	COUNT(HB_Hour_Avg) AS HB_EntryCount
INTO
	averages_hourly
FROM
	hourly_merged
GROUP BY
	CAST(Hour AS datetime)
ORDER BY
	CAST(Hour AS datetime)