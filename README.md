# 介绍
基于CentOS 7的Oracle jdk容器。

## 创建镜像：
1. 获取：
<pre>
cd ~
git clone https://github.com/djluo/docker-java.git
</pre>
2. 构建镜像（依赖网络,会从Oracle官网下载jdk）：
<pre>
cd ~/docker-java
sudo docker build -t java   .
sudo docker build -t java:1 .
</pre>
3. 启动容器&测试：
<pre>
sudo docker run -it --rm java java -version
</pre>
