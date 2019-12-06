
FROM alpine

RUN apk update && apk add nginx && apk del *-dev build-base autoconf libtool && rm -rf /var/cache/apk/* /tmp/*

RUN  mkdir -p /usr/share/nginx/html && mkdir -p /run/nginx && mkdir -p /var/lib/nginx/tmp

COPY index.html /usr/share/nginx/html/

COPY default.conf /etc/nginx/conf.d/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
