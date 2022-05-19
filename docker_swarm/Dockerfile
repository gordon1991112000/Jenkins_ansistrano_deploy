FROM centos:8

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

# Update Package
###RUN yum -y update

# Install epel repo
RUN yum -y install epel-release

# Install packages
RUN yum -y install crontabs rsyslog net-tools telnet iputils wget openssh-clients libmcrypt-devel libtomcrypt-devel supervisor crontabs rsyslog nginx

# Set timezone 
RUN rm -rf /etc/localtime \
 && ln -s /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime

# Install PHP pacakges
RUN dnf -y module enable php:7.3
RUN dnf -y install php php-fpm php-pdo php-common php-xml php-mysqlnd php-mbstring php-recode php-xmlrpc php-zip php-gd php-curl php-pear php-bcmath php-json
  
# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --install-dir=bin --filename=composer \
 && php -r "unlink('composer-setup.php');" 

# Install mariadb
RUN yum -y install mariadb-server mariadb

# Install nodejs
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
&& source ~/.bash_profile \
&& nvm install v12.18.4

# Install redis
RUN yum install -y redis 

# Install memcahed
RUN yum -y install memcached libmemcached

RUN mkdir /root/scripts \
mkdir /home/web \
&& useradd eclass \
&& chown eclass:eclass -R /home/web

#COPY ./docker-entrypoint.sh /root/scripts

#RUN chmod +x /root/scripts/docker-entrypoint.sh

RUN systemctl enable mariadb.service \
&& systemctl enable php-fpm.service \
&& systemctl enable crond.service \
&& systemctl enable memcached.service \
&& systemctl enable supervisord.service \
&& systemctl enable redis.service \
&& systemctl enable nginx.service 

RUN dnf -y install https://download.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
&& dnf -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm \
&& dnf -y install --nogpgcheck https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm \
&& dnf -y install https://mirror.yandex.ru/epel/7/x86_64/Packages/s/SDL2-2.0.14-2.el7.x86_64.rpm\
&& dnf -y install ffmpeg \
&& dnf -y install ffmpeg-devel

RUN yum clean all \
&& rm -rf /var/cache/yum

EXPOSE 80
EXPOSE 443
EXPOSE 3306

CMD ["/usr/sbin/init"]


