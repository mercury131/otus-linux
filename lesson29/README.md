# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Mysql** - Реляционная база данных



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson29** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

развернуть базу из дампа и настроить репликацию
В материалах приложены ссылки на вагрант для репликации
и дамп базы bet.dmp
базу развернуть на мастере
и настроить чтобы реплицировались таблицы
| bookmaker |
| competition |
| market |
| odds |
| outcome

* Настроить GTID репликацию

варианты которые принимаются к сдаче
- рабочий вагрантафайл
- скрины или логи SHOW TABLES
* конфиги
* пример в логе изменения строки и появления строки на реплике 



Используемые файлы и директории:
- В директории lesson29 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания


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
cd otus-linux/lesson29
vagrant up 
```

Чтобы проверить работоспособность репликации, подключитесь к первой ноде и выполните команды добавления новой строки в таблицу БД:

```
vagrant ssh mysql1
sudo -i

mysql -u root --password='Mysql77RooTP@S$' bet --execute="select * from bookmaker ;"

mysql -u root --password='Mysql77RooTP@S$' bet --execute="INSERT INTO bookmaker (id,bookmaker_name) VALUES(16,'pepsi');"

mysql -u root --password='Mysql77RooTP@S$' bet --execute="select * from bookmaker ;"

+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
| 15 | otus           |
| 16 | pepsi          |
|  3 | unibet         |
+----+----------------+
```

Теперь подключитель с Slave серверу и проверьте статус репликации и то что новая запись реплицировалась:

```
vagrant ssh mysql2

sudo -i

mysql -u root --password='Mysql77RooTP@S$' bet --execute='show slave status \G'

mysql -u root --password='Mysql77RooTP@S$' bet --execute="select * from bookmaker ;"


+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
| 15 | otus           |
| 16 | pepsi          |
|  3 | unibet         |
+----+----------------+
```

GTID репликация работает успешно.



# Описание выполнения данного задания

Устанавливаем необходимые пакеты на обе сервера (Master и Slave):

```
yum install epel-release wget -y
wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm && rpm -Uvh mysql80-community-release-el7-1.noarch.rpm
yum install mysql-server -y
```

Чтобы репликация корректно работала нужно открыть порты на firewall:

```
firewall-cmd --zone=public --add-service=mysql --permanent
firewall-cmd --reload
```

Редактируем конфиг mysql на MASTER и запускаем сервер:

```
vi /etc/my.cnf

server-id = 1
log-bin = mysql-bin
binlog_format = row
gtid-mode=ON
enforce-gtid-consistency
log-slave-updates

bind-address    = 0.0.0.0
```

Перезапускаем mysql сервер

```
systemctl restart mysqld
```

Меняем пароль root:

```
mysql -u root --password="$(cat /var/log/mysqld.log | grep password | awk {'print $13'})" --connect-expired-password --execute=" ALTER USER 'root'@'localhost' IDENTIFIED BY 'Mysql77RooTP@S$';"
```

Создаем пользователя для работы репликации:

```
create user 'repl_user'@'%' identified by 'PASS';
Grant replication slave on *.* to 'repl_user'@'%';
```

Теперь выполняем бэкап всех БД, включая конфигурацию, чтобы перенести это на Slave сервер:

```
mysqldump --all-databases -flush-privileges --single-transaction --flush-logs --triggers --routines --events --hex-blob --user=root  --password=Mysql77RooTP@S$ > mysqlbackup_dump.sql
```

Теперь переходим на Slave сервер и редаетируем конфиг mysql:

```
vi /etc/my.cnf
 
server-id = 2
log-bin = mysql-bin
relay-log = relay-log-server
read-only = ON
gtid-mode=ON
enforce-gtid-consistency
log-slave-updates

replicate-wild-do-table=bet.bookmaker
replicate-wild-do-table=bet.competition
replicate-wild-do-table=bet.market
replicate-wild-do-table=bet.odds
replicate-wild-do-table=bet.outcome
```

С помощью параметров replicate-wild-do-table, указываем какие именно таблицы мы хотим реплицировать с Master

Перезапускаем mysql сервер

```
systemctl restart mysqld
```

Меняем пароль root:

```
mysql -u root --password="$(cat /var/log/mysqld.log | grep password | awk {'print $13'})" --connect-expired-password --execute=" ALTER USER 'root'@'localhost' IDENTIFIED BY 'Mysql77RooTP@S$';"
```

Выполняем команду изменения мастера:

```
CHANGE MASTER TO MASTER_HOST = '192.168.11.102', MASTER_PORT = 3306, MASTER_USER = 'repl_user', MASTER_PASSWORD = 'PASS', MASTER_AUTO_POSITION = 1;
```

Запускаем Slave:

```
start slave;
```

Проверяем статус репликации:

```
show slave status \G

*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.11.102
                  Master_User: repl_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000002
          Read_Master_Log_Pos: 780
               Relay_Log_File: relay-log-server.000002
                Relay_Log_Pos: 954
        Relay_Master_Log_File: mysql-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table:
      Replicate_Wild_Do_Table: bet.bookmaker,bet.competition,bet.market,bet.odds,bet.outcome
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 0
                   Last_Error:
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 780
              Relay_Log_Space: 1163
              Until_Condition: None
               Until_Log_File:
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File:
           Master_SSL_CA_Path:
              Master_SSL_Cert:
            Master_SSL_Cipher:
               Master_SSL_Key:
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error:
               Last_SQL_Errno: 0
               Last_SQL_Error:
  Replicate_Ignore_Server_Ids:
             Master_Server_Id: 1
                  Master_UUID: 85d107b8-5f9b-11ea-80dd-080027ae509e
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind:
      Last_IO_Error_Timestamp:
     Last_SQL_Error_Timestamp:
               Master_SSL_Crl:
           Master_SSL_Crlpath:
           Retrieved_Gtid_Set: 85d107b8-5f9b-11ea-80dd-080027ae509e:43-44
            Executed_Gtid_Set: 85d107b8-5f9b-11ea-80dd-080027ae509e:1-44,
a51e8c43-5f9e-11ea-bbb5-080027ae509e:1
                Auto_Position: 1
         Replicate_Rewrite_DB:
                 Channel_Name:
           Master_TLS_Version:
       Master_public_key_path:
        Get_master_public_key: 0
            Network_Namespace:

```

Чтобы проверить работоспособность репликации, подключитесь к первой ноде и выполните команды добавления новой строки в таблицу БД:

```
vagrant ssh mysql1
sudo -i

mysql -u root --password='Mysql77RooTP@S$' bet --execute="select * from bookmaker ;"

mysql -u root --password='Mysql77RooTP@S$' bet --execute="INSERT INTO bookmaker (id,bookmaker_name) VALUES(16,'pepsi');"

mysql -u root --password='Mysql77RooTP@S$' bet --execute="select * from bookmaker ;"

+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
| 15 | otus           |
| 16 | pepsi          |
|  3 | unibet         |
+----+----------------+
```

Теперь подключитель с Slave серверу и проверьте статус репликации и то что новая запись реплицировалась:

```
vagrant ssh mysql2

sudo -i

mysql -u root --password='Mysql77RooTP@S$' bet --execute='show slave status \G'

mysql -u root --password='Mysql77RooTP@S$' bet --execute="select * from bookmaker ;"


+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
| 15 | otus           |
| 16 | pepsi          |
|  3 | unibet         |
+----+----------------+
```

GTID репликация работает успешно.