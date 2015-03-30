REGISTER DateCalc.jar
REGISTER datafu-1.2.0.jar

define Enumerate1 datafu.pig.bags.Enumerate('1');
define Enumerate0 datafu.pig.bags.Enumerate('0');

--ReadData into Tuple
RawData = load 'oneday.csv' using PigStorage(',') as 
(UNIQUE_ID,ServiceDate,RouteName:int,TripID:int,Block,RouteDirectionName:chararray,PatternName,StopOffset,StopName,Latitude,Longitude,MapLatitude,MapLongitude,MDTLatitude,MDTLongitude,ScheduledTime:chararray,ActArrivalTIme:chararray,ActDepartureTime:chararray,Variation,Vehicle,IsRevenue,CROSSING_TYPE_ID);


--Refine Data for 15 Key Routes
FilterData = FILTER RawData BY (RouteName == 01) OR (RouteName == 15) OR (RouteName == 22)
							OR (RouteName == 23) OR (RouteName == 28) OR (RouteName == 32)
							OR (RouteName == 39) OR (RouteName == 57) OR (RouteName == 66)
							OR (RouteName == 71) OR (RouteName == 73) OR (RouteName == 77)
							OR (RouteName == 111) OR (RouteName == 116) OR (RouteName == 117);



--Data1 Find Current Train
RefinedData = FOREACH FilterData GENERATE	RouteName,RouteDirectionName,StopName,TripID,
											(int)(DateCalc.Convert(ScheduledTime)) as nSchTime,
											(int)(DateCalc.Convert(ActArrivalTIme)) as nArrTime,
											(int)(DateCalc.Convert(ActDepartureTime)) as nDepTime;                                          
DESCRIBE RefinedData;

--OrderData = ORDER RefinedData BY RouteName,RouteDirectionName,StopName,nSchTime;
--dump OrderData;

GroupData = GROUP RefinedData BY (RouteName,RouteDirectionName,StopName);

Summary0 = FOREACH GroupData{
  sorted = ORDER RefinedData by RouteName,RouteDirectionName,StopName,nSchTime ASC;
  GENERATE FLATTEN(Enumerate0(sorted));
};

Summary1 = FOREACH GroupData{
  sorted = ORDER RefinedData by RouteName,RouteDirectionName,StopName,nSchTime ASC;
  GENERATE FLATTEN(Enumerate1(sorted));
};

TotalSummary = UNION Summary0,Summary1;
DESCRIBE TotalSummary;

GroupDataSummary = GROUP TotalSummary BY (RouteName,RouteDirectionName,StopName, i);
DESCRIBE GroupDataSummary;


--AVG/Distribution By Stop
GruopTwoTime = FOREACH GroupDataSummary GENERATE FLATTEN(group) as (RouteName,RouteDirectionName,StopName, i) , MAX(TotalSummary.nSchTime) - MIN(TotalSummary.nSchTime)  as HeadWayTime,
														   MAX(TotalSummary.nArrTime) - MIN(TotalSummary.nArrTime)  as HeadWayRealTime, MAX(TotalSummary.nSchTime) as nSchTime;
                                                           
AVGResult = FILTER GruopTwoTime BY HeadWayTime > 0 AND HeadWayTime < 120;

--Get Normal Result
GroupResult = GROUP AVGResult BY (RouteName,RouteDirectionName,StopName);
DESCRIBE GroupResult;

STORE GroupResult INTO 'AVGHeadDistribution';

FinalAvgHeadTime = FOREACH GroupResult GENERATE group , AVG(AVGResult.HeadWayTime) ,AVG(AVGResult.HeadWayRealTime);
DESCRIBE FinalAvgHeadTime;                                                           

STORE FinalAvgHeadTime INTO 'AVGHead';

--Time Concern Analysis
SPLIT AVGResult INTO Night IF (nSchTime < 480 or nSchTime > 1440), 
				     Busy IF (nSchTime > 480 and nSchTime < 600) or (nSchTime > 1020 and nSchTime < 1140),
                     Normal IF (nSchTime > 600 and nSchTime < 1020) or (nSchTime > 1140 and nSchTime < 1440);


--Get 3 AVG Result
GroupResultNight = GROUP Night BY (RouteName,RouteDirectionName,StopName);
FinalAvgHeadTimeNight = FOREACH GroupResultNight GENERATE group , AVG(Night.HeadWayTime) ,AVG(Night.HeadWayRealTime);
STORE FinalAvgHeadTimeNight INTO 'AVGNight';


GroupResultBusy = GROUP Busy BY (RouteName,RouteDirectionName,StopName);
FinalAvgHeadTimeBusy = FOREACH GroupResultBusy GENERATE group , AVG(Busy.HeadWayTime) ,AVG(Busy.HeadWayRealTime);
STORE FinalAvgHeadTimeBusy INTO 'AVGBusy';

GroupResultNormal = GROUP Normal BY (RouteName,RouteDirectionName,StopName);
FinalAvgHeadTimeNormal = FOREACH GroupResultNormal GENERATE group , AVG(Normal.HeadWayTime) ,AVG(Normal.HeadWayRealTime);
STORE FinalAvgHeadTimeNormal INTO 'AVGNormal';
                