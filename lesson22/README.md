# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **OpenVPN** - утилита для создания VPN соединений



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson22** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

VPN
1. Между двумя виртуалками поднять vpn в режимах
- tun
- tap
Прочуствовать разницу.

2. Поднять RAS на базе OpenVPN с клиентскими сертификатами, подключиться с локальной машины на виртуалку

Используемые файлы и директории:
- В директории lesson22 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания

3*. Самостоятельно изучить, поднять ocserv и подключиться с хоста к виртуалке 


# Как проверить домашнее задание?

Склонируйте репозиторий:

```
git clone git@github.com:mercury131/otus-linux.git
```

Установите необходимые плагины для vagrant:

```
vagrant plugin install vagrant-reload
```

Для запуска Vagrantfile автоматизированными шагами выполните:

```
cd otus-linux/lesson22
vagrant up 
```

Посмотреть выполненный Vagrant Provisioning  и убедиться что были запущены тесты iperf и выполнен ping от клиентской машины к vpn серверу (подключение по сертификатам.)

```
    vpnclient2: TEST TAP #########################################################
    vpnclient2: Connecting to host 10.10.10.1, port 5201
    vpnclient2: [  4] local 10.10.10.2 port 41922 connected to 10.10.10.1 port 5201
    vpnclient2: [ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
    vpnclient2: [  4]   0.00-5.00   sec  33.2 MBytes  55.8 Mbits/sec   20    212 KBytes
    vpnclient2: [  4]   5.00-10.01  sec  40.7 MBytes  68.2 Mbits/sec    9    190 KBytes
    vpnclient2: [  4]  10.01-15.00  sec  44.8 MBytes  75.2 Mbits/sec   14    179 KBytes
    vpnclient2: [  4]  15.00-20.00  sec  44.8 MBytes  75.2 Mbits/sec   13    179 KBytes
    vpnclient2: [  4]  20.00-25.00  sec  44.6 MBytes  74.9 Mbits/sec    7    184 KBytes
    vpnclient2: [  4]  25.00-30.01  sec  46.1 MBytes  77.2 Mbits/sec    4    190 KBytes
    vpnclient2: [  4]  30.01-35.01  sec  46.9 MBytes  78.6 Mbits/sec    3    227 KBytes
    vpnclient2: [  4]  35.01-40.00  sec  44.8 MBytes  75.2 Mbits/sec    6    223 KBytes
    vpnclient2: - - - - - - - - - - - - - - - - - - - - - - - - -
    vpnclient2: [ ID] Interval           Transfer     Bandwidth       Retr
    vpnclient2: [  4]   0.00-40.00  sec   346 MBytes  72.5 Mbits/sec   76             sender
    vpnclient2: [  4]   0.00-40.00  sec   345 MBytes  72.3 Mbits/sec                  receiver
    vpnclient2:
    vpnclient2: iperf Done.
	
	
    vpnclient2: TEST TUN #########################################################
    vpnclient2: Connecting to host 10.11.10.4, port 555
    vpnclient2: [  4] local 10.11.10.5 port 51606 connected to 10.11.10.4 port 555
    vpnclient2: [ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
    vpnclient2: [  4]   0.00-5.01   sec  45.3 MBytes  75.9 Mbits/sec   15    215 KBytes
    vpnclient2: [  4]   5.01-10.00  sec  49.7 MBytes  83.5 Mbits/sec    4    223 KBytes
    vpnclient2: [  4]  10.00-15.00  sec  45.9 MBytes  76.9 Mbits/sec    7    251 KBytes
    vpnclient2: [  4]  15.00-20.00  sec  42.6 MBytes  71.5 Mbits/sec   14    238 KBytes
    vpnclient2: [  4]  20.00-25.01  sec  43.3 MBytes  72.5 Mbits/sec    5    242 KBytes
    vpnclient2: [  4]  25.01-30.01  sec  46.1 MBytes  77.4 Mbits/sec    6    240 KBytes
    vpnclient2: [  4]  30.01-35.00  sec  43.2 MBytes  72.5 Mbits/sec    5    247 KBytes
    vpnclient2: [  4]  35.00-40.00  sec  44.5 MBytes  74.7 Mbits/sec    3    244 KBytes
    vpnclient2: - - - - - - - - - - - - - - - - - - - - - - - - -
    vpnclient2: [ ID] Interval           Transfer     Bandwidth       Retr
    vpnclient2: [  4]   0.00-40.00  sec   361 MBytes  75.6 Mbits/sec   59             sender
    vpnclient2: [  4]   0.00-40.00  sec   360 MBytes  75.5 Mbits/sec                  receiver
    vpnclient2:
    vpnclient2: iperf Done.


```


```
[vagrant@clientras2 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:ae:50:9e brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic enp0s3
       valid_lft 86249sec preferred_lft 86249sec
    inet6 fe80::e48:1f70:b88d:b3f6/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:ed:53:d4 brd ff:ff:ff:ff:ff:ff
    inet 192.168.255.4/29 brd 192.168.255.7 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feed:53d4/64 scope link
       valid_lft forever preferred_lft forever
4: tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN group default qlen 100
    link/none
    inet 10.10.10.2/24 brd 10.10.10.255 scope global tun0
       valid_lft forever preferred_lft forever
    inet6 fe80::f7e0:1ac9:a9fe:135e/64 scope link flags 800
       valid_lft forever preferred_lft forever
[vagrant@clientras2 ~]$ ping 10.10.10.1
PING 10.10.10.1 (10.10.10.1) 56(84) bytes of data.
64 bytes from 10.10.10.1: icmp_seq=1 ttl=64 time=1.02 ms
64 bytes from 10.10.10.1: icmp_seq=2 ttl=64 time=0.661 ms
64 bytes from 10.10.10.1: icmp_seq=3 ttl=64 time=1.21 ms
64 bytes from 10.10.10.1: icmp_seq=4 ttl=64 time=0.665 ms
64 bytes from 10.10.10.1: icmp_seq=5 ttl=64 time=0.714 ms
^C
--- 10.10.10.1 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4005ms
rtt min/avg/max/mdev = 0.661/0.855/1.210/0.223 ms

```

Разница между TUN и TAP в том что TAP работает на канальном уровне, в то время как TUN работает на сетевом уровне модели OSI.

Соответственно TAP интерфейс имеет больший оверхед чем TUN, т.к. оперирует кадрами ethernet, а не ip пакетами как TAP.



Используемые конфиги:

Сервер TUN:

```

local 192.168.10.1
port 1195
dev tun
ifconfig 10.11.10.4 255.255.255.0
topology subnet
secret /etc/openvpn/static.key
comp-lzo
status /var/log/openvpn-status2.log
log /var/log/openvpn2.log
verb 3

```

Клиент TUN:

```
dev tun
port 1195
remote 192.168.10.1
ifconfig 10.11.10.5 255.255.255.0
topology subnet
route 192.168.10.0 255.255.255.0
secret /etc/openvpn/static.key
comp-lzo
status /var/log/openvpn-status2.log
log /var/log/openvpn2.log
verb 3

```

Сервер TAP:

```
local 192.168.255.1
dev tap
ifconfig 10.10.10.1 255.255.255.0
topology subnet
secret /etc/openvpn/static.key
comp-lzo
status /var/log/openvpn-status.log
log /var/log/openvpn.log
verb 3

```

Клиент TAP:

```
dev tap
remote 192.168.255.1
ifconfig 10.10.10.2 255.255.255.0
topology subnet
route 192.168.255.0 255.255.255.248
secret /etc/openvpn/static.key
comp-lzo
status /var/log/openvpn-status.log
log /var/log/openvpn.log
verb 3

```


Сервер TUN (подключение по сертификату):

```
port 1207
proto udp
dev tun
ca /etc/openvpn/pki/ca.crt
cert /etc/openvpn/pki/issued/server.crt
key /etc/openvpn/pki/private/server.key
dh /etc/openvpn/pki/dh.pem
server 10.10.10.0 255.255.255.0
topology subnet
client-to-client
client-config-dir /etc/openvpn/client
keepalive 10 120
comp-lzo
persist-key
persist-tun
status /var/log/openvpn-status.log
log /var/log/openvpn.log
verb 3

```

Клиент TUN (подключение по сертификату):

```
dev tun
proto udp
remote 192.168.255.3 1207
client
resolv-retry infinite
ca ./ca.crt
cert ./client.crt
key ./client.key
persist-key
persist-tun
comp-lzo
verb 3
```

Метод генерации сертификатов (используется easyrsa):

```
yum install -y easy-rsa
```

```
cd /etc/openvpn/
/usr/share/easy-rsa/3.0.3/easyrsa init-pki
echo 'rasvpn' | /usr/share/easy-rsa/3.0.3/easyrsa build-ca nopass
echo 'rasvpn' | /usr/share/easy-rsa/3.0.3/easyrsa gen-req server nopass
echo 'yes' | /usr/share/easy-rsa/3.0.3/easyrsa sign-req server server
/usr/share/easy-rsa/3.0.3/easyrsa gen-dh
openvpn --genkey --secret ta.key
```

Сертификаты клиента:


```
echo 'client' | /usr/share/easy-rsa/3/easyrsa gen-req client  nopass
echo 'yes' | /usr/share/easy-rsa/3/easyrsa sign-req client client
```

Сертификаты используемые на клиенте:

```
/etc/openvpn/pki/ca.crt
/etc/openvpn/pki/issued/client.crt
/etc/openvpn/pki/private/client.key
```

Также поднята VM с ocserv. 

Установка и настройка VM:

```
sysctl net.ipv4.conf.all.forwarding=1
setenforce 0
yum install -y epel-release
yum update -y
yum install -y ocserv gnutls-utils
mkdir /etc/ocserv/cert
cd /etc/ocserv/cert/
cp /vagrant/ocserv/ca.tmpl /etc/ocserv/cert/ca.tmpl
certtool --generate-privkey --outfile ca-key.pem
certtool --generate-self-signed --load-privkey ca-key.pem --template ca.tmpl --outfile ca-cert.pem
cp /vagrant/ocserv/server.tmpl /etc/ocserv/server.tmpl
certtool --generate-privkey --outfile server-key.pem
certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template /etc/ocserv/server.tmpl --outfile server-cert.pem
mkdir /etc/ocserv/ssl/
cp -f ca-cert.pem server-key.pem server-cert.pem /etc/ocserv/ssl/
mv /etc/ocserv/ocserv.conf /etc/ocserv/ocserv.conf.bak
cp -f /vagrant/ocserv/ocserv.conf /etc/ocserv/ocserv.conf
firewall-cmd --add-port=443/tcp --permanent
firewall-cmd --add-port=443/udp --permanent
firewall-cmd --permanent --add-masquerade
csf -r
echo "net.ipv4.ip_forward = 1" >>  /etc/sysctl.conf
touch /etc/ocserv/passwd
ocpasswd -c /etc/ocserv/passwd -g default test
systemctl start ocserv
systemctl enable ocserv
systemctl status ocserv


[root@ocserv ~]# systemctl status ocserv
● ocserv.service - OpenConnect SSL VPN server
   Loaded: loaded (/usr/lib/systemd/system/ocserv.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2020-02-13 23:53:10 NZDT; 17min ago
     Docs: man:ocserv(8)
 Main PID: 4646 (ocserv-main)
   CGroup: /system.slice/ocserv.service
           ├─4646 ocserv-main
           └─4661 ocserv-sm

Feb 13 23:53:10 ocserv ocserv[4646]: note: skipping 'pid-file' config option
Feb 13 23:53:10 ocserv ocserv[4646]: note: setting 'plain' as primary authentication method
Feb 13 23:53:10 ocserv ocserv[4646]: note: setting 'file' as supplemental config option
Feb 13 23:53:10 ocserv ocserv[4646]: listening (TCP) on 0.0.0.0:443...
Feb 13 23:53:10 ocserv ocserv[4646]: listening (TCP) on [::]:443...
Feb 13 23:53:10 ocserv ocserv[4646]: main: initialized ocserv 0.12.6
Feb 13 23:53:10 ocserv ocserv[4646]: listening (UDP) on 0.0.0.0:443...
Feb 13 23:53:10 ocserv ocserv[4646]: listening (UDP) on [::]:443...
Feb 13 23:53:10 ocserv ocserv[4661]: sec-mod: reading supplemental config from files
Feb 13 23:53:10 ocserv ocserv[4661]: sec-mod: sec-mod initialized (socket: /var/lib/ocserv/ocserv.sock.d99691da)


```