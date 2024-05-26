#use official ubuntu base image with the tag "latest"s
FROM ubuntu:latest

#install apache (ubuntu)
RUN apt-get -y update
RUN apt-get -y install apache2

#copy the contents of my /web folder to the container's /var/www/html directory
COPY ./web/index.html /var/www/html

#expose port 80
EXPOSE 80

#start apache service
CMD ["apache2ctl", "-D", "FOREGROUND"]
