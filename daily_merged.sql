/* daily_merged */
SELECT
	A.*,
	B.WeightKg,
	B.WeightPounds,
	B.BMI,
	B.IsManualReport,
	C.TotalSleepRecords,
	C.TotalMinutesAsleep,
	C.TotalTimeInBed,
	D.HB_Daily_Avg
INTO
	daily_merged
FROM
	dailyActivity_merged A
FULL OUTER JOIN
	weightLogInfo_merged B
ON
	A.Id = B.Id
	AND A.ActivityDate = CAST(B.Date AS date)
FULL OUTER JOIN
	sleepDay_merged C
ON
	A.Id = C.Id
	AND A.ActivityDate = CAST(C.SleepDay AS date)
FULL OUTER JOIN (SELECT
	Id,
	CAST(Time AS date) AS Day,
	AVG(CAST(Value as float)) AS HB_Daily_Avg
FROM
	heartrate_seconds_merged
GROUP BY
	Id, CAST(Time AS date)) D
ON
	A.Id = D.Id
	AND A.ActivityDate = CAST(D.Day AS date)
ORDER BY
	A.Id, A.ActivityDate