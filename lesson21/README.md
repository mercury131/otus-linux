# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Linux net tools** - сетевые утилиты Linux



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson21** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

Сценарии iptables
1) реализовать knocking port
- centralRouter может попасть на ssh inetrRouter через knock скрипт
пример в материалах
2) добавить inetRouter2, который виден(маршрутизируется (host-only тип сети для виртуалки)) с хоста или форвардится порт через локалхост
3) запустить nginx на centralServer
4) пробросить 80й порт на inetRouter2 8080
5) дефолт в инет оставить через inetRouter

Используемые файлы и директории:
- В директории lesson21 расположен Vagrantfile с образом Centos 6/7 и автоматическими шагами развертывания



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
cd otus-linux/lesson21
vagrant up 
```

Открыть в браузере страницу http://127.0.0.1:8081/ и убедиться что проброс портов с inetRouter2 на centralServer работает


Далее зайти по ssh на centralRouter и проверить knock скрипт:

```
vagrant ssh centralRouter
sudo -i

[root@centralRouter ~]# bash knock.sh 192.168.255.1 8881 7777 9991

Starting Nmap 6.40 ( http://nmap.org ) at 2020-02-05 10:04 UTC
Warning: 192.168.255.1 giving up on port because retransmission cap hit (0).
Nmap scan report for 192.168.255.1
Host is up (0.00027s latency).
PORT     STATE    SERVICE
8881/tcp filtered unknown
MAC Address: 08:00:27:C3:29:7B (Cadmus Computer Systems)

Nmap done: 1 IP address (1 host up) scanned in 0.18 seconds

Starting Nmap 6.40 ( http://nmap.org ) at 2020-02-05 10:04 UTC
Warning: 192.168.255.1 giving up on port because retransmission cap hit (0).
Nmap scan report for 192.168.255.1
Host is up (0.00028s latency).
PORT     STATE    SERVICE
7777/tcp filtered cbt
MAC Address: 08:00:27:C3:29:7B (Cadmus Computer Systems)

Nmap done: 1 IP address (1 host up) scanned in 0.17 seconds

Starting Nmap 6.40 ( http://nmap.org ) at 2020-02-05 10:04 UTC
Warning: 192.168.255.1 giving up on port because retransmission cap hit (0).
Nmap scan report for 192.168.255.1
Host is up (0.00027s latency).
PORT     STATE    SERVICE
9991/tcp filtered issa
MAC Address: 08:00:27:C3:29:7B (Cadmus Computer Systems)

Nmap done: 1 IP address (1 host up) scanned in 0.18 seconds
The authenticity of host '192.168.255.1 (192.168.255.1)' can't be established.
RSA key fingerprint is SHA256:fdkbrbGjGdkOiNu3bXiQLBawyBlKfg+M474P34kMuEk.
RSA key fingerprint is MD5:33:25:7e:6d:09:32:1b:a3:04:85:18:c8:b7:3d:f4:22.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.255.1' (RSA) to the list of known hosts.
[vagrant@inetRouter ~]$
```

Без knock скрипта подключиться не получится:

```
[root@centralRouter ~]# ssh 192.168.255.1


```