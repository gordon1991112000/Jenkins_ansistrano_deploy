FROM ecdock/centos8-base

ENV container docker

# Install PHP pacakges
#
RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
RUN dnf -y install environment-modules php56-php-intl php56 php56-php-fpm php56-php-pdo php56-php-common php56-php-xml php56-php-mysqlnd php56-php-mbstring php56-php-xmlrpc php56-php-zip php56-php-gd php56-php-curl php56-php-pear php56-php-bcmath php56-php-json supervisor mysql

# Install composer
RUN php56 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php56 composer-setup.php --install-dir=bin --filename=composer \
 && php56 -r "unlink('composer-setup.php');"

# Install nodejs
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
&& source ~/.bash_profile \
&& nvm install v8.9.4

# Install redis
RUN yum install -y redis

# Install memcahed
RUN yum -y install memcached libmemcached

RUN mkdir /root/scripts \
mkdir /home/web \
&& useradd eclass \
&& chown eclass:eclass -R /home/web

RUN systemctl enable php56-php-fpm \
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

RUN yum clean all \
&& rm -rf /var/cache/yum \
&& ln -s /usr/bin/php56 /usr/bin/php

# Install build tools for node
RUN dnf -y install python2 make gcc-c++

RUN touch o.txt

CMD ["/usr/sbin/init"]
