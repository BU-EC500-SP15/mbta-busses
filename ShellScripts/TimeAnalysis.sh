#/usr/bin/sh
RECOMMENDER_WORK_PATH=/disk6/datacenter/7_recommend/pushvideo/script
DATA_PATH=/mbta-busses/DataSet
RESULT_PATH=/hadoop/fs/...

if [ $# != 2 ] ; then 
	echo "USAGE: $0 file on the cluster nameofshell" 
	echo " e.g.(10am-12am): sh $0 oneday.csv HeadwayByTrip.sh" 
	exit 1; 
fi 

ALL_DIRS=
beg=0
end=50

for((;$beg<=1440;))
do  
	echo 'Doing Scirpt for $1'
	sh $2 $1 $beg $end 
	let beg=beg+30
	let end=end+30
	echo $beg
	echo $end
done


