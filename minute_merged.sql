/* minute_merged */
SELECT
	CASE
		WHEN A.Id IS NULL AND D.Id IS NULL THEN F.Id
		WHEN A.Id IS NULL THEN D.Id
		ELSE A.Id
	END AS UserId,
	CAST (CASE
		WHEN A.ActivityMinute IS NULL AND FORMAT(CAST(D.Date AS datetime), 'MM-dd.yyyy HH:mm') IS NULL THEN F.HB_Minute
		WHEN A.ActivityMinute IS NULL THEN FORMAT(CAST(D.Date AS datetime), 'MM-dd.yyyy HH:mm')
		ELSE A.ActivityMinute
	END AS datetime) AS Hour,
	A.Intensity,
	B.Calories,
	C.METs,
	D.value AS sleepValue,
	E.Steps,
	F.HB_Min_Avg
INTO
	minute_merged
FROM
	minuteIntensitiesNarrow_merged A
FULL OUTER JOIN
	minuteCaloriesNarrow_merged B
ON
	A.Id = B.Id AND
	A.ActivityMinute = B.ActivityMinute
FULL OUTER JOIN
	minuteMETsNarrow_merged C
ON
	A.Id = C.Id AND
	A.ActivityMinute = C.ActivityMinute
FULL OUTER JOIN
	minuteSleep_merged D
ON
	A.Id = D.Id AND
	FORMAT(CAST(A.ActivityMinute AS datetime), 'MM-dd.yyyy HH:mm') = FORMAT(CAST(D.Date AS datetime), 'MM-dd.yyyy HH:mm')
FULL OUTER JOIN
	minuteStepsNarrow_merged E
ON
	A.Id = E.Id AND
	A.ActivityMinute = E.ActivityMinute
FULL OUTER JOIN (SELECT
	Id,
	CAST(Time as smalldatetime) AS HB_Minute,
	AVG(CAST(Value as float)) AS HB_Min_Avg
FROM
	heartrate_seconds_merged
GROUP BY
	Id, CAST(Time as smalldatetime)
	) F
ON
	A.Id = F.Id AND
	A.ActivityMinute = F.HB_Minute
ORDER BY
	UserId,
	Hour