#/usr/bin/sh
SCRIPT_PATH=/home/hadoop/mbta-busses/PigScripts
DATA_PATH=/home/hadoop/MBTADataSet
HADOOP_PATH=/user/hadoop
LOCAL_RESULT_PATH=/home/hadoop/Result
OUTPUT_PATH_NAME=tripDurations

if [ $# != 5 ] ; then 
	echo "USAGE: $0 csv File in the Cluster, Begin Time(min), End Time(min), BeginDate, EndDate(not include)" 
	echo " e.g.(10am-12am): sh $0 oneday.csv 600 720 2015-01-01 2015-02-01" 
	exit 1; 
fi 


echo "The Input File is $1"
input_path=$HADOOP_PATH/$1


echo "Deleting the old Result..."
hadoop fs -rmr $HADOOP_PATH/$OUTPUT_PATH_NAME

echo "Doing Pig Script..."
pig  -p "csvfile="$input_path"" -p "begin=$2" -p "end=$3" -p "startDate=$4" -p "endDate=$5" $SCRIPT_PATH/RunTime.pig


echo "Copy File to LocalDisk..."
dire=$LOCAL_RESULT_PATH/$OUTPUT_PATH_NAME/temp

if [ -d "$dire" ]; then
	rm -rf $dire
	mkdir -p $dire
else
	mkdir -p $dire
fi

echo "Get Result to LocalDisk ..."
hadoop fs -get $HADOOP_PATH/$OUTPUT_PATH_NAME/part-* $dire
cat $dire/* >>$LOCAL_RESULT_PATH/$OUTPUT_PATH_NAME/$OUTPUT_PATH_NAME_$1_$2_$3_$4_$5.tsv
