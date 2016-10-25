#!/bin/bash
echo "started"
apt-get update
apt-get remove scala-library scala
apt-get install wget -y
rm -rf scala-2.10.4.deb
wget www.scala-lang.org/files/archive/scala-2.10.4.deb
dpkg -i scala-2.10.4.deb
apt-get -f install -y
apt-get install scala
rm -rf /etc/apt/sources.list.d/sbt.list
echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
apt-get update
apt-get install sbt -y
rm -rf kafka_2.10-0.9.0.1*
wget http://www-us.apache.org/dist/kafka/0.9.0.1/kafka_2.10-0.9.0.1.tgz
tar xzf kafka_2.10-0.9.0.1.tgz
kafka_2.10-0.9.0.1/bin/zookeeper-server-start.sh kafka_2.10-0.9.0.1/config/zookeeper.properties&
#kafka_2.10-0.9.0.1/bin/kafka-server-start.sh kafka_2.10-0.9.0.1/config/server.properties&
#kafka_2.10-0.9.0.1/bin/kafka-console-producer.sh --topic test --broker-list localhost:9092