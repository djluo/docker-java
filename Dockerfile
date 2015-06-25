# oracle jdk 7
#
# Version 2.0

FROM       docker.xlands-inc.com/baoyu/debian
MAINTAINER djluo <dj.luo@baoyugame.com>

ADD ./jdk/ /home/jdk/

ENV JAVA_HOME /home/jdk
ENV CLASSPATH .:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CLASSPATH
RUN echo 'PATH=/home/jdk/bin:$PATH' >> /etc/bash.bashrc

#RUN export http_proxy="http://172.17.42.1:8080/" \
RUN export DEBIAN_FRONTEND=noninteractive     \
    && apt-get update \
    && apt-get install -y cronolog \
    && apt-get clean  \
    && unset http_proxy DEBIAN_FRONTEND \
    && rm -rf usr/share/locale \
    && rm -rf usr/share/man    \
    && rm -rf usr/share/doc    \
    && rm -rf usr/share/info
