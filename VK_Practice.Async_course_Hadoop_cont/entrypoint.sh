#!/bin/bash
set -e

wait_for_service() {
    local host=$1
    local port=$2
    until nc -z $host $port; do
        echo "Waiting for $host:$port..."
        sleep 3
    done
}

main() {
    # Wait for HDFS and YARN to running
    wait_for_service 192.168.34.2 8020
    wait_for_service 192.168.34.2 8032

    # Create  directory in HDFS
    hdfs dfs -mkdir -p /createme

    # Delete directory in HDFS
    hdfs dfs -rm -r -f /delme || true

    echo "Current HDFS root contents:"
    hdfs dfs -ls / | awk '{print $8}' || true
    echo "---------------------------"

    # Create /nonnull.txt
    echo "valid-content" | hdfs dfs -put -f - /nonnull.txt

    # Run WordCount mapReduc
    hdfs dfs -rm -r -f /output >/dev/null 2>&1 || true
    
    echo "Submitting MapReduce job to YARN..."
    hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar \
        wordcount /shadow.txt /output 2>/dev/null

    # count
 for 'Innsmouth'
    result=$(hdfs dfs -cat /output/part-r-00000 2>/dev/null | 
           awk '$1 == "Innsmouth" {sum += $2} END{print sum+0}')
    
    echo "Count: $result"

    # Write result to /whataboutinsmouth.txt in HDFS
    echo "$result" | hdfs dfs -put -f - /whataboutinsmouth.txt
}

main "$@"
