FROM registry.eclasscloud.hk/ecdock/rockylinux-base:latest

# https://github.com/MonolithProjects/docker-systemd-centos8/blob/master/Dockerfile
ENV \
    container=docker \
	MY_USER=eclass \
	MY_GROUP=eclass \
	MY_UID=1000 \
	MY_GID=1000

#RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
#systemd-tmpfiles-setup.service ] || rm -f $i; done); \
#rm -f /lib/systemd/system/multi-user.target.wants/*;\
#rm -f /etc/systemd/system/*.wants/*;\
#rm -f /lib/systemd/system/local-fs.target.wants/*; \
#rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
#rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
#rm -f /lib/systemd/system/basic.target.wants/*;\
#rm -f /lib/systemd/system/anaconda.target.wants/*;
#VOLUME [ "/sys/fs/cgroup" ]

# Update Package
#RUN yum -y update

# Install Development Tools packages
# RUN yum -y group install "Development Tools"

# Install epel repo
RUN yum -y install epel-release

# Set timezone
RUN rm -rf /etc/localtime \
 && ln -s /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime

# Install basic packages
RUN yum -y install crontabs rsyslog net-tools telnet iputils wget openssh-clients git htop less nano openssl less unzip vim iputils initscripts sudo which mlocate chrony

RUN systemctl enable crond.service \
&& systemctl enable rsyslog.service \
&& systemctl enable chronyd.service

RUN yum clean all \
&& rm -rf /var/cache/yum

CMD ["/sbin/init"]
