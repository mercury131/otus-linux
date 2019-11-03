#!/bin/bash

# Install packages
yum install ncurses-devel make gcc bc openssl-devel elfutils-libelf-devel rpm-build wget flex bison rsync -y
# Install new kernel
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.3.8.tar.xz
tar xvf linux-5.3.8.tar.xz
cd linux-5.3.8
cp -v /boot/config-`uname -r` .config
yes "" | make oldconfig
make rpm-pkg
rpm -iUv ~/rpmbuild/RPMS/x86_64/*.rpm
# Reboot VM
shutdown -r now
