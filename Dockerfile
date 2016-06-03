FROM centos:latest
MAINTAINER Teknasyon <admin@teknasyon.com>

# Add remi repository
RUN yum install -y --nogpgcheck epel-release
RUN rpm -qa | grep -q remi-release || rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

RUN sed -i "s|enabled=1|enabled=0|" /etc/yum/pluginconf.d/fastestmirror.conf

# Configure mysql
RUN yum --enablerepo=remi install -y --nogpgcheck wget
RUN wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
RUN yum localinstall mysql-community-release-el7-5.noarch.rpm -y --nogpgcheck
RUN yum --enablerepo=remi install mysql-community-server -y --nogpgcheck
RUN mysql_install_db

# Configure supervisord
RUN yum --enablerepo=remi install -y --nogpgcheck supervisor

# Configure PHP
RUN yum --enablerepo=remi-php56,remi install -y --nogpgcheck \
    gcc \
    make \
    php \
    php-opcache \
    php-apc \
    php-devel \
    pcre-devel \
    php-pear \
    php-pecl-xdebug \
    php-mysqlnd \
    php-pecl-xhprof \
    php-pecl-memcached \
    php-xml \
    php-gd \
    php-mbstring \
    php-mcrypt \
    php-fpm \
    php-gearman \
    php-soap \
    php-json \
    php-intl \
    php-bcmath

# Install NGINX
RUN yum --enablerepo=remi install -y --nogpgcheck nginx
RUN rm -rf /etc/nginx/conf.d/default.conf
RUN rm -rf /etc/nginx/conf.d/ssl.conf
RUN rm -rf /etc/nginx/conf.d/virtual.conf

# Install Memcached
RUN yum --enablerepo=remi install -y --nogpgcheck memcached

# Install gearman
RUN yum --enablerepo=remi install -y --nogpgcheck gearmand

# Configure phalcon
RUN yum --enablerepo=remi install -y --nogpgcheck git-core
RUN git clone --depth=1 git://github.com/phalcon/cphalcon.git
RUN cd /cphalcon/build && ./install
RUN echo "extension=phalcon.so" > /etc/php.d/phalcon.ini
RUN rm -rf /cphalcon

# Configure composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN TMPDIR=/tmp yum clean metadata
RUN TMPDIR=/tmp yum clean all
