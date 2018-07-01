#========================
#   dao cloud demo 1
#========================
# Using a compact OS
FROM alpine:latest

MAINTAINER Golfen Guo <golfen.guo@daocloud.io>

# Install and configure Nginx
RUN apk --update add nginx

# 将文件 nginx.conf 中的 root   html; 替换 /usr/share/nginx/html;  #只是分隔符而已，为满足格式需要
RUN sed -i "s#root   html;#root   /usr/share/nginx/html;#g" /etc/nginx/nginx.conf

# 建立快捷方式 stdout 存放 access.log 的文件内容
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

# Add 2048 stuff into Nginx server
COPY . /usr/share/nginx/html

# 添加数据卷
VOLUME /home/dev-soft /home/dev

EXPOSE 80

# Start Nginx and keep it running background and start php
CMD sed -i "s/ContainerID: /ContainerID: "$(hostname)"/g" /usr/share/nginx/html/index.html && nginx -g "pid /tmp/nginx.pid; daemon off;"
