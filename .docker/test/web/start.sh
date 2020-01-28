#!/bin/sh

sed -i -e "s|set \$admin_dir.*|set \$admin_dir /$PS_DIR_ADMIN;|" \
  -e "s|server_name.*|server_name $PS_DOMAIN;|" /etc/nginx/nginx.conf && \
nginx -g "daemon off;"
