# oracle jdk 7
#
# Version 1.0

FROM centos
MAINTAINER djluo <dj.luo@baoyugame.com>

ENV JDK_VER 1.7.0_67
ENV JDK_URL http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz
ENV JDK_MD5 81e3e2df33e13781e5fac5756ed90e67

ENV HOME  /home/
WORKDIR   /home/

RUN rpm --import /etc/pki/rpm-gpg/RPM*
RUN yum install -y wget tar && yum clean all

RUN wget --quiet                \
         --no-cookies           \
         --no-check-certificate \
         -O /home/jdk.tar.gz    \
         --header "Cookie: oraclelicense=accept-securebackup-cookie"  \
         "${JDK_URL}"

RUN echo "${JDK_MD5} /home/jdk.tar.gz" | md5sum -c

RUN tar xf /home/jdk.tar.gz -C /home/ \
        && rm -rf /home/jdk${JDK_VER}/{COPYRIGHT,LICENSE,man,README.html,release,src.zip}              \
        && rm -f  /home/jdk${JDK_VER}/{THIRDPARTYLICENSEREADME-JAVAFX.txt,THIRDPARTYLICENSEREADME.txt} \
        && rm -rf /home/jdk.tar.gz

RUN ln -sv /home/jdk${JDK_VER} /home/jdk

ENV JAVA_HOME /home/jdk
ENV PATH      /home/jdk/bin:$PATH
ENV CLASSPATH .:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CLASSPATH
