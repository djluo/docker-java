#!/bin/bash

Ver="8u65"
JDK_VER="1.8.0_65"
JDK_MD5="196880a42c45ec9ab2f00868d69619c0"
JDK_URL="http://download.oracle.com/otn-pub/java/jdk/${Ver}-b17/jdk-${Ver}-linux-x64.tar.gz"
image="docker.xlands-inc.com/baoyu/java8"

current_dir=`dirname $0`
current_dir=`readlink -f $current_dir`
cd ${current_dir} && export current_dir

_get_java() {
  wget --no-cookies \
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
    && rm -rf ${current_dir}/jdk${JDK_VER}/db \
    && rm -rf ${current_dir}/jdk${JDK_VER}/{COPYRIGHT,LICENSE,man,README.html,release,src.zip}              \
    && rm -f  ${current_dir}/jdk${JDK_VER}/{THIRDPARTYLICENSEREADME-JAVAFX.txt,THIRDPARTYLICENSEREADME.txt} \
    && rm -f  ${current_dir}/jdk${JDK_VER}/javafx-src.zip \
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
