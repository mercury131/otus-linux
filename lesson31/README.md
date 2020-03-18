# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Docker** - система управления контейнерами
- **Docker Swarm** - система кластеризации контейнеров


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson31** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

развернуть InnoDB кластер в docker
развернуть InnoDB кластер в docker
* в docker swarm

в качестве ДЗ принимает репозиторий с docker-compose
который по кнопке разворачивает кластер и выдает порт наружу




Используемые файлы и директории:
- В директории lesson31 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания:



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
cd otus-linux/lesson31
vagrant up 

```

Подключитесь к машине, убедитесь что кластер Swarm запущен и кластер InnoDB работает:

```
vagrant ssh innodbcluster
sudo -i
docker node ls
[root@innodbcluster deploy]# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
u0k68vtajuqg0xbzqvm8el8jv *   innodbcluster       Ready               Active              Leader              19.03.8
lgz02twwgaepda383v2w4fv5w     innodbcluster2      Ready               Active                                  19.03.8


[root@innodbcluster ~]# docker service ls
ID                  NAME                      MODE                REPLICAS            IMAGE                               PORTS
4r2ku9myzdn3        innodbcl_mysql-router     replicated          1/1                 mysql/mysql-router:8.0
mq21jl5m6n91        innodbcl_mysql-server-1   replicated          1/1                 mysql/mysql-server:8.0.12
yk9t8fsg3b3m        innodbcl_mysql-server-2   replicated          1/1                 mysql/mysql-server:8.0.12
sf8a1f7bh2ie        innodbcl_mysql-server-3   replicated          1/1                 mysql/mysql-server:8.0.12
wh2cyqmmwwh5        innodbcl_mysql-shell      replicated          0/1                 neumayer/mysql-shell-batch:latest

```

Теперь проверьте что mysq-router корректно пускает пользователя в созданную БД dbwebapp

```
[root@innodbcluster ~]# mysql -u dbwebapp -pdbwebapp -h 127.0.0.1 -P 6446
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 739
Server version: 8.0.12 MySQL Community Server - GPL

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| dbwebappdb         |
| information_schema |
+--------------------+
2 rows in set (0.02 sec)

MySQL [(none)]>

```

Кластер InnoDB успешно работает и запущен в docker swarm.

# Описание выполнения данного задания.


Подключаемся к первой ноде

```
vagrant ssh innodbcluster
sudo -i
```

Устанавливаем необходимые пакеты:

```
yum install epel-release -y
yum install -y yum-utils  device-mapper-persistent-data lvm2 -y
yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-nightly
yum install docker-ce docker-ce-cli containerd.io -y
yum install docker-compose -y
yum remove docker-compose -y
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

Отключаем SELinux чтобы прокинуть volume в контейнер

```
setenforce 0
```

Запускаем Docker

```
systemctl start docker
```

Добавляем записи в hosts файл:

```
echo "192.168.11.101  innodbcluster" >> /etc/hosts
echo "192.168.11.102  innodbcluster2" >> /etc/hosts

```

Запускаем Swarm кластер и экспортируем вывод команды в общий каталог /vagrant, чтобы потом добавить в кластер вторую ноду:

```
docker swarm init --advertise-addr 192.168.11.101 > /vagrant/swarm.txt
```

Теперь переходим в каталог с compose файлом, в котором описан деплой кластера InnoDB:

```
cd /vagrant/deploy
```

Сам compose файл:

```
version: '3.7'
services:
  mysql-server-1:
    environment:
      - MYSQL_ROOT_PASSWORD=mysql
      - MYSQL_ROOT_HOST=%
    image: mysql/mysql-server:8.0.12
    networks:
       - overlay
    healthcheck:
      disable: true
    deploy:
      replicas: 1
      endpoint_mode: dnsrr
      update_config:
        delay: 600s
      restart_policy:
        condition: none
        delay: 800s
    ports:
      - target: 3306
        published: 3301
        protocol: tcp
        mode: host
    command: ["mysqld","--server_id=1","--binlog_checksum=NONE","--gtid_mode=ON","--enforce_gtid_consistency=ON","--log_bin","--log_slave_updates=ON","--master_info_repository=TABLE","--relay_log_info_repository=TABLE","--transaction_write_set_extraction=XXHASH64","--user=mysql","--skip-host-cache","--skip-name-resolve", "--default_authentication_plugin=mysql_native_password"]
  mysql-server-2:
    environment:
      - MYSQL_ROOT_PASSWORD=mysql
      - MYSQL_ROOT_HOST=%
    image: mysql/mysql-server:8.0.12
    networks:
       - overlay
    healthcheck:
      disable: true
    deploy:
      replicas: 1
      endpoint_mode: dnsrr
      update_config:
        delay: 600s
      restart_policy:
        condition: none
        delay: 800s
    command: ["mysqld","--server_id=2","--binlog_checksum=NONE","--gtid_mode=ON","--enforce_gtid_consistency=ON","--log_bin","--log_slave_updates=ON","--master_info_repository=TABLE","--relay_log_info_repository=TABLE","--transaction_write_set_extraction=XXHASH64","--user=mysql","--skip-host-cache","--skip-name-resolve", "--default_authentication_plugin=mysql_native_password"]
    ports:
      - target: 3306
        published: 3302
        protocol: tcp
        mode: host
  mysql-server-3:
    environment:
      - MYSQL_ROOT_PASSWORD=mysql
      - MYSQL_ROOT_HOST=%
    image: mysql/mysql-server:8.0.12
    networks:
       - overlay
    healthcheck:
      disable: true
    deploy:
      replicas: 1
      endpoint_mode: dnsrr
      update_config:
        delay: 600s
      restart_policy:
        condition: none
        delay: 800s
    command: ["mysqld","--server_id=3","--binlog_checksum=NONE","--gtid_mode=ON","--enforce_gtid_consistency=ON","--log_bin","--log_slave_updates=ON","--master_info_repository=TABLE","--relay_log_info_repository=TABLE","--transaction_write_set_extraction=XXHASH64","--user=mysql","--skip-host-cache","--skip-name-resolve", "--default_authentication_plugin=mysql_native_password"]
    ports:
      - target: 3306
        published: 3303
        protocol: tcp
        mode: host
  mysql-shell:
    environment:
      - MYSQL_USER=root
      - MYSQL_HOST=mysql-server-1
      - MYSQL_PORT=3306
      - MYSQL_PASSWORD=mysql
      - MYSQLSH_SCRIPT=/scripts/setupCluster.js
      - MYSQL_SCRIPT=/scripts/db.sql
    image: neumayer/mysql-shell-batch
    networks:
       - overlay
    deploy:
      replicas: 1
      endpoint_mode: dnsrr
      restart_policy:
        condition: on-failure
    volumes:
        - ./scripts/:/scripts/
    depends_on:
      - mysql-server-1
      - mysql-server-2
      - mysql-server-3
    restart: on-failure
  mysql-router:
    environment:
      - MYSQL_USER=root
      - MYSQL_HOST=mysql-server-1
      - MYSQL_PORT=3306
      - MYSQL_PASSWORD=mysql
      - MYSQL_INNODB_NUM_MEMBERS=3  
    image: mysql/mysql-router:8.0
    networks:
       - overlay
    deploy:
      replicas: 1
      endpoint_mode: dnsrr
      restart_policy:
        condition: on-failure
    ports:
      - target: 6446
        published: 6446
        protocol: tcp
        mode: host
    depends_on:
      - mysql-server-1
      - mysql-server-2
      - mysql-server-3
      - mysql-shell
    restart: on-failure

networks:
  overlay:
  
```

При деплое кластера поднимается 3 контейнера с образом mysql-server:8.0.12, строка запуска каждого контейнера содержит уникальный --server_id.

Также поднимается контейнер с образом mysql-router:8.0

Также поднимается контейнер с образом mysql-shell-batch, который выполняет первоначальную конфигурацию кластера InnoDB, с помощью заранее подготовленного js файла.
Также контейнер создает тестовую базу dbwebapp
К контейнеру подключен volume с каталогом со скриптами. 
Также, чтобы compose работал в swarm корректно, переменные окружения указаны явно, т.к. переменные переданные через файл работать не будут.

JS скрипт конфигурации кластера:

```
var dbPass = "mysql"
var clusterName = "devCluster"

try {
  print('Setting up InnoDB cluster...\n');
  shell.connect('root@mysql-server-1:3306', dbPass)
  var cluster = dba.createCluster(clusterName);
  print('Adding instances to the cluster.');
  cluster.addInstance({user: "root", host: "mysql-server-2", password: dbPass})
  print('.');
  cluster.addInstance({user: "root", host: "mysql-server-3", password: dbPass})
  print('.\nInstances successfully added to the cluster.');
  print('\nInnoDB cluster deployed successfully.\n');
} catch(e) {
  print('\nThe InnoDB cluster could not be created.\n\nError: ' + e.message + '\n');
}

```

Скрипт создания БД и пользователя:

```
CREATE DATABASE dbwebappdb;
CREATE USER 'dbwebapp'@'%' IDENTIFIED BY 'dbwebapp';
GRANT ALL PRIVILEGES ON dbwebappdb.* TO 'dbwebapp'@'%';

```

Чтобы данный compose файл корректно работал в swarm кластере необходимо включить endpoint_mode: dnsrr и явно указать сеть для контейнеров:

```
networks:
  overlay:
  
и секция сети у контейнера:
    networks:
       - overlay
```

Далее запускаем старт контейнеров в swarm кластере:

```
docker stack deploy --compose-file docker-compose.yml innodbcl
```

Ждем минуту, вде пока все задеплоиться и ставим mysql клиент, чтобы проверить что все работает:

```
yum install mysql -y
```

Проверяем что сервисы запущены:

```
[root@innodbcluster ~]# docker service ls
ID                  NAME                      MODE                REPLICAS            IMAGE                               PORTS
4r2ku9myzdn3        innodbcl_mysql-router     replicated          1/1                 mysql/mysql-router:8.0
mq21jl5m6n91        innodbcl_mysql-server-1   replicated          1/1                 mysql/mysql-server:8.0.12
yk9t8fsg3b3m        innodbcl_mysql-server-2   replicated          1/1                 mysql/mysql-server:8.0.12
sf8a1f7bh2ie        innodbcl_mysql-server-3   replicated          1/1                 mysql/mysql-server:8.0.12
wh2cyqmmwwh5        innodbcl_mysql-shell      replicated          0/1                 neumayer/mysql-shell-batch:latest

```
Теперь проверьте что mysq-router корректно пускает пользователя в созданную БД dbwebapp

```
[root@innodbcluster ~]# mysql -u dbwebapp -pdbwebapp -h 127.0.0.1 -P 6446
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 739
Server version: 8.0.12 MySQL Community Server - GPL

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MySQL [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| dbwebappdb         |
| information_schema |
+--------------------+
2 rows in set (0.02 sec)

MySQL [(none)]>

```

Кластер InnoDB успешно работает и запущен в docker swarm.

Теперь добавим в swarm кластер вторую ноду. 

Подключаемся ко второму серверу и устанавливаем необходимые пакеты:

```
vagrant ssh innodbcluster2
sudo -i
```

```
yum install epel-release -y
yum install -y yum-utils  device-mapper-persistent-data lvm2 -y
yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-nightly
yum install docker-ce docker-ce-cli containerd.io -y
yum install docker-compose -y
yum remove docker-compose -y
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

Отключаем SELinux чтобы прокинуть volume в контейнер

```
setenforce 0
```

Запускаем Docker

```
systemctl start docker
```

Добавляем записи в hosts файл:

```
echo "192.168.11.101  innodbcluster" >> /etc/hosts
echo "192.168.11.102  innodbcluster2" >> /etc/hosts

```

Подключаем ноду к кластеру:

```
$(cat /vagrant/swarm.txt | grep SWMTKN)
```

Возвращаемся на первый сервер и проверяем что кластер состоит из двух нод:

```
vagrant ssh innodbcluster
sudo -i
[root@innodbcluster deploy]# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
u0k68vtajuqg0xbzqvm8el8jv *   innodbcluster       Ready               Active              Leader              19.03.8
lgz02twwgaepda383v2w4fv5w     innodbcluster2      Ready               Active                                  19.03.8

```