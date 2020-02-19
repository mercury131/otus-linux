# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Bind** - DNS сервер



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson24** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

настраиваем split-dns
взять стенд https://github.com/erlong15/vagrant-bind
добавить еще один сервер client2
завести в зоне dns.lab
имена
web1 - смотрит на клиент1
web2 смотрит на клиент2

завести еще одну зону newdns.lab
завести в ней запись
www - смотрит на обоих клиентов

настроить split-dns
клиент1 - видит обе зоны, но в зоне dns.lab только web1

клиент2 видит только dns.lab

*) настроить все без выключения selinux




Используемые файлы и директории:
- В директории lesson24 расположен Vagrantfile с образами Centos 7 и автоматическими шагами развертывания

В ходе выполнения данного задания не использовался готовый стенд https://github.com/erlong15/vagrant-bind, а разворачивался, свой аналогичный, с нуля.

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
cd otus-linux/lesson24
vagrant up 
```

Далее зайдите на машину Client1 и выполните dns запросы:

```
vagrant ssh Client1
sudo -i

nslookup web1.dns.lab

nslookup web2.dns.lab

```

Далее зайдите на машину Client2 и выполните dns запросы:

```
vagrant ssh Client2
sudo -i

nslookup web1.dns.lab

nslookup newdns.lab

```


Настройка DNS сервера BIND (Master / Slave / SplitDNS)

Настройка Master. 

Устанавливем пакет bind:

```
yum install bind* -y
```

Выставляем разрешения SELinux:

```
semanage fcontext -a -t named_conf_t /etc/named.conf
semanage fcontext -a -t named_conf_t /etc/named.rfc1912.zones
```

Редактируем конфиг bind

```
vi /etc/named.conf


//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//
// See the BIND Administrator's Reference Manual (ARM) for details about the
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html

options {
	listen-on port 53 { 127.0.0.1; 192.168.40.1; };
	listen-on-v6 port 53 { ::1; };
	directory 	"/var/named";
	dump-file 	"/var/named/data/cache_dump.db";
	statistics-file "/var/named/data/named_stats.txt";
	memstatistics-file "/var/named/data/named_mem_stats.txt";
	recursing-file  "/var/named/data/named.recursing";
	secroots-file   "/var/named/data/named.secroots";
	allow-query     { localhost; 192.168.40.0/24; };
	allow-transfer  { localhost; 192.168.40.2; }; 
	recursion no;

	/* 
	 - If you are building an AUTHORITATIVE DNS server, do NOT enable recursion.
	 - If you are building a RECURSIVE (caching) DNS server, you need to enable 
	   recursion. 
	 - If your recursive DNS server has a public IP address, you MUST enable access 
	   control to limit queries to your legitimate users. Failing to do so will
	   cause your server to become part of large scale DNS amplification 
	   attacks. Implementing BCP38 within your network would greatly
	   reduce such attack surface 
	*/

	dnssec-enable yes;
	dnssec-validation yes;

	/* Path to ISC DLV key */
	bindkeys-file "/etc/named.root.key";

	managed-keys-directory "/var/named/dynamic";

	pid-file "/run/named/named.pid";
	session-keyfile "/run/named/session.key";
};

logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

zone "." IN {
	type hint;
	file "named.ca";
};


zone"dns.lab" IN {
	type master;
	file "dnslab.fwd.zone";
	allow-update { none; };
};

zone"40.168.192.in-addr.arpa" IN {
	type master;
	file "dnslab.rev.zone";
	allow-update { none; };
};

zone"newdns.lab" IN {
        type master;
        file "newdnslab.fwd.zone";
        allow-update { none; };
};



include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";


```

В данном конфиге редактируются :на каком интерфейсе слушать сервису,из каких подсетей разрешен резолвинг,каким dns серверам разрешен трансфер зон(DNS Slave-ы), запрещаются рекурсивные запросы:

```
	listen-on port 53 { 127.0.0.1; 192.168.40.1; };
	allow-query     { localhost; 192.168.40.0/24; };
	allow-transfer  { localhost; 192.168.40.2; }; 
	recursion no;
```

Также в конфиг добавлется описание dns зон, в данном примере это зоны dns.lab и newdns.lab, а также обратная зона 40.168.192.in-addr.arpa :

```
zone "." IN {
	type hint;
	file "named.ca";
};


zone"dns.lab" IN {
	type master;
	file "dnslab.fwd.zone";
	allow-update { none; };
};

zone"40.168.192.in-addr.arpa" IN {
	type master;
	file "dnslab.rev.zone";
	allow-update { none; };
};

zone"newdns.lab" IN {
        type master;
        file "newdnslab.fwd.zone";
        allow-update { none; };
};
```

Далее, в каталоге /var/named необходимо создать файлы зон: dnslab.fwd.zone, dnslab.rev.zone, newdnslab.fwd.zone

Файл dnslab.fwd.zone:

```
$TTL 86400
@       IN SOA  ns1.dns.lab.     root.dns.lab. (
                                  2014090401    ; serial
                                        3600    ; refresh
                                        1800    ; retry
                                      604800    ; expire
                                       86400 )  ; minimum

; Name server's

@       IN      NS      ns1.dns.lab.
@       IN      NS      ns2.dns.lab.

; Name server hostname to IP resolve.

@       IN      A       192.168.40.1
@       IN      A       192.168.40.2

; Hosts in this Domain

@       IN      A       192.168.40.3
@       IN      A       192.168.40.4
ns1     IN      A       192.168.40.1
ns2     IN      A       192.168.40.2
client1 IN      A       192.168.40.3
client2 IN      A       192.168.40.4
web1	IN	CNAME	client1
web2    IN      CNAME   client2

```

Файл dnslab.rev.zone:

```
$TTL 86400
@       IN SOA  ns1.dns.lab.     root.dns.lab. (
                                  2014090401    ; serial
                                        3600    ; refresh
                                        1800    ; retry
                                      604800    ; expire
                                       86400 )  ; minimum

; Name server's

@       IN      NS      ns1.dns.lab.
@       IN      NS      ns2.dns.lab.
@       IN      PTR     dns.lab.

; Name server hostname to IP resolve.

@       IN      A       192.168.40.1
@       IN      A       192.168.40.2

; Hosts in this Domain

client1 IN      A       192.168.40.3
client2 IN      A       192.168.40.4
1             IN      PTR     ns1.dns.lab.
2             IN      PTR     ns2.dns.lab.
3             IN      PTR     client1.dns.lab.
4             IN      PTR     client2.dns.lab.
```

Файл newdnslab.fwd.zone:

```
$TTL 86400
@       IN SOA  ns1.newdns.lab.     root.newdns.lab. (
                                  2014090401    ; serial
                                        3600    ; refresh
                                        1800    ; retry
                                      604800    ; expire
                                       86400 )  ; minimum

; Name server's

@       IN      NS      ns1.newdns.lab.
@       IN      NS      ns2.newdns.lab.

; Name server hostname to IP resolve.

@       IN      A       192.168.40.1
@       IN      A       192.168.40.2

; Hosts in this Domain

@       IN      A       192.168.40.3
@       IN      A       192.168.40.4
ns1     IN      A       192.168.40.1
ns2     IN      A       192.168.40.2
client1 IN      A       192.168.40.3
client2 IN      A       192.168.40.4
www 	IN      A       192.168.40.3
www 	IN      A       192.168.40.4

```

Далее необходимо выставить корректные права на созданные файлы, чтобы сервис bind мог с ними работать:

```
chgrp named /var/named/newdnslab.fwd.zone
chgrp named /var/named/dnslab.fwd.zone
chgrp named /var/named/dnslab.rev.zone
```

Теперь можно проверить что зоны созданы корректно:

```
named-checkconf /etc/named.conf
named-checkzone ns1.dns.lab /var/named/dnslab.fwd.zone
named-checkzone ns1.dns.lab /var/named/dnslab.rev.zone
```

Стартуем сервис bind

```
systemctl start named
```

Переходим к настройке Slave DNS сервера.

Устанавливем пакет bind:

```
yum install bind* -y
```

Выставляем разрешения SELinux:

```
semanage fcontext -a -t named_conf_t /etc/named.conf
semanage fcontext -a -t named_conf_t /etc/named.rfc1912.zones
```

Редактируем конфиг bind

```
vi /etc/named.conf

//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//
// See the BIND Administrator's Reference Manual (ARM) for details about the
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html

options {
	listen-on port 53 { 127.0.0.1; 192.168.40.2;};
	listen-on-v6 port 53 { ::1; };
	directory 	"/var/named";
	dump-file 	"/var/named/data/cache_dump.db";
	statistics-file "/var/named/data/named_stats.txt";
	memstatistics-file "/var/named/data/named_mem_stats.txt";
	recursing-file  "/var/named/data/named.recursing";
	secroots-file   "/var/named/data/named.secroots";
	allow-query     { localhost; 192.168.40.0/24; };

	/* 
	 - If you are building an AUTHORITATIVE DNS server, do NOT enable recursion.
	 - If you are building a RECURSIVE (caching) DNS server, you need to enable 
	   recursion. 
	 - If your recursive DNS server has a public IP address, you MUST enable access 
	   control to limit queries to your legitimate users. Failing to do so will
	   cause your server to become part of large scale DNS amplification 
	   attacks. Implementing BCP38 within your network would greatly
	   reduce such attack surface 
	*/
	recursion no;

	dnssec-enable yes;
	dnssec-validation yes;

	/* Path to ISC DLV key */
	bindkeys-file "/etc/named.root.key";

	managed-keys-directory "/var/named/dynamic";

	pid-file "/run/named/named.pid";
	session-keyfile "/run/named/session.key";
};

logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

zone "." IN {
	type hint;
	file "named.ca";
};



zone"dns.lab" IN {
type slave;
file "slaves/dns.lab.fwd.zone";
masters { 192.168.40.1; };
};

zone"newdns.lab" IN {
type slave;
file "slaves/newdns.lab.fwd.zone";
masters { 192.168.40.1; };
};

zone"40.168.192.in-addr.arpa" IN {
type slave;
file "slaves/dns.lab.rev.zone";
masters { 192.168.40.1; };
};



include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";


```

По аналогии прописываем адреса на которых будет слушать сервис, и с каких подсетей разрешено выполнять запросы.

Также прописываем dns зоны , указываем что сервер является Slave , там же указываем master сервер, откуда выполнять репликацию:

```
zone"dns.lab" IN {
type slave;
file "slaves/dns.lab.fwd.zone";
masters { 192.168.40.1; };
};

zone"newdns.lab" IN {
type slave;
file "slaves/newdns.lab.fwd.zone";
masters { 192.168.40.1; };
};

zone"40.168.192.in-addr.arpa" IN {
type slave;
file "slaves/dns.lab.rev.zone";
masters { 192.168.40.1; };
};
```

Настройка SplitDNS.

Чтобы заработал split-dns, необходимо в конфиге named указать views.

Открываем конфиг и редактируем зоны:

До включения split-dns:

```
zone "." IN {
	type hint;
	file "named.ca";
};


zone"dns.lab" IN {
	type master;
	file "dnslab.fwd.zone";
	allow-update { none; };
};

zone"40.168.192.in-addr.arpa" IN {
	type master;
	file "dnslab.rev.zone";
	allow-update { none; };
};

zone"newdns.lab" IN {
        type master;
        file "newdnslab.fwd.zone";
        allow-update { none; };
};
```

После включения split-dns:

```

view "client1" {
match-clients { 192.168.40.3; };
zone "." IN {
        type hint;
        file "named.ca";
};


zone"dns.lab" IN {
        type master;
        file "dnslab.fwd.zone.fix";
        allow-update { none; };
};

zone"40.168.192.in-addr.arpa" IN {
        type master;
        file "dnslab.rev.zone";
        allow-update { none; };
};

zone"newdns.lab" IN {
        type master;
        file "newdnslab.fwd.zone";
        allow-update { none; };
};

}; // end view




view "client2" {
match-clients { 192.168.40.4; };
zone "." IN {
        type hint;
        file "named.ca";
};


zone"dns.lab" IN {
        type master;
        file "dnslab.fwd.zone.fix";
        allow-update { none; };
};


}; // end view



view "everyone" {

zone "." IN {
	type hint;
	file "named.ca";
};


zone"dns.lab" IN {
	type master;
	file "dnslab.fwd.zone";
	allow-update { none; };
};

zone"40.168.192.in-addr.arpa" IN {
	type master;
	file "dnslab.rev.zone";
	allow-update { none; };
};

zone"newdns.lab" IN {
        type master;
        file "newdnslab.fwd.zone";
        allow-update { none; };
};

}; // end view


#include "/etc/named.rfc1912.zones";
```

В данном примере:

client1 - видит обе зоны, но в зоне dns.lab только web1

client2 видит только dns.lab

После внесения изменений требуется reload сервиса bind:

```
systemctl reload bind
```