/* heartrate_seconds_mergeds_conversion */
SELECT
	Id,
	CAST(Time as smalldatetime) AS HB_Minute,
	AVG(CAST(Value as float)) AS HB_Min_Avg
FROM
	heartrate_seconds_merged
GROUP BY
	Id, CAST(Time as smalldatetime)
ORDER BY
	Id, CAST(Time as smalldatetime)

SELECT
	*,
	CAST((CAST(Month AS varchar) + '/' + CAST(Day AS varchar) + '/2016 ' + CAST(Hour AS varchar) + ':00:00') AS datetime) AS ActivityHour
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

SELECT
	Id,
	CAST(Time AS date) AS Day,
	AVG(CAST(Value as float)) AS HB_Daily_Avg
FROM
	heartrate_seconds_merged
GROUP BY
	Id, CAST(Time AS date)
ORDER BY
	Id, CAST(Time AS date)