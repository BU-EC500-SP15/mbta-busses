#/usr/bin/sh
RECOMMENDER_WORK_PATH=/disk6/datacenter/7_recommend/pushvideo/script
DATA_PATH=/mbta-busses/DataSet
RESULT_PATH=/hadoop/fs/...

if [ $# != 1 ] ; then 
	echo "USAGE: $0 file on the cluster" 
	echo " e.g.(10am-12am): sh $0 oneday.csv" 
	exit 1; 
fi 

ALL_DIRS=
beg=0
end=50
begintime=$3
endtime=$4

for((;$beg<=2350;))
do  
	echo 'Doing Scirpt for these days'
	sh DiffTime.sh $1 $beg $end 
	sh TripDuration.sh $1 $beg $end
	$beg=$beg+30
	$end=$end+30
done


