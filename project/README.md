# **Проектная работа**

В данном проекте представлена отказоустойчивая реализация приложения Nextcloud (ПО для создания и использования облачного хранилища)
В проекте используются веб и прокси сервера nginx, haproxy, в качестве БД выбран Postgres.
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

HAproxy используется в качестве точки подключения к кластеру Postgres.
Отказоустойчивость HAproxy, обеспечивает keepalived, который предоставляет "плавающий" ip адрес, с помощью технологии VRRP.

В качестве центральной системы хранения логов используется Rsyslog.
Логи собираются со всех узлов, и сортируются на сервере по ip, hostname.

Для выполнения резервного копирования используется Borg Backup, который раз в сутки выполняет резервное копирование файлов с подключенной GlusterFS.
Backup базы данных, выполняется раз в сутки обычным pg_dump, и с помощью Borg backup  складывается в репозиторий.

Деплой и конфигурирование автоматизировано с помощью Ansible ролей и Playbook.
Все переменные задаются в playbook и частично в inventory.

На всех сервера включен и настроен firewall 

Также на всех серверах (кроме серверов с nginx и php-fpm) настроен SElinux
Сервера с nginx и php-fpm работают в режиме permissive из-за этого бага с GlusterFS:
https://github.com/gluster/glusterfs/issues/593

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
- **keepalived.yml** - Выполняется настройка "плавающих" ip с помощью keepalive и протокола vrrp
- **proxy.yml** - Выполняется настройка реверс прокси серверов nginx
- **glusterfs.yml** - Выполняется настройка распределенной файловой системы GlusterFS
- **web.yml** - Выполняется настройка веб серверов с nginx и php-fpm
- **haproxy.yml** - Выполняется настройка прокси сервера HAproxy, для клиентских соединений к БД
- **etcd.yml** - Выполняется настройка и конфигурирование распределенной системы хранения конфигураций - etcd
- **patroni.yml** - Выполняется установка серверов Postgres и их объединение в кластер с помощью Patroni
- **create_db.yml** - Выполяется создание пользователей и баз данных в БД Postgres (для приложения nextcloud)
-  **nextcloud.yml** - Выполняется деплой приложения Nextcloud на веб сервера с php-fpm, сервис конфигурируется внутри роли, первичная настройка через веб интерфейс не требуется
- **rsyslog-server.yml** - Выполняется конфигурирование syslog сервера Rsyslog, для входящей обработки логов
- **rsyslog-client.yml** - Выполняется конфигурирование клиентов, для отправки логов на центральный syslog сервер
- **backup-files.yml** -  Выполняется настройка резервного копирования с помощью borgbackup, pg_dump и cron заданий

# **Запуск и деплой проекта:**

Для запуска проекта должен быть установлен Virtualbox и Vagrant

Также рекомендуется использовать минимум 8GB RAM 

Для запуска Vagrantfile с шагами развертывания VM выполните:

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

В результате вывод playbook должен выглядеть так:

```
PLAY RECAP ***********************************************************************************************************backup                     : ok=15   changed=14   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0    
haproxy1                   : ok=22   changed=18   unreachable=0    failed=0    skipped=0    rescued=0    ignored=1    
haproxy2                   : ok=22   changed=18   unreachable=0    failed=0    skipped=0    rescued=0    ignored=1    
log                        : ok=8    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1    
nginx1                     : ok=59   changed=49   unreachable=0    failed=0    skipped=7    rescued=0    ignored=1    
nginx2                     : ok=54   changed=44   unreachable=0    failed=0    skipped=12   rescued=0    ignored=2    
patroni1                   : ok=33   changed=22   unreachable=0    failed=0    skipped=1    rescued=0    ignored=4    
patroni2                   : ok=33   changed=25   unreachable=0    failed=0    skipped=1    rescued=0    ignored=2    
patroni3                   : ok=33   changed=23   unreachable=0    failed=0    skipped=1    rescued=0    ignored=4    
proxy1                     : ok=23   changed=19   unreachable=0    failed=0    skipped=0    rescued=0    ignored=1    
proxy2                     : ok=23   changed=19   unreachable=0    failed=0    skipped=0    rescued=0    ignored=1 
```

# **Проверка приложения и компонентов:**

Чтобы проверить работоспособность приложения откройте браузер, и перейдите на страницу http://example.com

Авторизуйтесь под пользователем admin, с паролем admin

![upload](https://raw.githubusercontent.com/mercury131/otus-linux/master/project/login.gif)

Попробуйте загрузить файл в облако:

![upload](https://raw.githubusercontent.com/mercury131/otus-linux/master/project/upload.gif)

Далее, на машине backup проверяем наличие резервных копий:

```
vagrant ssh backup
sudo -i
[root@backup ~]# borg list /backup/
Enter passphrase for key /backup: 
Today                                Thu, 2020-04-16 21:34:08 [98b143eb019a9a453b3a707f49f44748e1f5e4b0008fe4a761df18cde2e4e166]
[root@backup ~]# 
```

Далее, подключаемся к машине log, и проверяем что логи с серверов собираются корректно:

```
ssh log

[root@log ~]# ls /var/log/
127.0.0.1       192.168.11.107  boot.log   grubby              maillog   patroni3  tallylog             wtmp
192.168.11.102  192.168.11.108  btmp       grubby_prune_debug  messages  proxy1    tuned                yum.log       
192.168.11.103  192.168.11.109  cron       haproxy1            nginx1    proxy2    vboxadd-install.log
192.168.11.104  192.168.11.110  dmesg      haproxy2            nginx2    rhsm      vboxadd-setup.log
192.168.11.105  anaconda        dmesg.old  lastlog             patroni1  secure    vboxadd-setup.log.1
192.168.11.106  audit           firewalld  log                 patroni2  spooler   vboxadd-setup.log.2

[root@log ~]# ls /var/log/patroni1
patroni.log  polkitd.log  rsyslogd.log  sshd.log  systemd.log  systemd-logind.log

```

Проверяем отказоустойчивость приложения, выполняем команду, которая погасит половину инфраструктуры:

```
vagrant halt --force nginx1 proxy1 haproxy1 patroni1 
```

Обновляем страницу http://example.com, перелогиниваемся, проверяем что все работает корректно.