FROM centos:centos7

MAINTAINER Rafal S. <rafal@maracje.pl>

ENV bamboo_url=''
ENV bamboo_jar='bamboo-agent-5.10.0.jar'
ENV MAVEN_1='https://archive.apache.org/dist/maven/binaries/apache-maven-2.1.0-bin.zip'
ENV MAVEN_2='https://archive.apache.org/dist/maven/maven-3/3.0.4/binaries/apache-maven-3.0.4-bin.zip'

ADD ${bamboo_url}/bamboo/admin/agent/${bamboo_jar} /
COPY supervisord.conf /etc/supervisord.conf
ADD ${MAVEN_1} /
ADD ${MAVEN_2} /

RUN yum -y install unzip python-setuptools java-1.6.0-openjdk-devel java-1.7.0-openjdk-devel java-1.8.0-openjdk-devel gcc gcc-c++ cmake make automake git curl cvs mercurial && \
easy_install supervisor && \
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash - && \
yum -y install nodejs && \
npm install -g angular-cli && \
unzip /\*maven\*.zip

ENV PATH ${PATH}:/apache-maven-2.1.0:/apache-maven-3.0.4:/usr/lib/jvm/java-1.6.0/jre:/usr/lib/jvm/java-1.7.0/jre:/usr/lib/jvm/java-1.8.0/jre

CMD /usr/bin/supervisord -c /etc/supervisord.conf 
