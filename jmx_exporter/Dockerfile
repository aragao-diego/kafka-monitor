FROM docker.io/library/maven:3.6-jdk-11-slim

FROM docker.io/library/openjdk:11-jre-slim

WORKDIR /build


COPY . /build


# COPY ./files/entrypoint.sh /entrypoint.sh

# RUN mvn clean package

# WORKDIR /build/jmx_prometheus_httpserver
# RUN mvn clean package


ENV JMX_EXPORTER_PORT=5555
# ENV JMX_EXPORTER_LISTEN_PORT=5556
ENV JMX_EXPORTER_CONFIG=/etc/jmx_exporter/config.yaml
RUN mkdir -p /usr/share/jmx_exporter && \
    mv /build/files/jmx_prometheus_javaagent-*-SNAPSHOT.jar /usr/share/jmx_exporter/jmx_prometheus_javaagent.jar && \
    mv /build/files/jmx_prometheus_httpserver-*-SNAPSHOT-jar-with-dependencies.jar /usr/share/jmx_exporter/jmx_prometheus_httpserver.jar && \
    mv /build/files/config /etc/jmx_exporter && \
    mv /build/files/entrypoint.sh /entrypoint.sh && \
    chmod +x /entrypoint.sh

# RUN ls /usr/share/jmx_exporter
# WORKDIR /entrypoint

EXPOSE 5555

ENTRYPOINT [ "/entrypoint.sh" ]