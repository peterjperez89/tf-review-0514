FROM ubuntu:latest

RUN apt-get -y update && \
    apt-get -y install apache2

COPY ./web/test/ /var/www/html

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]