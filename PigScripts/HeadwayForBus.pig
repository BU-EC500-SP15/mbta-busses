SET DEFAULT_PARALLEL 10;
%declare DATE '2014-03-01'
%declare INPUT_PATH 'oneday.csv'
%declare ROUTE_NAME '28'
%declare ROUTE_DIRECTION 'Outbound'

--RawData = LOAD '$INPUT_PATH' USING PigStorage(',') AS (UNIQUE_ID, ServiceDate, RouteName:chararray, TripID:int, Block,
--	RouteDirectionName:chararray, PatternName, StopOffset, StopName, Latitude, Longitude, MapLatitude, MapLongitude,
--	MDTLatitude, MDTLongitude, ScheduledTimeInMin:int, ActArrivalTimeInMin:int, ActDepartureTimeInMin:int,
--    ScheduledTime:chararray, ActArrivalTime:chararray, ActDepartureTime:chararray,
--	Variation, Vehicle, IsRevenue, CROSSING_TYPE_ID);

-- Filter data by route name and route direction
--RouteCrossingPoint = FILTER RawData BY RouteName == '$ROUTE_NAME' and RouteDirectionName == '$ROUTE_DIRECTION';

RawData = load '$csvfile' using PigStorage(',') as (UNIQUE_ID, ServiceDate, RouteName:int, TripID:int, Block,
	RouteDirectionName:chararray, PatternName, StopOffset, StopName, Latitude, Longitude, MapLatitude, MapLongitude,
	MDTLatitude, MDTLongitude,ScheduledTimeInMin:int,ActArrivalTimeInMin:int,ActDepartureTimeInMin:int,ScheduledTime:chararray, ActArrivalTime:chararray, ActDepartureTime:chararray,
	Variation, Vehicle, IsRevenue, CROSSING_TYPE_ID);
	
FilterData = FILTER RawData BY (ScheduledTimeInMin >= $begin) AND (ScheduledTimeInMin <= $end);

-- Select useful columns
FilterData = FOREACH FilterData
				GENERATE ServiceDate, TripID, RouteName,
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
						TripStart::FilterData::ScheduledTimeInMin AS StartTimeInMin,
						TripStart::FilterData::RouteName AS RouteName,
						TripStart::FilterData::RouteDirectionName AS RouteDirectionName,
						TripStart::rankTripHeadwayStart::TripID AS Trip_1,
						TripEnd::rankTripHeadwayEnd::TripID AS Trip_2,
						TripStart::FilterData::StopName AS StopName,
						TripEnd::FilterData::ActArrivalTimeInMin - TripStart::FilterData::ActArrivalTimeInMin AS ActHeadway,
						TripEnd::FilterData::ScheduledTimeInMin - TripStart::FilterData::ScheduledTimeInMin AS ScheduledHeadway,
						ABS(TripEnd::FilterData::ActArrivalTimeInMin - TripStart::FilterData::ActArrivalTimeInMin - TripEnd::FilterData::ScheduledTimeInMin + TripStart::FilterData::ScheduledTimeInMin) AS HeadwayDifference;
						

--STORE Headway INTO 'HeadwayByTrip' USING PigStorage('\t') PARALLEL 1;

HeadwayResult = Group Headway by (RouteName, RouteDirectionName, ServiceDate, Trip_1);
avgTripDifference = FOREACH HeadwayResult GENERATE group.RouteName as RouteName, group.RouteDirectionName as RouteDirectionName,
	               group.Trip_1 as Trip_1,
				   group.ServiceDate as ServiceDate,
	               AVG(Headway.ActHeadway) as avgHeadway,
				   AVG(Headway.ScheduledHeadway) as avgScheduledHeadway,
				   AVG(Headway.HeadwayDifference) as avgHeadwayDifference  PARALLEL 10;

avgTripDifference = order avgTripDifference by RouteName, RouteDirectionName, Trip_1, ServiceDate  PARALLEL 1; 

store avgTripDifference INTO 'HeadwayByTrip' USING PigStorage('\t') PARALLEL 1;