#!/bin/bash

Ver="7u75v1"
JDK_VER="1.7.0_75"
JDK_MD5="6f1f81030a34f7a9c987f8b68a24d139"
JDK_URL="http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz"
image="docker.xlands-inc.com/baoyu/java"

current_dir=`dirname $0`
current_dir=`readlink -f $current_dir`
cd ${current_dir} && export current_dir

_get_java() {
  wget --quiet --no-cookies \
    --no-check-certificate  \
    -O ${current_dir}/jdk-${JDK_VER}.tar.gz \
    --header "Cookie: oraclelicense=accept-securebackup-cookie"  \
    "${JDK_URL}"
}
_md5sum() {
  echo "${JDK_MD5} ${current_dir}/jdk-${JDK_VER}.tar.gz" | md5sum -c # &>/dev/null
  [ $? -eq 0 ] && return 1
  return 0
}
_tar_and_clean() {

  [ -d ./jdk ] && rm -rf ./jdk

  tar xf ${current_dir}/jdk-${JDK_VER}.tar.gz -C ${current_dir} \
    && rm -rf ${current_dir}/jdk${JDK_VER}/{COPYRIGHT,LICENSE,man,README.html,release,src.zip}              \
    && rm -f  ${current_dir}/jdk${JDK_VER}/{THIRDPARTYLICENSEREADME-JAVAFX.txt,THIRDPARTYLICENSEREADME.txt} \
    && mv ./jdk${JDK_VER} ./jdk \
    && touch ./jdk/${JDK_VER}.lock
}
if _md5sum &>/dev/null;then
  _get_java
fi

if _md5sum ;then
  echo "MD5sum error"
  exit 127
fi
if [ ! -f ./jdk/${JDK_VER}.lock ] ;then
  _tar_and_clean
fi

sudo docker build -t ${image}:${Ver} .
