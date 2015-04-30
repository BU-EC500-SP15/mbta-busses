SET DEFAULT_PARALLEL 25;

RawData = LOAD '$csvfile' USING PigStorage(',') AS (UNIQUE_ID, ServiceDate:datetime, RouteName:int, TripID:int, Block,
        RouteDirectionName:chararray, PatternName, StopOffset, StopName, Latitude, Longitude, MapLatitude, MapLongitude,
		MDTLatitude, MDTLongitude, ScheduledTimeInMin:int, ActArrivalTimeInMin:int, ActDepartureTimeInMin:int,
		ScheduledTime:chararray, ActArrivalTime:chararray, ActDepartureTime:chararray,
        Variation, Vehicle, IsRevenue, CROSSING_TYPE_ID);

FilterData = FILTER RawData BY (RouteName == 1) OR (RouteName == 15) OR (RouteName == 22)
		OR (RouteName == 23) OR (RouteName == 28) OR (RouteName == 32)
		OR (RouteName == 39) OR (RouteName == 57) OR (RouteName == 66)
		OR (RouteName == 71) OR (RouteName == 73) OR (RouteName == 77)
		OR (RouteName == 111) OR (RouteName == 116) OR (RouteName == 117);
			
FilterData = FILTER FilterData BY ServiceDate >= ToDate('$beginDate') AND ServiceDate <= ToDate('$endDate')
			AND (ScheduledTimeInMin >= $begin) AND (ScheduledTimeInMin <= $end);
			
-- Select useful columns
FilterData = FOREACH FilterData GENERATE ServiceDate, TripID, RouteName,
			RouteDirectionName, PatternName, ScheduledTimeInMin, ActArrivalTimeInMin, ActDepartureTimeInMin, StopName
			,(DaysBetween(ServiceDate ,ToDate(0L)) + 4L) % 7  as Days;

-- Group the data
FilterData = FILTER FilterData BY (Days >= 1) AND (Days <= 5);
GroupedData = GROUP FilterData BY (ServiceDate, RouteName, RouteDirectionName, TripID, PatternName);

-- Select the minimum ScheduledTimeInMin as start time for each trip
TripData = FOREACH GroupedData
			GENERATE group.ServiceDate AS ServiceDate, group.RouteName AS RouteName,
			group.RouteDirectionName AS RouteDirectionName,
			group.TripID AS TripID,
			MIN(FilterData.ScheduledTimeInMin) AS TripStartTime;

OrderedByTrip = ORDER TripData BY ServiceDate,RouteName,RouteDirectionName,TripStartTime;

-- Assign an unique ordinal number to each trip
rankTripHeadwayStart = RANK OrderedByTrip;

-- Minus the rank_id for the following JOIN operation
rankTripHeadwayEnd = FOREACH rankTripHeadwayStart
					GENERATE rank_OrderedByTrip-1 AS rank_OrderedByTrip,
									ServiceDate,RouteName,RouteDirectionName, TripID, TripStartTime;

TripStart = JOIN rankTripHeadwayStart BY (ServiceDate,RouteName,RouteDirectionName,TripID) Left,
                                 FilterData BY (ServiceDate,RouteName,RouteDirectionName,TripID);

TripEnd = JOIN rankTripHeadwayEnd BY (ServiceDate,RouteName,RouteDirectionName,TripID) Left,
               FilterData BY (ServiceDate,RouteName,RouteDirectionName,TripID);

TripsJOIN = JOIN TripStart BY (rankTripHeadwayStart::ServiceDate,
                                rankTripHeadwayStart::RouteName,
                                rankTripHeadwayStart::RouteDirectionName,
                                rankTripHeadwayStart::rank_OrderedByTrip,
                                StopName),
                 TripEnd BY (rankTripHeadwayEnd::ServiceDate,
                                 rankTripHeadwayEnd::RouteName,
                                 rankTripHeadwayEnd::RouteDirectionName,
                                 rankTripHeadwayEnd::rank_OrderedByTrip,
                                 StopName);

Headway = FOREACH TripsJOIN
		GENERATE TripStart::rankTripHeadwayStart::rank_OrderedByTrip AS HeadwayId,
						TripStart::rankTripHeadwayStart::ServiceDate AS ServiceDate,
						TripStart::FilterData::ScheduledTimeInMin/10 AS StartTimeInMin,
						TripStart::FilterData::RouteName AS RouteName,
						TripStart::FilterData::RouteDirectionName AS RouteDirectionName,
						TripStart::rankTripHeadwayStart::TripID AS Trip_1,
						TripEnd::rankTripHeadwayEnd::TripID AS Trip_2,
						TripStart::FilterData::StopName AS StopName,
						TripEnd::FilterData::ActArrivalTimeInMin - TripStart::FilterData::ActArrivalTimeInMin AS ActHeadway,
                        TripEnd::FilterData::ScheduledTimeInMin - TripStart::FilterData::ScheduledTimeInMin AS ScheduledHeadway,
						TripEnd::FilterData::ActArrivalTimeInMin - TripStart::FilterData::ActArrivalTimeInMin - TripEnd::FilterData::ScheduledTimeInMin + TripStart::FilterData::ScheduledTimeInMin AS HeadwayDifference;

HeadwayGroup = GROUP Headway BY (RouteName, RouteDirectionName,StartTimeInMin);

AvgHeadway = FOREACH HeadwayGroup GENERATE group.RouteName AS RouteName,
		group.RouteDirectionName AS RouteDirectionName, group.StartTimeInMin AS ScheduledTimeInMin,
		AVG(Headway.ScheduledHeadway) AS AvgScheduledHeadway, AVG(Headway.ActHeadway) AS AvgActHeadway,
		AVG(Headway.HeadwayDifference) AS AvgHeadwayDifference;

AvgHeadway = ORDER AvgHeadway BY RouteName,RouteDirectionName,ScheduledTimeInMin;

rmf /user/hadoop/AvgHeadwayTest;
store AvgHeadway into 'Headway' USING PigStorage('\t');
