# mbta-busses
MBTA Bus Performance: Data Capture and Analysis

### Documentation
Documentation for MBTA Bus Performance project lives on Github at:

1. [MBTA_Bus_Project_Proposal.md](https://github.com/BU-EC500-SP15/mbta-busses/blob/master/MBTA_Bus_Project_Proposal.md).
2. Formal papers and data involving the MBTA reside in the [MBTA_docs directory](https://github.com/BU-EC500-SP15/mbta-busses/tree/master/MBTA_docs).
3. Items that are less formal by nature (like [meeting minutes][mm], random notes, or project planning are kept on the [MBTA Bus Performance Wiki](https://github.com/BU-EC500-SP15/mbta-busses/wiki).

[mm]:	https://github.com/BU-EC500-SP15/mbta-busses/wiki

### Intallation and Deployment

This project contains two main components, one of which is data analysis with Apache Pig , another is an UI tool to display the analysis result. This tutorial is to introduce how to get all source code of this project and how to deploy it in Linux. The first part is about run analysis in Linux shipped with Pig (We will use Hortonworks Data Platform) and the second is about deploying the website tool in Apache Httpd server.

#### Run Pig Analysis in Hortonworks Data Platform

Some background about the platform we will use in this tutorial

##### What is [Hortonworks](http://en.wikipedia.org/wiki/Hortonworks):

Hortonworks is a business computer software company based in Palo Alto, California. The company focuses on the development and support of Apache Hadoop, a framework that allows for the distributed processing of large data sets across clusters of computers[1]. There is no necessity to use Hortonworks Data Plaform to deploy this project, we use it because it's an off-the-shell Hadoop and Pig environment.

##### What is [Pig](http://hortonworks.com/hadoop-tutorial/how-to-process-data-with-apache-pig/):

Pig is a high level scripting language that is used with Apache Hadoop. Pig excels at describing data analysis problems as data flows. Pig is complete in that you can do all the required data manipulations in Apache Hadoop with Pig. In addition through the User Defined Functions(UDF) facility in Pig you can have Pig invoke code in many languages like JRuby, Jython and Java. Conversely you can execute Pig scripts in other languages. The result is that you can use Pig as a component to build larger and more complex applications that tackle real business problems[2].

##### How to download and install the Hortonworks Sandbox image for Virtualbox:

Here is a nice official [tutorial](http://hortonworks.com/products/hortonworks-sandbox/#install).

#### Clone code from github

Once the Hortonworks Data Platform (HDP) is set up, we can clone the source code from our repository to the linux. First we can ssh from host into the HDP by using delow command with password "hadoop":
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
Copy one day data set from MBTA/Dataset to Hadoop in HDP under mbta-busses directory:
```
$ hadoop fs -copyFromLocal ./DataSet/20140301.csv
```
