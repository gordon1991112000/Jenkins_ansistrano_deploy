FROM ecdock/centos7-base

ENV container docker

# Install packages
RUN /usr/bin/yum -y remove libgcj
RUN /usr/bin/yum -y install yum-fastestmirror
RUN /usr/bin/yum -y install yum-plugin-fastestmirror.noarch
RUN /usr/bin/yum -y groupinstall "Base" "Development Tools"
RUN /usr/bin/yum -y install mariadb-server mariadb httpd php aspell epel-release aspell-en
RUN /usr/bin/yum -y install epel-release* php-imap* php-mcrypt psmisc xinetd dos2unix sudo expect lynx libgcc cpp gcc libstdc++ libstdc++ gcc-c++ autoconf automake automake14 automake15 automake16 automake17 libgcj-devel zlib-devel gcc-java freetype freetype atk atk-devel fontconfig-devel libX11-devel libpng-devel libjpeg-devel libX11-devel mesa-libGL-devel  xorg-x11-proto-devel libXdmcp-devel libXpm-devel gd-devel pango libXrender-devel libXft-devel libXext-devel cairo-devel pango-devel libtiff-devel libexif-devel libc-client libwmf libXcursor-devel libXfixes-devel libXi-devel libXinerama-devel libXrandr-devel gtk2-devel libwmf-devel ImageMagick libdbi libdbi-dbd-mysql libpng nano perl-suidperl mysql ghostscript-devel lcms-devel libICE-devel libSM-devel libXt-devel ImageMagick-devel ImageMagick-perl mysql-server mysql-devel w3m php php-devel php-cli php-ldap php-common php-bcmath php-dba php-gd php-imap php-mbstring php-pdo php-mysql php-ncurses php-odbc php-pear php-soap php-xml php-xmlrpc  libtool-ltdl-devel php-mcrypt  php-pspell sendmail-cf screen syslog perl-Digest-HMAC xmlsec1 xmlsec1-openssl php-pecl-memcache aspell-en glances net-tools redis php-pecl-redis mod_ssl  libreoffice-headless libreoffice-core libreoffice ghostscript libreoffice-langpack-zh-Hans libreoffice-langpack-zh-Hant tesseract-langpack-chi_sim tesseract-langpack-chi_tra

RUN mkdir /root/scripts \
mkdir /home/eclass \
&& useradd eclass \
&& chown eclass:eclass -R /home/eclass

RUN systemctl enable httpd \
&& systemctl enable mariadb 

RUN yum clean all \
&& rm -rf /var/cache/yum

COPY --chown=root:root conf/ip/crontab /etc/crontab
COPY --chown=root:root conf/ip/php.ini /etc/php.ini
COPY --chown=root:root conf/ip/my.cnf /etc/my.cnf
COPY --chown=root:root conf/ip/sudoers /etc/sudoers
COPY --chown=root:root conf/ZendGuardLoader.so /usr/lib64/php/modules/ZendGuardLoader.so

RUN mv /etc/httpd /etc/httpd_org

COPY --chown=root:root conf/ip/httpd /etc/httpd
RUN /usr/bin/yum -y install mod_auth_token 
RUN rpm -Uvh https://download1.rpmfusion.org/nonfree/el/updates/7/x86_64/m/mod_h264_streaming-2.2.7-6.el7.x86_64.rpm

# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
&& sudo mv composer.phar /usr/local/bin/composer

# Install nodejs and npm
RUN yum install -y nodejs npm && npm install -g bower

RUN echo "exclude=php* httpd* kernel* spamassassin* amavisd* clamav* sendmail* postfix* docker* mariadb*" >> /etc/yum.conf

RUN touch /var/log/mysql-slow.log \
&& chown mysql:mysql /var/log/mysql-slow.log \
&& chown mysql:mysql -R /var/lib/mysql

CMD ["/usr/sbin/init"]

