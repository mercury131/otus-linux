# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Linux net tools** - сетевые утилиты Linux
- **Quagga** - Программный маршрутизатор



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson23** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

OSPF
- Поднять три виртуалки
- Объединить их разными private network
1. Поднять OSPF между машинами средствами программных маршрутизаторов на выбор: Quagga, FRR или BIRD
2. Изобразить ассиметричный роутинг
3. Сделать один из линков "дорогим", но что бы при этом роутинг был симметричным

Формат сдачи:
Vagrantfile + ansible 




Используемые файлы и директории:
- В директории lesson23 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания

В Vagrantfile реализована следующая сетевая схема:

![network diagram](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson23/ospf.png)

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
cd otus-linux/lesson23
vagrant up 
```

Далее зайдите на машину Router3 и выполните ansible playbook-и:

```
vagrant ssh Router3
sudo -i
ansible-playbook /home/vagrant/playbook.yml  -i /home/vagrant/.ansible/inventory.yml

```

Данный playbook настроит OSPF между роутерами, проверить что все работает можно посмотрев маршруты:

```
[root@Router3 ~]# ip r
default via 10.0.2.2 dev enp0s3 proto dhcp metric 100
10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.15 metric 100
192.168.20.0/24 dev enp0s8 proto kernel scope link src 192.168.20.2 metric 101
192.168.30.0/24 dev enp0s9 proto kernel scope link src 192.168.30.1 metric 102
192.168.40.0/24 via 192.168.20.1 dev enp0s8 proto zebra metric 20
```

И соседей роутера:

```
[root@Router3 ~]# vtysh

Hello, this is Quagga (version 0.99.22.4).
Copyright 1996-2005 Kunihiro Ishiguro, et al.


Router3# show ip ospf n

    Neighbor ID Pri State           Dead Time Address         Interface            RXmtL RqstL DBsmL
192.168.40.1      1 Full/DROther       7.549s 192.168.20.1    enp0s8:192.168.20.2      0     0     0
192.168.30.2      1 Full/DROther       7.413s 192.168.30.2    enp0s9:192.168.30.1      0     0     0

Router3# show ip ospf r
============ OSPF network routing table ============
N    192.168.20.0/24       [10] area: 0.0.0.0
                           directly attached to enp0s8
N    192.168.30.0/24       [100] area: 0.0.0.0
                           directly attached to enp0s9
N    192.168.40.0/24       [20] area: 0.0.0.0
                           via 192.168.20.1, enp0s8

============ OSPF router routing table =============

============ OSPF external routing table ===========

```

Для включения ассиметричного роутинга выполните следующий playbook:

```
ansible-playbook /home/vagrant/playbook.yml  -i /home/vagrant/.ansible/inventory2.yml
```

Чтобы сделать 1 линк дорогим, но оставить роутинг симметричным, выполните следующий playbook:

```
ansible-playbook /home/vagrant/playbook.yml  -i /home/vagrant/.ansible/inventory3.yml
```

Настройка OSPF вручную:

Устанавливаем quagga:

```
yum install -y quagga
```

Включаем форвардинг пакетов:

```
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
```

Переходим к настройке quagga:

Стартуем сервис и включаем его:

```
systemctl enable zebra.service 
systemctl start zebra.service
```

Настраиваем LAN интервейсы в консоли vtysh:

```
vtysh 
my-gw# configure terminal
my-gw(config)# log file /var/log/quagga/quagga.log
my-gw(config)# do show  interface
Interface enp0s8 is up, line protocol detection is disabled
  index 2 metric 1 mtu 1500
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  HWaddr: 02:02:0a:ab:00:f4
  inet 192.168.40.1/24 broadcast 10.0.11.255
Interface enp0s9 is up, line protocol detection is disabled
  index 3 metric 1 mtu 1500
  flags: <UP,BROADCAST,RUNNING,MULTICAST>
  HWaddr: 02:02:c0:a8:02:7a
  inet 192.168.20.1/24 broadcast 192.168.3.255
Interface lo is up, line protocol detection is disabled
  index 1 metric 1 mtu 65536
  flags: <UP,LOOPBACK,RUNNING>
  inet 127.0.0.1/8
my-gw(config)# interface enp0s8
my-gw(config-if)# description LAN
my-gw(config-if)# ip  address  192.168.40.1/24
my-gw(config-if)# no shutdown
my-gw(config-if)# exit
my-gw(config)# interface enp0s9
my-gw(config-if)# description LAN
my-gw(config-if)# ip address 192.168.20.1/24
my-gw(config-if)# exit
my-gw(config)# do write
my-gw(config)# exit
my-gw# exit
```

Переходим к настройке OSPF:

Копируем семпл с конфигом:

```
cp /usr/share/doc/quagga-0.99.22.4/ospfd.conf.sample /etc/quagga/ospfd.conf
```

Меняем владельца:

```
chown quagga:quaggavt /etc/quagga/ospfd.conf
```

Включаем сервис и стартуем его:

```
systemctl enable ospfd.service 
systemctl start ospfd.service
```

Переходим в консоль vtysh и настраиваем OSPF:

```
vtysh 
my-gw# configure terminal
my-gw# service integrated-vtysh-config
my-gw(config)# router ospf
my-gw(config-router)# network  192.168.20.0/24 area 0.0.0.0
my-gw(config-router)# network  192.168.40.0/24 area 0.0.0.0
my-gw(config-router)# router-id  192.168.40.1
my-gw(config-if)# exit
my-gw(config)# do write
my-gw(config)# exit
```

По аналогии настраиваем соседние роутеры. 

Проверяем соседей:

```
[root@Router2 ~]# vtysh

Hello, this is Quagga (version 0.99.22.4).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

Router2# show ip ospf n

    Neighbor ID Pri State           Dead Time Address         Interface            RXmtL RqstL DBsmL
192.168.40.1      1 Full/DROther       6.669s 192.168.40.1    enp0s8:192.168.40.2      0     0     0
192.168.20.2      1 Full/DROther       7.626s 192.168.30.1    enp0s9:192.168.30.2      0     0     0
Router2# show ip ospf r
============ OSPF network routing table ============
N    192.168.20.0/24       [60] area: 0.0.0.0
                           via 192.168.40.1, enp0s8
N    192.168.30.0/24       [100] area: 0.0.0.0
                           directly attached to enp0s9
N    192.168.40.0/24       [50] area: 0.0.0.0
                           directly attached to enp0s8

============ OSPF router routing table =============

============ OSPF external routing table ===========

```

Для изменения стоимости маршрутов меняются параметры ip ospf cost в конфиге ospfd

Чтобы работала динамическая маршрутизаторация от точки к точке необходимо для сетевых интерфейсов добавлять параметр ip ospf network point-to-point