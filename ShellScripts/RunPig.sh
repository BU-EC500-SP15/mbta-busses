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

ALL_DIRS=
beg=$1
end=$2
filename=$3

for((;$beg<$end;))
do  
    DIR=$beg.csv
    echo $ALL_DIRS  
    build_dirs  $DIR $ALL_DIRS   
    beg=$(date -d "$beg +1days" +%Y%m%d)
done
echo $build_dirs


echo 'Doing Scirpt for these days'
sh DiffTime.sh $build_dirs $filename
sh TripDuration.sh $build_dirs $file_name
