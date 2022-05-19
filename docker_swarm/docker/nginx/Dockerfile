FROM ecr.eclasscloud.hk/ecdock/rockylinux-base:latest

ENV container docker

# Install nginx package
RUN yum -y install nginx

RUN mkdir /root/scripts \
mkdir /home/web \
&& useradd eclass \
&& chown eclass:eclass -R /home/web

RUN systemctl enable nginx.service

RUN yum clean all \
&& rm -rf /var/cache/yum

RUN wget https://curl.se/ca/cacert-2021-10-26.pem -P /etc/pki/tls/certs/

RUN mv /etc/pki/tls/certs/cacert-2021-10-26.pem /etc/pki/tls/certs/ca-bundle.crt

RUN wget https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.0.0-x86_64.rpm && rpm -vi elastic-agent-8.0.0-x86_64.rpm

RUN rm -f elastic-agent-8.0.0-x86_64.rpm

COPY ./elastic-agent.yml /etc/elastic-agent/elastic-agent.yml

RUN systemctl enable elastic-agent

EXPOSE 9091 9043

CMD ["/sbin/init"]
