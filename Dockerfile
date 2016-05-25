FROM debian
# changing to debian because of https://github.com/docker/hub-feedback/issues/461
MAINTAINER daisuke 

#RUN yum install --nogpgcheck -y httpd 
#RUN yum install -y git
#RUN yum install -y wget

RUN echo "Acquire::http { Proxy \"http://test.glytoucan.org:3142\"; };" > /etc/apt/apt.conf.d/02Proxy
RUN apt-get update && apt-get install -y git wget && rm -rf /var/lib/apt/lists/*

RUN mkdir /stanza

WORKDIR /stanza
RUN wget https://github.com/togostanza/ts/releases/download/v0.0.8/ts_0.0.8_linux_amd64.tar.gz
RUN tar zxf ts_0.0.8_linux_amd64.tar.gz 

VOLUME /stanza/glytoucan_stanza/entry_provider 
WORKDIR /stanza/glytoucan_stanza/entry_provider 

EXPOSE 8080
CMD ["/stanza/ts_0.0.8_linux_amd64/ts", "server"]

