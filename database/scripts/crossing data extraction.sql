/****** Script for SelectTopNRows command from SSMS  ******/
WITH TIME_POINT_CROSSING_DAILY
AS (
	/****** Script for SelectTopNRows command from SSMS  ******/
	SELECT UNIQUE_ID
		,CALENDAR_ID
		,r.ROUTE_NAME
		,ROUTE_DIRECTION_ID
		,PATTERN_ID
		,GEO_NODE_ID
		,STOP_OFFSET
		,SCHEDULED_TIME
		,ACT_ARRIVAL_TIME
		,ACT_DEPARTURE_TIME
		,ODOMETER
		,TIME_POINT_ID
		,VEHICLE_ID
		,TRIP_ID
		,IsRevenue
		,SCHEDULE_TIME_OFFSET
		,CROSSING_TYPE_ID
	FROM TMDailyLog.dbo.TIME_POINT_CROSSING a, TMMain.dbo.ROUTE r
	WHERE a.CALENDAR_ID = 120140301 -->= 120140301  and a.CALENDAR_ID <= 120140331 
	and r.ROUTE_ID = a.ROUTE_ID
	and r.ROUTE_NAME in ('1','15','22','23','28','32','39','57','66','71','73','77','111','116','117')
		AND a.TRIP_ID IS NOT NULL
	)
SELECT UNIQUE_ID
	,convert(DATE, RIGHT(CALENDAR_ID, 8)) ServiceDate
	,a.ROUTE_NAME RouteName
	,a.TRIP_ID TripID
	,b.BLOCK_ID Block
	,rd.ROUTE_DIRECTION_NAME RouteDirectionName
	,pt.PATTERN_NAME PatternName --The name for a defined sequence of points and events along a variation of a route that represents a physical path traversed by a transit vehicle in a network.
	,STOP_OFFSET StopOffset
	,gn.GEO_NODE_NAME StopName
	,gn.LATITUDE Latitude
	,gn.LONGITUDE Longitude
	,gn.MAP_LATITUDE MapLatitude
	,gn.MAP_LONGITUDE MapLongitude
	,gn.MDT_LATITUDE MDTLatitude
	,gn.MDT_LONGITUDE MDTLongitude
	,CONVERT(VARCHAR(19),DATEADD(SECOND, SCHEDULED_TIME, convert(DATETIME, RIGHT(CALENDAR_ID, 8))),120) ScheduledTime
	,CONVERT(VARCHAR(19),DATEADD(SECOND, ACT_ARRIVAL_TIME, convert(DATETIME, RIGHT(CALENDAR_ID, 8))),120) ActArrivalTIme
	,CONVERT(VARCHAR(19),DATEADD(SECOND, ACT_DEPARTURE_TIME, convert(DATETIME, RIGHT(CALENDAR_ID, 8))),120) ActDepartureTime
	,pt.PATTERN_ABBR Variation --An alpha-numeric identifier for a defined sequence of points, events and activation events along a route.
	,v.PROPERTY_TAG Vehicle
	,IsRevenue
	,CROSSING_TYPE_ID
FROM TIME_POINT_CROSSING_DAILY a
INNER JOIN TMMain.dbo.GEO_NODE gn ON a.GEO_NODE_ID = gn.GEO_NODE_ID
INNER JOIN TMMain.dbo.PATTERN pt ON pt.pattern_id = a.pattern_id
INNER JOIN TMMain.dbo.ROUTE_DIRECTION rd ON rd.ROUTE_DIRECTION_ID = a.ROUTE_DIRECTION_ID
INNER JOIN TMMain.dbo.VEHICLE v ON v.VEHICLE_ID = a.VEHICLE_ID
INNER JOIN TMMain.dbo.TRIP t on t.TRIP_ID = a.TRIP_ID
INNER JOIN TMMain.dbo.BLOCK b on t.BLOCK_ID = b.BLOCK_ID
ORDER BY a.UNIQUE_ID,a.ROUTE_NAME
	,a.TRIP_ID
