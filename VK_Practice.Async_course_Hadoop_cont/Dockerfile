FROM openjdk:11

RUN apt-get update && \
    apt-get install -y wget ssh && \
    wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz && \
    tar -xzf hadoop-3.3.6.tar.gz && \
    mv hadoop-3.3.6 /opt/hadoop && \
    rm hadoop-3.3.6.tar.gz

ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]

COPY core-site.xml $HADOOP_CONF_DIR/core-site.xml
COPY yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml
COPY mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
