FROM centos:latest

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum install httpd -y && \
    yum clean all

#copying .index html folder to path of the container (this is the 1st way)
#COPY ./index /var/www/html/

#copying .index html folder to path of the container (this is the 2nd way)
WORKDIR /var/www/html/
COPY ./index .

EXPOSE 80

VOLUME /var/log/httpd

CMD [ "httpd", "-D", "FOREGROUND" ]