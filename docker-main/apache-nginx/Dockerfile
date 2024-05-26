FROM centos:latest

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update -y && \
    yum install httpd -y && \
    yum clean all

COPY ./web /var/www/html

EXPOSE 80

CMD [ "/usr/sbin/httpd", "-D", "FOREGROUND" ]