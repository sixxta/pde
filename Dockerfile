FROM alpine:3.10

RUN apk update && \
    apk add nginx && \
    apk add curl && \
    mkdir -p /run/nginx && \
    cd /etc/nginx/conf.d && \
    mv default.conf default.conf.bak

COPY app.conf /etc/nginx/conf.d/app.conf

COPY index.html /var/www/index.html

CMD ["nginx", "-g", "daemon off;"]
