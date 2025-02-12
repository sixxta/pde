FROM alpine:3.10

ARG CONSUL_TEMPLATE_VERSION=0.20.0

RUN apk update && \
    apk add nginx && \
    apk add curl && \
    mkdir -p /run/nginx && \
    cd /etc/nginx/conf.d && \
    mv default.conf default.conf.bak

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /usr/bin/
RUN unzip /usr/bin/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /usr/local/bin/consul-template && \
    rm -rf /usr/bin/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip

COPY app.conf /etc/nginx/conf.d/app.conf

COPY index.html /var/www/index.html

COPY targets.ctmpl /etc/targets.ctmpl

COPY consul-template-config-ro.hcl /etc/consul-template-config.hcl

COPY docker-entrypoint.sh /etc/docker-entrypoint.sh

CMD ["/bin/sh", "/etc/docker-entrypoint.sh"]
