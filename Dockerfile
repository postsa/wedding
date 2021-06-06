FROM nginx
WORKDIR /usr/share/nginx/html
COPY ./website .
COPY wedding.conf /etc/nginx/conf.d/
