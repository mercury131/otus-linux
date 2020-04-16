# **Проектная работа**

Состав проекта:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Ansible** - система управления конфигурациями
- **Nginx** - веб сервер
- **PHP** - скриптовый язык общего назначения, интенсивно применяемый для разработки веб-приложений
- **Nextcloud** - клиент-серверное ПО для создания и использования облачного хранилища
- **Postgres** - свободная объектно-реляционная система управления базами данных (СУБД)
- **Patroni** - система написанная на python, позволяющая автоматически обслуживать и создавать кластеры PostgreSQL
- **HAproxy** - серверное программное обеспечение для обеспечения высокой доступности и балансировки нагрузки для TCP и HTTP-приложений
- **Keepalived** - программный комплекс обеспечивающий высокую доступность ip адреса по протоколу VRRP
- **Etcd** - единое хранилище конфигурации для группы серверов
- **GlusterFS** - распределённая, параллельная, линейно масштабируемая файловая система с возможностью защиты от сбоев
- **Borg backup** - система резервного копирования
- **Rsyslog** - мощная, безопасная и высокопроизводительная система обработки логов, которая собирает данные из разных источников (систем/приложений) и выводит их в несколько форматов

# **Схема проекта:**
![Project Diagram](https://raw.githubusercontent.com/mercury131/otus-linux/master/project/infra.png)


# **Описание проекта:**

В качестве приложения для данного проекта выбрано клиент-серверное ПО для создания и использования облачного хранилища - Nextcloud.
В качестве серверов балансирующих нагрузку, выбран nginx, в режиме реверс прокси.
Метод балансировки ip hash, используется для привязки сессии клиента к веб серверу. 
Для отказоустойчивости точки входа, прокси серверов используется сервис keepalived, который предоставляет "плавающий" ip адрес, с помощью технологии VRRP.

В качестве веб серверов используется nginx. Т.к Приложение (Nextcloud), написано на языке php, в качестве обработчика используется php-fpm, версии 72.

В качестве распределенной, синхронной файловой системы, используется GlusterFS. 
Данная ФС установлена на все веб сервера с nginx и php, и используется для хранения пользовательских файлов.

При  необходимости возможно горизонтальное масштабирование веб серверов, на случаи роста нагрузки

В качестве базы данных используется Postgres. Для обеспечения отказоустойчивости используется демон Patroni (для управления кластером) и распределенная система хранения конфигураций - etcd.

В качестве центральной системы хранения логов используется Rsyslog.
Логи собираются со всех узлов, и сортируются на сервере по ip, hostname.

Для выполнения резервного копирования используется Borg Backup, который раз в сутки выполняет резервное копирование файлов с подключенной GlusterFS.
Backup базы данных, выполняется раз в сутки обычным pg_dump, и с помощью Borg backup , складывается в репозиторий.

Деплой и конфигурирование автоматизировано с помощью Ansible ролей и Playbook.
Все переменные задаются в playbook и частично в inventory.

# **Описание Деплоя:**

Ansible роли расположены в репозитории - - **https://github.com/mercury131/otus-linux/tree/master/project/ansible/roles**

Ansible Playbook-и расположены в каталоге - **https://github.com/mercury131/otus-linux/tree/master/project/ansible/**

Для деплоя проекта используется общий Playbook, который содержит автоматизированные шаги установки:
**https://github.com/mercury131/otus-linux/tree/master/project/ansible/deploy.yml**

```
---
 - import_playbook: keepalived.yml
 - import_playbook: proxy.yml
 - import_playbook: glusterfs.yml
 - import_playbook: web.yml
 - import_playbook: haproxy.yml
 - import_playbook: etcd.yml
 - import_playbook: patroni.yml
 - import_playbook: create_db.yml
 - import_playbook: nextcloud.yml
 - import_playbook: rsyslog-server.yml
 - import_playbook: backup-files.yml
```

Переменные указываются в Playbook или inventory, в зависимости от компонента, например:

**keepalived.yml:**
```
---
 - hosts: proxy
   become: true
   tasks:
   - include_role:
        name: keepalived
     vars:
       interface: enp0s8
       virtual_router_id: 55
       advert_int: 1
       auth_type: PASS
       auth_pass: Secret
       virtual_ipaddress: 192.168.11.120/24

 - hosts: haproxy
   become: true
   tasks:
   - include_role:
        name: keepalived
     vars:
       interface: enp0s8
       virtual_router_id: 56
       advert_int: 1
       auth_type: PASS
       auth_pass: Secret
       virtual_ipaddress: 192.168.11.121/24
```

**inventory.yml:**
```
[proxy]
proxy1 ansible_user=root priority=102
proxy2 ansible_user=root priority=100

[haproxy]
haproxy1 ansible_user=root priority=102
haproxy2 ansible_user=root priority=100
```
Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson28** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

Роль для настройки веб сервера
Варианты стенда
nginx + php-fpm (laravel/) + python (flask/django) + js(react/angular)


Реализации на выбор
- на хостовой системе через конфиги в /etc



Используемые файлы и директории:
- В директории lesson28 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания
- В директории lesson28/ansible , расположены playbook, inventory файл и роли по установке стендов

# Как проверить домашнее задание?

Склонируйте репозиторий:

```
git clone git@github.com:mercury131/otus-linux.git
```

Установите необходимые плагины для vagrant:

```
vagrant plugin install vagrant-reload
```


Добавьте в локальный файл hosts следующую строку:

```
192.168.11.102 laravel.local python.local js.local
```


Для запуска Vagrantfile автоматизированными шагами выполните:

```
cd otus-linux/lesson28
vagrant up 
vagrant ssh
```

Для установки стенда с Laravel (nginx/php-fpm на unix-socket) выполните:

```
vagrant ssh
sudo -i

ansible-playbook /home/vagrant/laravel.yml  -i /home/vagrant/.ansible/inventory.yml
```

После завершения playbook перейдите в браужере на страницу http://laravel.local


Для установки стенда с Python (nginx / uwscgi на unix-socket) выполните:

```
vagrant ssh
sudo -i

ansible-playbook /home/vagrant/python.yml  -i /home/vagrant/.ansible/inventory.yml
```

После завершения playbook перейдите в браужере на страницу http://python.local

Для установки стенда с React (nodejs) (nginx / nodejs /React ) выполните:

```
vagrant ssh
sudo -i

ansible-playbook /home/vagrant/js.yml  -i /home/vagrant/.ansible/inventory.yml
```

В данном стенде будет собрано стандартное React приложение.

После завершения playbook перейдите в браужере на страницу http://js.local

