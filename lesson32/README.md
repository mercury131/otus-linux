# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **postgres** - Opensource БД
- **barman** - система резервного копирования БД Postgres




Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson32** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

PostgreSQL
- Настроить hot_standby репликацию с использованием слотов
- Настроить правильное резервное копирование

Для сдачи работы присылаем ссылку на репозиторий, в котором должны обязательно быть Vagranfile и плейбук Ansible, конфигурационные файлы postgresql.conf, pg_hba.conf и recovery.conf, а так же конфиг barman, либо скрипт резервного копирования. Команда "vagrant up" должна поднимать машины с настроенной репликацией и резервным копированием. Рекомендуется в README.md файл вложить результаты (текст или скриншоты) проверки работы репликации и резервного копирования. 




Используемые файлы и директории:
- В директории lesson32 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания


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
cd otus-linux/lesson32
vagrant up 
```

Далее зайдите на машину backup3 и выполните ansible playbook-и:

```
vagrant ssh backup3
sudo -i
ansible-playbook /home/vagrant/playbook.yml  -i /home/vagrant/.ansible/inventory.yml
ansible-playbook /home/vagrant/backup.yml  -i /home/vagrant/.ansible/inventory.yml

```

Данные playbook настроят репликацию между postgres серверами и настроят резервное копирование master


Чтобы проверить репликацию подключитесь к серверу postgres1 и создайте новую БД 
```
vagrant ssh postgres1
sudo -i
sudo -u postgres psql -c "CREATE DATABASE replitest2"
```

Подключитесь к серверу postgres2 и и проверьте что новая БД реплицировалась
```
vagrant ssh postgres2
sudo -i
sudo -u postgres psql -c "\l"

[root@postgres2 ~]# sudo -u postgres psql -c "\l"

                                  List of databases
    Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
------------+----------+----------+-------------+-------------+-----------------------
 postgres   | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 |
 replitest  | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 |
 replitest2 | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 |
 template0  | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 | =c/postgres          +
            |          |          |             |             | postgres=CTc/postgres
 template1  | postgres | UTF8     | en_NZ.UTF-8 | en_NZ.UTF-8 | =c/postgres          +
            |          |          |             |             | postgres=CTc/postgres
(5 rows)

```

Чтобы проверить работоспособность бэкапа, подключитесь к серверу backup3 и запустите резервное копирование:

```
vagrant ssh backup3
sudo -i
barman check pgdb
Server pgdb:
        PostgreSQL: OK
        is_superuser: OK
        wal_level: OK
        directories: OK
        retention policy settings: OK
        backup maximum age: OK (no last_backup_maximum_age provided)
        compression settings: OK
        failed backups: OK (there are 0 failed backups)
        minimum redundancy requirements: OK (have 1 backups, expected at least 0)
        ssh: OK (PostgreSQL server)
        not in recovery: OK
        systemid coherence: OK
        archive_mode: OK
        archive_command: OK
        continuous archiving: OK
        archiver errors: OK




barman backup pgdb
Starting backup using rsync-exclusive method for server pgdb in /dbbackups/barman/pgdb/base/20200325T031002
Backup start at LSN: 0/8000028 (000000010000000000000008, 00000028)
Starting backup copy via rsync/SSH for 20200325T031002
Copy done (time: 15 seconds)
Asking PostgreSQL server to finalize the backup.
Backup size: 38.7 MiB
Backup end at LSN: 0/8000130 (000000010000000000000008, 00000130)
Backup completed (start time: 2020-03-25 03:10:02.831422, elapsed time: 29 seconds)
Processing xlog segments from file archival for pgdb
        000000010000000000000007
        000000010000000000000008
        000000010000000000000008.00000028.backup



```