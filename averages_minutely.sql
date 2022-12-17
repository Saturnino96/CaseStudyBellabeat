/* averages_minutely */
SELECT
	DISTINCT (CAST(Hour AS datetime)) AS ActivityMinute,
	AVG(CAST(Steps AS float)) AS StepsAverage,
	AVG(CAST(Intensity AS float)) AS IntensityAverage,
	AVG(CAST(METs AS float)) AS METsAverage,
	AVG(CAST(Calories AS float)) AS CaloriesAverage,
	AVG(CAST(sleepValue AS float)) AS SleepValueAverage,
	AVG(CAST(HB_Min_Avg AS float)) AS HB_MinutelyAverage,
	COUNT(Steps) AS StepsIntensityMETsCaloriesEntryCount,
	COUNT(SleepValue) AS SleepValueEntryCount,
	COUNT(HB_Min_Avg) AS HB_MinutelyEntryCount
INTO
	averages_minutely
FROM
	minute_merged
GROUP BY
	CAST(Hour AS datetime)
ORDER BY
	CAST(Hour AS datetime)