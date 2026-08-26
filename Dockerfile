FROM nginx:1.30.4

COPY app/ /usr/share/nginx/html/

EXPOSE 80
