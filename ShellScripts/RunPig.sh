#/usr/bin/sh
RECOMMENDER_WORK_PATH=/disk6/datacenter/7_recommend/pushvideo/script
DATA_PATH=/mbta-busses/DataSet
RESULT_PATH=/hadoop/fs/...
build_dirs(){
    local new_dir=$1
    local all_dir=$2
   

    if [ -z "$all_dir" ]; then
	ALL_DIRS=$new_dir
    else
	ALL_DIRS="$all_dir,$new_dir"
    fi 
    return 0
}

if [ $# != 4 ] ; then 
	echo "USAGE: $0 BeginDate, EndDate, Begin Time(min), End Time(min)" 
	echo " e.g.(10am-12am): sh $0 20150101 20150301 600 720" 
	exit 1; 
fi 

ALL_DIRS=
beg=$1
end=$2
begintime=$3
endtime=$4

for((;$beg<$end;))
do  
    DIR=$beg.csv  
    build_dirs  $DIR $ALL_DIRS   
    beg=$(date -d "$beg +1days" +%Y%m%d)
done

echo 'Doing Scirpt for these days'
sh DiffTime.sh  $ALL_DIRS  $bginttime $endtime
sh TripDuration.sh  $ALL_DIRS  $bginttime $endtime
