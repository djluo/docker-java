# oracle jdk 7
#
# Version 1.0

FROM centos
MAINTAINER djluo <dj.luo@baoyugame.com>

ENV JDK   "1.7.0_67"
ENV HOME  /home/
WORKDIR   /home/

ADD ./java.sh /etc/profile.d/java.sh
RUN yum install -y wget tar
#RUN wget --no-cookies           \
#         --no-check-certificate \
#         --header "Cookie: oraclelicense=accept-securebackup-cookie"  \
#         -O /home/jdk.tar.gz
#         http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz
RUN wget -O /home/jdk.tar.gz http://192.168.1.96/jdk.tar.gz

RUN tar xf /home/jdk.tar.gz -C /home/ \
        && rm -rf /home/jdk1.7.0_67/{COPYRIGHT,LICENSE,man,README.html,release,src.zip}              \
        && rm -f  /home/jdk1.7.0_67/{THIRDPARTYLICENSEREADME-JAVAFX.txt,THIRDPARTYLICENSEREADME.txt} \
        && rm -rf /home/jdk.tar.gz
RUN ln -sv /home/jdk1.7.0_67 /home/jdk
