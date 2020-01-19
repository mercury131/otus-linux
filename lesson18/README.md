# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Linux net tools** - сетевые утилиты Linux



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson18** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

разворачиваем сетевую лабораторию

# otus-linux
Vagrantfile - для стенда урока 9 - Network

# Дано
https://github.com/erlong15/otus-linux/tree/network
(ветка network)

Vagrantfile с начальным построением сети
- inetRouter
- centralRouter
- centralServer

тестировалось на virtualbox

# Планируемая архитектура
построить следующую архитектуру

Сеть office1
- 192.168.2.0/26 - dev
- 192.168.2.64/26 - test servers
- 192.168.2.128/26 - managers
- 192.168.2.192/26 - office hardware

Сеть office2
- 192.168.1.0/25 - dev
- 192.168.1.128/26 - test servers
- 192.168.1.192/26 - office hardware


Сеть central
- 192.168.0.0/28 - directors
- 192.168.0.32/28 - office hardware
- 192.168.0.64/26 - wifi

```
Office1 ---\
-----> Central --IRouter --> internet
Office2----/
```
Итого должны получится следующие сервера
- inetRouter
- centralRouter
- office1Router
- office2Router
- centralServer
- office1Server
- office2Server

# Теоретическая часть
- Найти свободные подсети
- Посчитать сколько узлов в каждой подсети, включая свободные
- Указать broadcast адрес для каждой подсети
- проверить нет ли ошибок при разбиении

# Практическая часть
- Соединить офисы в сеть согласно схеме и настроить роутинг
- Все сервера и роутеры должны ходить в инет черз inetRouter
- Все сервера должны видеть друг друга
- у всех новых серверов отключить дефолт на нат (eth0), который вагрант поднимает для связи
- при нехватке сетевых интервейсов добавить по несколько адресов на интерфейс




Используемые файлы и директории:
- В директории lesson18 расположен Vagrantfile с образом Centos 6/7 и автоматическими шагами развертывания



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
cd otus-linux/lesson18
vagrant up 
```

Теоретическая Часть:

Посчитать сколько узлов в каждой подсети, включая свободные

Сеть office1
- 192.168.2.0/26 - dev - 62 хоста
- 192.168.2.64/26 - test servers - 62 хоста
- 192.168.2.128/26 - managers - 62 хоста
- 192.168.2.192/26 - office hardware - 62 хоста

Сеть office2
- 192.168.1.0/25 - dev - 126 хоста
- 192.168.1.128/26 - test servers - 62 хоста
- 192.168.1.192/26 - office hardware - 62 хоста


Сеть central
- 192.168.0.0/28 - directors - 14 хостов
- 192.168.0.32/28 - office hardware - 14 хостов
- 192.168.0.64/26 - wifi - 62 хоста - 14 хостов


Указать broadcast адрес для каждой подсети

Сеть office1
- 192.168.2.0/26 - dev - broadcast 192.168.2.63
- 192.168.2.64/26 - test servers - broadcast 192.168.2.64
- 192.168.2.128/26 - managers - broadcast 192.168.2.191
- 192.168.2.192/26 - office hardware - broadcast 192.168.2.255

Сеть office2
- 192.168.1.0/25 - dev - broadcast 192.168.1.127
- 192.168.1.128/26 - test servers - broadcast 192.168.1.191
- 192.168.1.192/26 - office hardware - broadcast 192.168.1.255


Сеть central
- 192.168.0.0/28 - directors - broadcast 192.168.0.15
- 192.168.0.32/28 - office hardware - broadcast 192.168.0.47
- 192.168.0.64/26 - wifi - broadcast 192.168.0.127


Практическая часть:

В Vagrantfile реализована следующая сетевая схема:

![network diagram](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson18/network.png)

Для выполнения практической части использовались команды для построения статических маршрутов:

```
ip route add * via * dev eth*
```
где * - параметры подсетей и сетевого интерфейса

Также использовались следующие параметры ядра для поддержки ip forwarding:

```
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl net.ipv4.conf.all.forwarding=1
```

В качестве проверки использовалась утилита ping и traceroute.

Вывод traceroute до ya.ru с сервера office2Server
traceroute используется с опцией I, для работы через icmp

```
[root@office2Server ~]# traceroute -I ya.ru
traceroute to ya.ru (87.250.250.242), 30 hops max, 60 byte packets
 1  gateway (192.168.1.129)  0.249 ms  0.140 ms  0.089 ms
 2  192.168.6.1 (192.168.6.1)  0.434 ms  0.400 ms  0.432 ms
 3  192.168.255.1 (192.168.255.1)  1.122 ms  1.087 ms  1.044 ms
 4  * * *
 5  * * *
 6  broadband-90-154-77-179.ip.moscow.rt.ru (90.154.77.179)  20.853 ms  11.062 ms  10.847 ms
 7  77.37.250.194 (77.37.250.194)  10.728 ms  5.150 ms  5.038 ms
 8  yandex-ncnet.msk.ip.ncnet.ru (77.37.254.26)  5.550 ms  11.422 ms  11.276 ms
 9  ya.ru (87.250.250.242)  11.552 ms  12.685 ms  12.811 ms

```

Ping между серверами:

```
[root@office2Server ~]# ping 192.168.2.66
PING 192.168.2.66 (192.168.2.66) 56(84) bytes of data.
64 bytes from 192.168.2.66: icmp_seq=1 ttl=61 time=1.12 ms
64 bytes from 192.168.2.66: icmp_seq=2 ttl=61 time=1.06 ms
^C
--- 192.168.2.66 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 1.069/1.099/1.129/0.030 ms

```

```
[root@office2Server ~]# ping 192.168.0.2
PING 192.168.0.2 (192.168.0.2) 56(84) bytes of data.
64 bytes from 192.168.0.2: icmp_seq=1 ttl=62 time=0.836 ms
64 bytes from 192.168.0.2: icmp_seq=2 ttl=62 time=0.838 ms
64 bytes from 192.168.0.2: icmp_seq=3 ttl=62 time=0.797 ms
64 bytes from 192.168.0.2: icmp_seq=4 ttl=62 time=0.801 ms
^C
--- 192.168.0.2 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3003ms
rtt min/avg/max/mdev = 0.797/0.818/0.838/0.019 ms

```

Выводы traceroute между серверами:

```
[root@office2Server ~]# traceroute -I 192.168.0.2
traceroute to 192.168.0.2 (192.168.0.2), 30 hops max, 60 byte packets
 1  gateway (192.168.1.129)  0.232 ms  0.159 ms  0.223 ms
 2  192.168.6.1 (192.168.6.1)  0.456 ms  0.530 ms  1.205 ms
 3  192.168.0.2 (192.168.0.2)  1.123 ms  1.078 ms  1.315 ms

```

```
traceroute to 192.168.2.66 (192.168.2.66), 30 hops max, 60 byte packets
 1  gateway (192.168.1.129)  0.265 ms  0.193 ms  0.150 ms
 2  192.168.6.1 (192.168.6.1)  1.369 ms  1.452 ms  1.343 ms
 3  192.168.5.2 (192.168.5.2)  1.811 ms  1.996 ms  1.959 ms
 4  192.168.2.66 (192.168.2.66)  1.920 ms  1.886 ms  1.946 ms
```