FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY otus.txt index.html /opt/
RUN mkdir /opt/check && mkdir /opt/js
COPY js.html  /opt/js/index.html
COPY check.html  /opt/check/index.html
CMD ["nginx","-g","daemon off;"]
