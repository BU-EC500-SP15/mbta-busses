# mbta-busses
MBTA Bus Performance: Data Capture and Analysis

### Documentation
Documentation for MBTA Bus Performance project lives on Github at:

1. [MBTA_Bus_Project_Proposal.md](https://github.com/BU-EC500-SP15/mbta-busses/blob/master/MBTA_Bus_Project_Proposal.md).
2. Formal papers and data involving the MBTA reside in the [MBTA_docs directory](https://github.com/BU-EC500-SP15/mbta-busses/tree/master/MBTA_docs).
3. Items that are less formal by nature (like [meeting minutes][mm], random notes, or project planning are kept on the [MBTA Bus Performance Wiki](https://github.com/BU-EC500-SP15/mbta-busses/wiki).

[mm]:	https://github.com/BU-EC500-SP15/mbta-busses/wiki

### Installation and Deployment

This project contains two main components, one of which is data analysis with Apache Pig , another is an UI tool to display the analysis result. This tutorial is to introduce how to get all source code of this project and how to deploy it in Linux. The first part is about run analysis in Linux shipped with Pig (We will use Hortonworks Data Platform) and the second is about deploying the website tool in Apache Httpd server.

#### Run Pig Analysis in Hortonworks Data Platform

Some background about the platform we will use in this tutorial

##### What is [Hortonworks](http://en.wikipedia.org/wiki/Hortonworks):

Hortonworks is a business computer software company based in Palo Alto, California. The company focuses on the development and support of Apache Hadoop, a framework that allows for the distributed processing of large data sets across clusters of computers[1]. **There is no necessity to use Hortonworks Data Plaform to deploy this project, we use it because it's an off-the-shell Hadoop and Pig environment**.

##### What is [Pig](http://hortonworks.com/hadoop-tutorial/how-to-process-data-with-apache-pig/):

Pig is a high level scripting language that is used with Apache Hadoop. Pig excels at describing data analysis problems as data flows. Pig is complete in that you can do all the required data manipulations in Apache Hadoop with Pig. In addition through the User Defined Functions(UDF) facility in Pig you can have Pig invoke code in many languages like JRuby, Jython and Java. Conversely you can execute Pig scripts in other languages. The result is that you can use Pig as a component to build larger and more complex applications that tackle real business problems[2].

##### How to download and install the Hortonworks Sandbox image for Virtualbox:

Here is a nice official [tutorial](http://hortonworks.com/products/hortonworks-sandbox/#install).

#### Clone code from github

Once the Hortonworks Data Platform (HDP) is set up, we can clone the source code from our repository to the linux. First we can ssh from host into the HDP by using command below with password "hadoop":
```
$ ssh root@127.0.0.1 -P 2222
```
Install GIT client:
```
$ sudo yum install git
```
Clone mbta-busses repository:
```
$ git clone https://github.com/BU-EC500-SP15/mbta-busses.git
```
Verify the repository by open the mbta-busses directory:
```
$ cd mbta-busses
```
Copy one day data set from the repository to Hadoop in HDP under mbta-busses directory:
```
$ hadoop fs -copyFromLocal ./DataSet/20140301.csv
```
Verify the file in hadoop:
```
hadoop fs -ls /
```
By default you can see the files in hadoop's HDFS as below:
```
Found 11 items
-rw-r--r--   1 root   hdfs      4300707 2015-05-03 00:08 /20140301.csv
drwxrwxrwx   - yarn   hadoop          0 2014-12-16 19:05 /app-logs
drwxr-xr-x   - hdfs   hdfs            0 2014-12-16 19:11 /apps
drwxr-xr-x   - hdfs   hdfs            0 2014-12-16 19:41 /demo
drwxr-xr-x   - hdfs   hdfs            0 2014-12-16 19:06 /hdp
drwxr-xr-x   - mapred hdfs            0 2014-12-16 19:05 /mapred
drwxr-xr-x   - hdfs   hdfs            0 2014-12-16 19:05 /mr-history
drwxr-xr-x   - hdfs   hdfs            0 2014-12-16 19:31 /ranger
drwxr-xr-x   - hdfs   hdfs            0 2014-12-16 19:07 /system
drwxrwxrwx   - hdfs   hdfs            0 2015-05-02 19:07 /tmp
drwxr-xr-x   - hdfs   hdfs            0 2015-05-02 19:07 /user
```
Then we can process our data with Pig scripts for different metrics analysis and we provide shell scripts to trigger Pig scripts individually. With some defined parameters for the shell, we can generate analysis result for data of specific time period. Below is some example of running this scripts.

*** All Metrics for 2 years ***
Run all the metrics for 2 yeas... 8 more hours, can do it during the night by crontab
```
$ nohup sh RunAll.sh &
```
You can run different metrics analysis for 2 years individually
```
$ sh MonthlyHeadway.sh                --> Performance of Headways
$ sh MonthlyAvgWaitTime.sh			--> Performance of AvgWaitTime
$ sh RunTime.sh						--> Performance of RunTime
$ sh DiffTime.sh 						--> Performance of Difference Between Scheduled and Actual 
```
Metrics for specific time period
```
$ sh Headway.sh "Your data on the hadoop" "begin time" "end time" "begin date" "end date" (in Minute)

e.g. $ sh Headway.sh oneyear.csv 0 1440 2013-01-01 2013-02-01
```
The other metrics are similar to this command

