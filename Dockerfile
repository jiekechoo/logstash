FROM java:8-jre
MAINTAINER Jieke Choo <jiekechoo@sectong.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install --no-install-recommends -y supervisor

RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# Logstash
RUN \
    curl -s http://sectong.com/downloads/logstash-1.5.4.tar.gz | tar -C /opt -zxv && \
    ln -s /opt/logstash-1.5.4 /opt/logstash && \
    mkdir /var/log/logstash

ADD etc/logstash.conf /etc/supervisor/conf.d/logstash.conf

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
