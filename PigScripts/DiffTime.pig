SET default_parallel 25;

--ReadData into Tuple
RawData = load '$csvfile' using PigStorage(',') as (UNIQUE_ID, ServiceDate:datetime, RouteName:int, TripID:int, Block,
	RouteDirectionName:chararray, PatternName, StopOffset, StopName, Latitude, Longitude, MapLatitude, MapLongitude,
	MDTLatitude, MDTLongitude,ScheduledTimeInMin:int,ActArrivalTimeInMin:int,ActDepartureTimeInMin:int,ScheduledTime:chararray, ActArrivalTime:chararray, ActDepartureTime:chararray,
	Variation, Vehicle, IsRevenue, CROSSING_TYPE_ID);

--Refine Data for 15 Key Routes
FilterData = FILTER RawData BY (RouteName == 1) OR (RouteName == 15) OR (RouteName == 22)
			OR (RouteName == 23) OR (RouteName == 28) OR (RouteName == 32)
			OR (RouteName == 39) OR (RouteName == 57) OR (RouteName == 66)
			OR (RouteName == 71) OR (RouteName == 73) OR (RouteName == 77)
			OR (RouteName == 111) OR (RouteName == 116) OR (RouteName == 117);

FilterData = FILTER FilterData BY (ServiceDate >= ToDate('$beginDate')) AND (ServiceDate <= ToDate('$endDate'));			
FilterData = FILTER FilterData BY (ScheduledTimeInMin >= $begin) AND (ScheduledTimeInMin <= $end);


--Filter data necessary for visualizations 
FilterData = FOREACH FilterData GENERATE TripID, RouteName, RouteDirectionName, PatternName,ServiceDate,
	                                 ActArrivalTime, ActArrivalTimeInMin as ActArrivalT,
	                                 ActDepartureTime, ActDepartureTimeInMin as ActDepartureT,
									 ScheduledTime,ScheduledTimeInMin as SchArrivalT,
									 (int)ABS(ScheduledTimeInMin - ActArrivalTimeInMin) as diffT,
	                                 StopName, CROSSING_TYPE_ID;

--store OrderedData into 'OrderedData';

GroupedData = Group FilterData by (RouteName, RouteDirectionName, TripID, PatternName);

tripDurations = FOREACH GroupedData GENERATE group.RouteName as RouteName, group.RouteDirectionName as RouteDirectionName, group.TripID as TripID, group.PatternName as PatternName, 
MIN(FilterData.SchArrivalT) / 60  as StartTimeField, AVG(FilterData.diffT) as tripDifference;

tripDurationsByDay = Group tripDurations by (RouteName, RouteDirectionName, StartTimeField);

ResultData = FOREACH tripDurationsByDay GENERATE group.RouteName, group.RouteDirectionName, group.StartTimeField, AVG(tripDurations.tripDifference);

trip = Order ResultData by RouteName, RouteDirectionName,StartTimeField;

store trip into 'tripDurations' USING PigStorage('\t');