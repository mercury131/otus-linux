# **Проектная работа**

В данном проекте представлена отказоустойчивая реализация приложения Nextcloud (ПО для создания и использования облачного хранилища)
В проекте используются веб и проксти сервера nginx, haproxy, в качестве БД выбран Postgres.
Распределенная файловая система построена на базе GlusterFS, а резервное копиривание на базе Borg backup. Деплой полностью автоматизирован с помощью Ansible.

Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/project** - ссылка на данный проект

# **Состав проекта:**
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

**Шаги деплоя:**
- **keepalived.yml** - выполняется настройка "плавающих" ip с помощью keepalive и протокола vrrp
- **proxy.yml** - выполняется настройка реверс прокси серверов nginx
- **glusterfs.yml** - выполянется настройка распределенной файловой системы GlusterFS
- **web.yml** - выполянется настройка веб серверов с nginx и php-fpm
- **haproxy.yml** - выполняется настройка прокси сервера HAproxy, для клиентских соединений к БД
- **etcd.yml** - выполняется настройка и конфигурирование распределенной системы хранения конфигураций - etcd
- **patroni.yml** - выполняется установка серверов Postgres и их объединение в кластер с помощью Patroni
- **create_db.yml** - Выполяется создание пользователей и баз данных в БД Postgres (дял приложения nextcloud)
-  **nextcloud.yml** - Выполняется деплой приложения Nextcloud на веб сервера с php-fpm, сервис конфигурируется внутри роли, первичная настройка через веб интерфейс не требуется
- **rsyslog-server.yml** - Выполняется конфигурирование syslog сервера Rsyslog, для входящей обработки логов
- **rsyslog-client.yml** - Выполняется конфигурирование клиентов, для отправки логов на центральный syslog сервер
- **backup-files.yml** -  Выполняется настройка резервного копирования с помощью borgbackup и pg_dump и cron заданий

# **Запуск и деплой проекта:**

Для запуска проекта должен быть установлен Virtualbox и Vagrant

Также рекомендуется использовать минимум 8GB RAM 

Для запуска Vagrantfile шагами развертывания VM выполните:

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
192.168.11.120 example.com
```

```
cd otus-linux/project
vagrant up 
```
Для деплоя проекта, подключитесь к машине с Ansible и выполните:

```
vagrant ssh backup
sudo -i
ansible-playbook /vagrant/ansible/deploy.yml  -i /vagrant/ansible/inventory.yml
```