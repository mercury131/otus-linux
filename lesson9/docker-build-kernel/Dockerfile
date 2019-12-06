
FROM centos:centos7

RUN yum install openssl ncurses-devel make gcc bc openssl-devel elfutils-libelf-devel rpm-build wget flex bison rsync -y

COPY .config /tmp/.config

RUN  wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.3.8.tar.xz && tar xvf linux-5.3.8.tar.xz

RUN	 cd /linux-5.3.8 && cp /tmp/.config /linux-5.3.8/.config && cat  /tmp/.config && yes "" | make oldconfig &&	 make rpm-pkg 


CMD ["/bin/sh"]
