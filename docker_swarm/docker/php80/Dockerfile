FROM ecr.eclasscloud.hk/ecdock/rockylinux-base:latest

ENV container docker

# Install PHP pacakges
RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
RUN dnf -y module reset php
RUN dnf -y module install php:remi-8.0
#RUN dnf -y module enable php:7.3
RUN dnf -y install php-intl php php-fpm php-pdo php-common php-xml php-mysqlnd php-mbstring php-xmlrpc php-zip php-gd php-curl php-pear php-bcmath php-json supervisor mysql

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --install-dir=bin --filename=composer \
 && php -r "unlink('composer-setup.php');"

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

RUN systemctl enable php-fpm.service \
&& systemctl enable crond.service \
&& systemctl enable memcached.service \
&& systemctl enable supervisord.service \
&& systemctl enable redis.service

RUN dnf -y install https://download.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
&& dnf -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm \
&& dnf -y install --nogpgcheck https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm \
&& dnf -y install https://mirror.yandex.ru/epel/7/x86_64/Packages/s/SDL2-2.0.14-2.el7.x86_64.rpm\
&& dnf -y install ffmpeg \
&& dnf -y install ffmpeg-devel

# Install build tools for node
RUN dnf -y install python2 make gcc-c++

RUN wget https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.0.0-x86_64.rpm && rpm -vi elastic-agent-8.0.0-x86_64.rpm

RUN rm -f elastic-agent-8.0.0-x86_64.rpm

COPY ./elastic-agent.yml /etc/elastic-agent/elastic-agent.yml

RUN systemctl enable elastic-agent

RUN yum clean all \
&& rm -rf /var/cache/yum

CMD ["/usr/sbin/init"]
