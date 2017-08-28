# Version 0.0.2
FROM centos:latest
MAINTAINER Ugo Bellavance "ugob@lubik.ca"
RUN yum -y update && yum clean all
RUN yum -y install epel-release
RUN yum -y install fping httpd mod_ssl nagios nagios-plugins-all postfix || true
RUN touch /var/run/nagios.pid
RUN chown nagios.nagios /var/run/nagios.pid
RUN chmod u+s /usr/bin/ping
RUN echo "Hello World" > /var/www/html/index.html || true
RUN mkdir /root/bin
RUN mkdir /var/log/nagios/rw
RUN chown nagios.nagios /var/log/nagios/rw/
RUN echo "RedirectMatch ^/$ /nagios/" >> /etc/httpd/conf/httpd.conf
CMD [ "/bin/bash", "-c", "/usr/bin/yum -y update;/usr/sbin/httpd;/usr/sbin/postfix start;/usr/sbin/nagios /etc/nagios/nagios.cfg" ]
VOLUME /etc/nagios
VOLUME /var/spool/nagios
VOLUME /etc/httpd
EXPOSE 80
EXPOSE 443
