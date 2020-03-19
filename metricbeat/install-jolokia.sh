

for container in $(docker ps -q --filter 'name=mon_broker')
do
    ip=$(docker inspect $container -f '{{(index (index .NetworkSettings.Networks "mon_kafka-net").IPAddress)}}')

    # docker exec $container mkdir -p /usr/share/jmx_exporter
    # docker cp jmx_prometheus_javaagent-0.12.1-SNAPSHOT.jar $container:/usr/share/jmx_exporter/jmx_prometheus_javaagent.jar
    # docker cp kafka-0-8-2.yml $container:/usr/share/jmx_exporter/kafka-0-8-2.yml
    # docker exec $container mkdir -p /etc/kafka
    # docker cp jmx_prometheus_javaagent-0.3.1.jar $container:/usr/bin/jmx_prometheus_javaagent-0.3.1.jar
    # docker cp kafka-jmx-metric.yaml $container:/etc/kafka/kafka-jmx-metric.yaml



    echo $container - $ip
    docker cp jolokia-jvm-1.6.2-agent.jar $container:/usr/share/jolokia-jvm-1.6.2-agent.jar
    docker cp tools.jar $container:/usr/share/tools.jar
    kafka_process=$(docker exec $container ps | grep -i 'java -X' | tail -1 | awk {'print $1'})
    
    docker exec $container java -cp /usr/share/tools.jar:/usr/share/jolokia-jvm-1.6.2-agent.jar org.jolokia.jvmagent.client.AgentLauncher --host 0.0.0.0 start $kafka_process


done

# java -cp path/to/tools.jar:jolokia-jvm-1.6.2-agent.jar org.jolokia.jvmagent.client.AgentLauncher [options] <command> <ppid>