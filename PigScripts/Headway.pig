SET DEFAULT_PARALLEL 25;

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

-- Select useful columns
FilterData = FOREACH FilterData GENERATE ServiceDate, TripID, RouteName,
						RouteDirectionName, PatternName, ScheduledTimeInMin,
						ActArrivalTimeInMin, ActDepartureTimeInMin, StopName;

-- Group the data
GroupedData = GROUP FilterData BY (RouteName, RouteDirectionName, TripID, PatternName,ServiceDate);

-- Select the minimum ScheduledTimeInMin as start time for each trip
TripData = FOREACH GroupedData
						GENERATE group.TripID AS TripID,
						MIN(FilterData.ScheduledTimeInMin) AS TripStartTime,
						group.ServiceDate AS ServiceDate;

OrderedByTrip = ORDER TripData BY TripStartTime;

-- Assign an unique ordinal number to each trip
rankTripHeadwayStart = RANK OrderedByTrip;

-- Minus the rank_id for the following JOIN operation
rankTripHeadwayEnd = FOREACH rankTripHeadwayStart
						GENERATE rank_OrderedByTrip-1 AS rank_OrderedByTrip,
								TripID, TripStartTime, ServiceDate;

TripStart = JOIN rankTripHeadwayStart BY TripID Left,
				 FilterData BY TripID;

TripEnd = JOIN rankTripHeadwayEnd BY TripID Left,
               FilterData BY TripID;

TripsJOIN = JOIN TripStart BY (rank_OrderedByTrip, StopName),
                 TripEnd BY (rank_OrderedByTrip, StopName);

Headway = FOREACH TripsJOIN
				GENERATE TripStart::rankTripHeadwayStart::rank_OrderedByTrip AS HeadwayId,
						TripStart::FilterData::ServiceDate AS ServiceDate,
						TripStart::rankTripHeadwayStart::TripStartTime,
						TripStart::FilterData::RouteName AS RouteName,
						TripStart::FilterData::RouteDirectionName AS RouteDirectionName,
						TripStart::rankTripHeadwayStart::TripID AS Trip_1,
						TripEnd::rankTripHeadwayEnd::TripID AS Trip_2,
						TripStart::FilterData::StopName AS StopName,
						TripEnd::FilterData::ActArrivalTimeInMin - TripStart::FilterData::ActArrivalTimeInMin AS ActHeadway,
						TripEnd::FilterData::ScheduledTimeInMin - TripStart::FilterData::ScheduledTimeInMin AS ScheduledHeadway,
						ABS(TripEnd::FilterData::ActArrivalTimeInMin - TripStart::FilterData::ActArrivalTimeInMin - TripEnd::FilterData::ScheduledTimeInMin + TripStart::FilterData::ScheduledTimeInMin) AS HeadwayDifference;
Describe Headway;
						
HeadwayResult = Group Headway by (RouteName, RouteDirectionName, ServiceDate, Trip_1, TripStartTime);

Describe HeadwayResult;
avgTripDifference = FOREACH HeadwayResult GENERATE group.RouteName as RouteName, group.RouteDirectionName as RouteDirectionName,
	               group.Trip_1 as Trip_1,
				   group.ServiceDate as ServiceDate,
	               AVG(Headway.ActHeadway) as avgHeadway,
				   AVG(Headway.ScheduledHeadway) as avgScheduledHeadway,
				   AVG(Headway.HeadwayDifference) as avgHeadwayDifference,
				   group.TripStartTime / 10 as StartTimeField;
				   
HeadwayByTimeField = Group avgTripDifference by (RouteName, RouteDirectionName, StartTimeField);

ResultData = FOREACH HeadwayByTimeField GENERATE group.RouteName, group.RouteDirectionName, group.StartTimeField,
												 AVG(avgTripDifference.avgHeadway),	
												 AVG(avgTripDifference.avgScheduledHeadway),
												 AVG(avgTripDifference.avgHeadwayDifference);

HeadWayAVGByTimeField = Order ResultData by RouteName, RouteDirectionName,StartTimeField;				   

store HeadWayAVGByTimeField INTO 'Headway' USING PigStorage('\t');