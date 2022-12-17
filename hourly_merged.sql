/* hourly_merged */
SELECT
	CASE
		WHEN A.Id IS NULL THEN B.Id
		ELSE A.Id
	END AS UserId,
	CAST (CASE
		WHEN A.ActivityHour IS NULL THEN B.ActivityHour
		ELSE A.ActivityHour
	END AS datetime) AS Hour,
	A.StepTotal,
	B.HB_Hour_Avg,
	C.Calories,
	D.TotalIntensity,
	D.AverageIntensity
INTO
	hourly_merged
FROM
	hourlySteps_merged A
FULL OUTER JOIN (SELECT
	Id,
	HB_Hour_Avg,
	CAST((CAST(Month AS varchar)+'/'+CAST(Day AS varchar)+'/2016 '+CAST(Hour AS varchar)+':00:00') AS datetime) AS ActivityHour
FROM (SELECT
	Id,
	DATEPART(dd, CAST(Time AS datetime)) AS Day,
	DATEPART(MM, CAST(Time AS datetime)) AS Month,
	DATEPART(hh, CAST(Time AS datetime)) AS Hour,
	AVG(CAST(Value as float)) AS HB_Hour_Avg
FROM
	heartrate_seconds_merged
GROUP BY
	Id,
	DATEPART(dd, CAST(Time AS datetime)),
	DATEPART(MM, CAST(Time AS datetime)),
	DATEPART(hh, CAST(Time AS datetime))
	) SUB
	) B
ON
	A.Id = B.Id AND
	A.ActivityHour = B.ActivityHour
FULL OUTER JOIN
	hourlyCalories_merged C
ON
	A.Id = C.Id AND
	A.ActivityHour = C.ActivityHour
FULL OUTER JOIN
	hourlyIntensities_merged D
ON
	A.Id = D.Id AND
	A.ActivityHour = D.ActivityHour
ORDER BY
	UserId, Hour