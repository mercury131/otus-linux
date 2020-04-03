# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **postgres** - Opensource БД
- **patroni** - Patroni — это демон на python, позволяющий автоматически обслуживать кластеры PostgreSQL
- **etcd** - единое хранилище конфигурации для группы серверов



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson33** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

Разворачиваем кластер Patroni
Цель: - Развернуть кластер PostgreSQL из трех нод. Создать тестовую базу - проверить статус репликации - Сделать switchover/failover - Поменять конфигурацию PostgreSQL + с параметром требующим перезагрузки - Настроить клиентские подключения через HAProxy 




Используемые файлы и директории:
- В директории lesson33 расположен Vagrantfile с образами Centos 7 и автоматическими шагами развертывания


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
cd otus-linux/lesson33
vagrant up 
```

Далее зайдите на машину client и выполните подключение к postgres с тестовым паролем postgrespassword:

```
vagrant ssh client
psql -p 5000 -h 192.168.11.104 -U postgres

```

Создайте новую базу

```
psql -p 5000 -h 192.168.11.104 -U postgres
CREATE DATABASE patronitest;
postgres=# \l
                                   List of databases
    Name     |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-------------+----------+----------+-------------+-------------+-----------------------
 patronitest | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 |
 postgres    | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 |
 template0   | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 | =c/postgres          +
             |          |          |             |             | postgres=CTc/postgres
 template1   | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 | =c/postgres          +
             |          |          |             |             | postgres=CTc/postgres
(4 rows)

```

Теперь выполните stop для любой из 3-х VM с patroni , например для postgres2

```
vagrant halt postgres2 -f
```

Теперь проверим что после падения одной ноды мы можем подключиться к кластеру и наша база на месте:

```
psql -p 5000 -h 192.168.11.104 -U postgres
\l

postgres=# \l
                                   List of databases
    Name     |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-------------+----------+----------+-------------+-------------+-----------------------
 patronitest | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 |
 postgres    | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 |
 template0   | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 | =c/postgres          +
             |          |          |             |             | postgres=CTc/postgres
 template1   | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 | =c/postgres          +
             |          |          |             |             | postgres=CTc/postgres
(4 rows)

```