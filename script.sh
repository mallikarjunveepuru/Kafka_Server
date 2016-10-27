#!/bin/bash
echo "started"
apt-get update -y
apt-get remove scala-library scala -y
apt-get install wget -y
rm -rf scala-2.10.5.deb
wget www.scala-lang.org/files/archive/scala-2.10.5.deb
dpkg -i scala-2.10.5.deb
apt-get -f install -y
rm -rf /etc/apt/sources.list.d/sbt.list
echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
apt-get update -y
apt-get install sbt -y
rm -rf kafka_2.10-0.9.0.1*
apt-get install curl -y
curl -O https://storage.googleapis.com/gggopaddle1/kafka_2.10-0.9.0.1.zip
sleep 15
unzip kafka_2.10-0.9.0.1.zip
ip="$(curl icanhazip.com)"
sed -i "s/localhost/${ip}/g" kafka_2.10-0.9.0.1/config/producer.properties
sed -i "s/localhost/${ip}/g" kafka_2.10-0.9.0.1/config/server.properties
sed -i "s/127.0.0.1/${ip}/g" kafka_2.10-0.9.0.1/config/consumer.properties
#kafka_2.10-0.9.0.1/bin/zookeeper-server-start.sh kafka_2.10-0.9.0.1/config/zookeeper.properties&
kafka_2.10-0.9.0.1/bin/kafka-server-start.sh kafka_2.10-0.9.0.1/config/server.properties&
#kafka_2.10-0.9.0.1/bin/kafka-console-producer.sh --topic test --broker-list localhost:9092
curl -O http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz
tar xvf spark-1.6.0-bin-hadoop2.6.tgz
./spark-1.6.0-bin-hadoop2.6/sbin/start-master.sh --h 0.0.0.0
git clone https://github.com/mallikarjunveepuru/sample-KafkaSparkCassandra.git
cd sample-KafkaSparkCassandra
sbt assembly
cd ..
./spark-1.6.0-bin-hadoop2.6/sbin/start-slave.sh spark://0.0.0.0:7007
~/spark-1.6.0-bin-hadoop2.6/bin/spark-submit --properties-file cassandra-count.conf --class KafkaSparkCassandra target/scala-2.10/cassandra-kafka-streaming-assembly-1.0.jar
