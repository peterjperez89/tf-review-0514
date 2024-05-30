FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y nginx && \
    apt-get clean

EXPOSE 80

COPY ./index/dist/ /usr/share/nginx/html

VOLUME /var/log/nginx

CMD [ "nginx", "-g", "daemon off;" ]