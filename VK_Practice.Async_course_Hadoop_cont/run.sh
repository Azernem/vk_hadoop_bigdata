#!/bin/bash

export HADOOP_USER_NAME=hadoop

# Create dir
hadoop fs -mkdir hdfs://192.168.34.2:8020/createme

# REmove dir
hadoop fs -rm -r hdfs://192.168.34.2:8020/delme

# Create local file
echo "Пример содержимого" > /tmp/content.txt
hadoop fs -put /tmp/content.txt hdfs://192.168.34.2:8020/nonnull.txt

# Running WordCount trought YARN
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar wordcount \
    -D mapreduce.framework.name=yarn \
    -D yarn.resourcemanager.address=192.168.34.2:8032 \
    hdfs://192.168.34.2:8020/shadow.txt \
    hdfs://192.168.34.2:8020/output


hadoop fs -cat hdfs://192.168.34.2:8020/output/part-r-00000 | \
    grep -w "Innsmouth" | awk '{print $2}' > count.txt

hadoop fs -put -f count.txt hdfs://192.168.34.2:8020/whataboutsinnsmouth.txt
