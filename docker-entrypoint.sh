#!/bin/sh

nginx -g "daemon off;" &
consul-template -config=/etc/consul-template-config.hcl