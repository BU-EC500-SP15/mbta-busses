SET default_parallel 10;

--ReadData into Tuple
RawData = load '$csvfile' using PigStorage(',') as (UNIQUE_ID, ServiceDate, RouteName:int, TripID:int, Block,
	RouteDirectionName:chararray, PatternName, StopOffset, StopName, Latitude, Longitude, MapLatitude, MapLongitude,
	MDTLatitude, MDTLongitude,ScheduledTimeInMin:int,ActArrivalTimeInMin:int,ActDepartureTimeInMin:int,ScheduledTime:chararray, ActArrivalTime:chararray, ActDepartureTime:chararray,
	Variation, Vehicle, IsRevenue, CROSSING_TYPE_ID);

--Refine Data for 15 Key Routes
FilterData = FILTER RawData BY (RouteName == 27) OR (RouteName == 15) OR (RouteName == 22)
			OR (RouteName == 23) OR (RouteName == 28) OR (RouteName == 32)
			OR (RouteName == 39) OR (RouteName == 57) OR (RouteName == 66)
			OR (RouteName == 71) OR (RouteName == 73) OR (RouteName == 77)
			OR (RouteName == 111) OR (RouteName == 116) OR (RouteName == 117);

FilterData = FILTER FilterData BY (ScheduledTimeInMin >= $begin) AND (ScheduledTimeInMin <= $end);

--Filter data necessary for visualizations 
FilterData = FOREACH FilterData GENERATE TripID, RouteName, RouteDirectionName, PatternName,
	                                 ScheduledTime, ScheduledTimeInMin as ScheduledT,
	                                 ActArrivalTime, ActArrivalTimeInMin as ActArrivalT,
	                                 (int)ABS(ScheduledTimeInMin - ActArrivalTimeInMin) as diffT, 
	                                 StopName, CROSSING_TYPE_ID;


GroupedData = Group FilterData by (RouteName, RouteDirectionName, TripID, PatternName);

--Compute avg difference bw scheduled time and actual arrival time for each trip 
avgTripDifference = FOREACH GroupedData GENERATE group.RouteName as RouteName, group.RouteDirectionName as RouteDirectionName,
	               group.PatternName as PatternName,
	               MIN(FilterData.ScheduledTime) as StartTime,
	               ROUND(AVG(FilterData.diffT)) as avgDiffOnTime,
	               group.TripID as TripID;

avgTripDifference = Order avgTripDifference by RouteName, RouteDirectionName, PatternName, StartTime PARALLEL 10; 

store avgTripDifference into 'avgTripDifference' PARALLEL 1;
