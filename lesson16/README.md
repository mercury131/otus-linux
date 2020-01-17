# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Bacula** - система резервного копирования и восстановления


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson16** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

Настраиваем бэкапы
Настроить стенд Vagrant с двумя виртуальными машинами server и client.

Настроить политику бэкапа директории /etc с клиента:
1) Полный бэкап - раз в день
2) Инкрементальный - каждые 10 минут
3) Дифференциальный - каждые 30 минут

Запустить систему на два часа. Для сдачи ДЗ приложить list jobs, list files jobid=<id>
и сами конфиги bacula-*

* Настроить доп. Опции - сжатие, шифрование, дедупликация 




Используемые файлы и директории:
- В директории lesson16 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания

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
cd otus-linux/lesson16
vagrant up 
vagrant ssh
```

Подождите 2 часа

Выполните команду list jobs

```

*list jobs
+-------+------------------+---------------------+------+-------+----------+------------+-----------+
| JobId | Name             | StartTime           | Type | Level | JobFiles | JobBytes   | JobStatus |
+-------+------------------+---------------------+------+-------+----------+------------+-----------+
|     1 | BackupLocalFiles | 2020-01-18 01:18:08 | B    | F     |    2,350 | 11,268,848 | T         |
|     2 | BackupLocalFiles | 2020-01-18 01:20:02 | B    | I     |        0 |          0 | T         |
|     3 | BackupClientHost | 2020-01-18 01:20:06 | B    | F     |    2,350 | 11,268,848 | T         |
|     4 | BackupLocalFiles | 2020-01-18 01:30:02 | B    | D     |        0 |          0 | T         |
|     5 | BackupLocalFiles | 2020-01-18 01:30:05 | B    | I     |        0 |          0 | T         |
|     6 | BackupClientHost | 2020-01-18 01:30:08 | B    | D     |        0 |          0 | T         |
|     7 | BackupClientHost | 2020-01-18 01:30:11 | B    | I     |        0 |          0 | T         |
|     8 | BackupLocalFiles | 2020-01-18 01:40:02 | B    | I     |        0 |          0 | T         |
|     9 | BackupClientHost | 2020-01-18 01:40:06 | B    | I     |        0 |          0 | T         |
|    10 | BackupLocalFiles | 2020-01-18 01:50:03 | B    | I     |        0 |          0 | T         |
|    11 | BackupClientHost | 2020-01-18 01:50:06 | B    | I     |        0 |          0 | T         |
|    12 | BackupLocalFiles | 2020-01-18 02:00:03 | B    | D     |        0 |          0 | T         |
|    13 | BackupLocalFiles | 2020-01-18 02:00:06 | B    | I     |        0 |          0 | T         |
|    14 | BackupClientHost | 2020-01-18 02:00:09 | B    | D     |        0 |          0 | T         |
|    15 | BackupClientHost | 2020-01-18 02:00:13 | B    | I     |        0 |          0 | T         |
|    16 | BackupLocalFiles | 2020-01-18 02:10:03 | B    | I     |        0 |          0 | T         |
|    17 | BackupClientHost | 2020-01-18 02:10:06 | B    | I     |        0 |          0 | T         |
|    18 | BackupLocalFiles | 2020-01-18 02:20:02 | B    | I     |        0 |          0 | T         |
|    19 | BackupClientHost | 2020-01-18 02:20:05 | B    | I     |        0 |          0 | T         |
|    20 | BackupLocalFiles | 2020-01-18 02:30:02 | B    | D     |        0 |          0 | T         |
|    21 | BackupLocalFiles | 2020-01-18 02:30:05 | B    | I     |        0 |          0 | T         |
|    22 | BackupClientHost | 2020-01-18 02:30:08 | B    | D     |        0 |          0 | T         |
|    23 | BackupClientHost | 2020-01-18 02:30:13 | B    | I     |        0 |          0 | T         |
|    24 | BackupLocalFiles | 2020-01-18 02:40:02 | B    | I     |        0 |          0 | T         |
|    25 | BackupClientHost | 2020-01-18 02:40:05 | B    | I     |        0 |          0 | T         |
|    26 | BackupLocalFiles | 2020-01-18 02:50:02 | B    | I     |        0 |          0 | T         |
|    27 | BackupClientHost | 2020-01-18 02:50:05 | B    | I     |        0 |          0 | T         |
|    28 | BackupLocalFiles | 2020-01-18 03:00:02 | B    | D     |        0 |          0 | T         |
|    29 | BackupLocalFiles | 2020-01-18 03:00:05 | B    | I     |        0 |          0 | T         |
|    30 | BackupClientHost | 2020-01-18 03:00:09 | B    | D     |        0 |          0 | T         |
|    31 | BackupClientHost | 2020-01-18 03:00:12 | B    | I     |        0 |          0 | T         |
|    32 | BackupLocalFiles | 2020-01-18 03:10:02 | B    | I     |        0 |          0 | T         |
|    33 | BackupClientHost | 2020-01-18 03:10:06 | B    | I     |        0 |          0 | T         |
|    34 | BackupClientHost | 2020-01-18 03:11:05 | B    | I     |        0 |          0 | T         |
+-------+------------------+---------------------+------+-------+----------+------------+-----------+

```

Выполните команду list files jobid=3

Вывод будет примерно таким:
```
| /etc/selinux/targeted/active/modules/ |
| /etc/selinux/targeted/active/ |
| /etc/selinux/targeted/active/file_contexts |
| /etc/selinux/targeted/active/file_contexts.homedirs |
| /etc/selinux/targeted/active/seusers |
| /etc/selinux/targeted/active/commit_num |
| /etc/selinux/targeted/active/homedir_template |
| /etc/selinux/targeted/active/policy.kern |
| /etc/selinux/targeted/active/users_extra |
| /etc/selinux/targeted/active/seusers.linked |
| /etc/selinux/targeted/active/users_extra.linked |
| /etc/selinux/targeted/active/policy.linked |
| /etc/selinux/final/ |
| /etc/plymouth/ |
| /etc/plymouth/plymouthd.conf |
| /etc/gnupg/ |
| /etc/tuned/ |
| /etc/tuned/active_profile |
| /etc/tuned/bootcmdline |
| /etc/tuned/profile_mode |
| /etc/tuned/tuned-main.conf |
| /etc/tuned/recommend.d/ |
| /etc/firewalld/ |
| /etc/firewalld/firewalld.conf |
| /etc/firewalld/lockdown-whitelist.xml |
| /etc/firewalld/helpers/ |
| /etc/firewalld/icmptypes/ |
| /etc/firewalld/ipsets/ |
| /etc/firewalld/services/ |
| /etc/firewalld/zones/ |
| /etc/firewalld/zones/public.xml |
| /etc/firewalld/zones/public.xml.old |
| /etc/audisp/ |
| /etc/audisp/audispd.conf |
| /etc/audisp/plugins.d/ |
| /etc/audisp/plugins.d/af_unix.conf |
| /etc/audisp/plugins.d/syslog.conf |
| /etc/audit/ |
| /etc/audit/audit-stop.rules |
| /etc/audit/auditd.conf |
| /etc/audit/audit.rules |
| /etc/audit/rules.d/ |
| /etc/audit/rules.d/audit.rules |
| /etc/kernel/postinst.d/ |
| /etc/kernel/postinst.d/51-dracut-rescue-postinst.sh |
| /etc/kernel/postinst.d/vboxadd |
| /etc/kernel/prerm.d/ |
| /etc/kernel/prerm.d/vboxadd |
| /etc/kernel/ |
| /etc/sudoers.d/ |
| /etc/sudoers.d/proxy |
| /etc/bacula/ |
| /etc/bacula/bacula-sd.conf |
| /etc/bacula/bacula-dir.conf |
| /etc/bacula/query.sql |
| /etc/bacula/bacula-fd.conf |
| /etc/bacula/bconsole.conf |
| /etc/bacula/conf.d/ |
| /etc/bacula/conf.d/pools.conf |
| /etc/bacula/conf.d/filesets.conf |
| /etc/bacula/conf.d/clients.conf |
| /etc/logwatch/conf/ |
| /etc/logwatch/conf/ignore.conf |
| /etc/logwatch/conf/logwatch.conf |
| /etc/logwatch/conf/override.conf |
| /etc/logwatch/conf/logfiles/ |
| /etc/logwatch/conf/logfiles/bacula.conf |
| /etc/logwatch/conf/services/ |
| /etc/logwatch/conf/services/bacula.conf |
| /etc/logwatch/scripts/services/ |
| /etc/logwatch/scripts/services/bacula |
| /etc/logwatch/scripts/shared/ |
| /etc/logwatch/scripts/shared/applybaculadate |
| /etc/logwatch/scripts/ |
| /etc/logwatch/ |
+----------+
+-------+------------------+---------------------+------+-------+----------+------------+-----------+
| JobId | Name             | StartTime           | Type | Level | JobFiles | JobBytes   | JobStatus |
+-------+------------------+---------------------+------+-------+----------+------------+-----------+
|     3 | BackupClientHost | 2020-01-18 01:20:06 | B    | F     |    2,350 | 11,268,848 | T         |
+-------+------------------+---------------------+------+-------+----------+------------+-----------+
*

```

# Описание выполнения данного задания.

Устанавливаем необходимые пакеты на сервер:

```
yum install epel-release -y
yum install -y bacula-director bacula-storage bacula-console bacula-client mariadb-server
```


Запускаем mysql сервер

```
systemctl start mariadb
systemctl enable mariadb
```

Запускаем скрипты Bacula для создания БД

```
/usr/libexec/bacula/grant_mysql_privileges
/usr/libexec/bacula/create_mysql_database -u root
/usr/libexec/bacula/make_mysql_tables -u bacula
```

Подключаемся к БД Mysql и меняем пароль пользователя Bacula

```
mysql -u root -p

UPDATE mysql.user SET Password=PASSWORD('bacula_db_password') WHERE User='bacula';
FLUSH PRIVILEGES;
```

Настроим работу Bacula с БД Mysql, выбрав 1

```
alternatives --config libbaccats.so
There are 3 programs which provide 'libbaccats.so'.

  SelectionCommand
-----------------------------------------------
   1   /usr/lib64/libbaccats-mysql.so
   2   /usr/lib64/libbaccats-sqlite3.so
*+ 3   /usr/lib64/libbaccats-postgresql.so
```


Создаем директории для Резервного копирования и восстановления:

```
mkdir -p /bacula/backup /bacula/restore
chown -R bacula:bacula /bacula
chmod -R 700 /bacula
```

Переходим к конфигурации Bacula Director

Открываем файл /etc/bacula/bacula-dir.conf

и меняем интерфейс на котором сервер будет принимать клиентов

```
DirAddress = 127.0.0.1
``` 

Секция будет следующего вида:

```
Director {# define myself
  Name = bacula-dir
  DIRport = 9101# where we listen for UA connections
  QueryFile = "/etc/bacula/query.sql"
  WorkingDirectory = "/var/spool/bacula"
  PidDirectory = "/var/run"
  Maximum Concurrent Jobs = 1
  Password = "@@DIR_PASSWORD@@" # Console password
  Messages = Daemon
  DirAddress = 0.0.0.0
}
```

Настроим резервное копирование локальной папки сервера /etc

В этом же файле редактируем секцию job:

```
Job {
  Name = "BackupLocalFiles"
  JobDefs = "DefaultJob"
}
```

Добавим секцию задачи восстановления файлов

```
Job {
  Name = "RestoreFiles"
  Type = Restore
  Client=bacula-fd 
  FileSet="Full Set"  
  Storage = File  
  Pool = Default
  Messages = Standard
  Where = /bacula/restore
}
```

Теперь сконфигурируем что нужно бэкапить в этой задачей, делается это через FileSet, добавляем секции в тот же файл :

```
FileSet {
  Name = "Full Set"
  Include {
Options {
  signature = MD5
  compression = GZIP
}

File = /etc
  }


  Exclude {
File = /var/spool/bacula
File = /tmp
File = /proc
File = /tmp
File = /.journal
File = /.fsck
File = /bacula
  }
}

```

Теперь перейдем к настройке Storage Daemon, он отвечает где хранить резервные копии, в этом же файле редактируем секцию:

```
Storage {
  Name = File
# Do not use "localhost" here
  Address = 192.168.11.102# N.B. Use a fully qualified name here
  SDPort = 9103
  Password = "@@SD_PASSWORD@@"
  Device = FileStorage
  Media Type = File
}
```

Далее настроим подключению к каталогу, где будет храниться информация о бэкапах, сохраненных файлах и тд.
В этом же файле добавляем секцию:

```
Catalog {
  Name = MyCatalog
# Uncomment the following line if you want the dbi driver
# dbdriver = "dbi:postgresql"; dbaddress = 127.0.0.1; dbport =  
  dbname = "bacula"; dbuser = "bacula"; dbpassword = "bacula_db_password"
}
```

Теперь хранение настроено в mysql базу

Далее настроим пул хранения, он отвечает за retention, маркировку резервных копий.

В этот же файл добавляем секцию:

```
Pool {
  Name = File
  Pool Type = Backup
  Label Format = Local-
  Recycle = yes   # Bacula can automatically recycle Volumes
  AutoPrune = yes # Prune expired volumes
  Volume Retention = 365 days # one year
  Maximum Volume Bytes = 50G  # Limit Volume size to something reasonable
  Maximum Volumes = 100   # Limit number of Volumes in Pool
}
```


Проверяем конфиг 

```
bacula-dir -tc /etc/bacula/bacula-dir.conf
```

Теперь настроим Storage Daemon, к которому смогут подключаться клиенты для хранения резервных копий

Открываем файл /etc/bacula/bacula-sd.conf и добавляем секцию

```
Storage { # definition of myself
  Name = bacula-sd
  SDPort = 9103  # Director's port  
  WorkingDirectory = "/var/spool/bacula"
  Pid Directory = "/var/run"
  Maximum Concurrent Jobs = 20
  SDAddress = 192.168.11.102
}
```

В этом же файле добавляем секцию со Storage Device, в ней указано в какой каталог сохранять резервные копии:

```
Device {
  Name = FileStorage
  Media Type = File
  Archive Device = /bacula/backup
  LabelMedia = yes;   # lets Bacula label unlabeled media
  Random Access = Yes;
  AutomaticMount = yes;   # when device opened, read it
  RemovableMedia = no;
  AlwaysOpen = no;
}
```

Проверяем конфиг:

```
bacula-sd -tc /etc/bacula/bacula-sd.conf
```

Далее меняем стандартные пароли в конфигах Bacula:


```
DIR_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bacula-dir.conf
sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bconsole.conf

SD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-sd.conf
sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-dir.conf
	
FD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-dir.conf
sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-fd.conf
```

Запускаем сервер Bacula

```
systemctl start bacula-dir
systemctl start bacula-sd
systemctl start bacula-fd
```

Для проверки локальной резервной копии /etc запускаем консоль Bacula

```
bconsole
```

Назначим label
```
label
```

Указываем тип 2

Запускам задачу командой run

Указываем job resource 1

Просматриваем статус:

```
messages
status director
```

Переходим к настройке второго сервера, клиента

Устанавливаем необходимые программы на сервере клиенте

```
yum install bacula-client
```

Далее на сервере bacula редактируем bacula-dir.conf и добавляем строку 

```
@|"find /etc/bacula/conf.d -name '*.conf' -type f -exec echo @{} \;"
```

для возможности создания дополнительных конфигов

Создаем папку /etc/bacula/conf.d

```
mkdir /etc/bacula/conf.d
```

Создаем RemoteFile Pool:

```
vi /etc/bacula/conf.d/pools.conf

Pool {
  Name = RemoteFile
  Pool Type = Backup
  Label Format = Remote-
  Recycle = yes                       # Bacula can automatically recycle Volumes
  AutoPrune = yes                     # Prune expired volumes
  Volume Retention = 365 days         # one year
    Maximum Volume Bytes = 50G          # Limit Volume size to something reasonable
  Maximum Volumes = 100               # Limit number of Volumes in Pool
}

```

Теперь переходим на сервер клиент и настраиваем File Daemon
В нем указываем назначение сервера bacula

```
vi /etc/bacula/bacula-fd.conf

Director {
  Name = bacula
  Password = "@@FD_PASSWORD@@"
}
```

Далее в этом же конфиге указываем на каком ip будет работать File daemon:

```
FileDaemon {                          # this is me
  Name = client
  FDAddress = 192.168.11.101
  FDport = 9102                  # where we listen for the director
  WorkingDirectory = /var/spool/bacula
  Pid Directory = /var/run
  Maximum Concurrent Jobs = 20
}
```
Добавим секцию по отправке сообщений на bacula сервер:

```
Messages {
  Name = Standard
  director = bacula = all, !skipped, !restored
}
```

Проверяем конфиг клиента:

```
bacula-fd -tc /etc/bacula/bacula-fd.conf
```

Запускаем службу клиента:

```
systemctl start bacula-fd
```

Создаем директории для резервного копирования и восстановления:

```
mkdir -p /bacula/restore
chown -R bacula:bacula /bacula
chmod -R 700 /bacula

```

Теперь вернемся на сервер bacula и настроим что нужно копировать с клиента:

```
vi /etc/bacula/conf.d/filesets.conf

FileSet {
  Name = "Client Etc"
  Include {
    Options {
      signature = MD5
      compression = GZIP
    }
    
    File = /etc
  }
  Exclude {
    
  }
}

```

Создадим задачу резервного копирования:

```
vi /etc/bacula/conf.d/clients.conf

Client {
  Name = client
  Address = client
  FDPort = 9102 
  Catalog = MyCatalog
  Password = "@@FD_PASSWORD@@"          # password for Remote FileDaemon
  File Retention = 30 days            # 30 days
  Job Retention = 6 months            # six months
  AutoPrune = yes                     # Prune expired Jobs/Files
}


Job {
  Name = "BackupClientHost"
  JobDefs = "DefaultJob"
  Client = client
  Pool = RemoteFile
  FileSet="Client Etc"
}
```

В ней мы указали наш сервер клиент и задачу резервного копирования


Также в файле /etc/bacula/bacula-dir.conf настроим расписание резервного копирования:

```
Schedule {
  Name = "client"
  Run = Full daily  at 01:00
  Run = Differential hourly at 0:30
  Run = Differential hourly at 0:00
  Run = Incremental hourly at 00:10
  Run = Incremental hourly at 00:20
  Run = Incremental hourly at 00:30
  Run = Incremental hourly at 00:40
  Run = Incremental hourly at 00:50
  Run = Incremental hourly at 00:00
}



JobDefs {
  Name = "DefaultJob"
  Type = Backup
  Level = Incremental
  Client = bacula-fd 
  FileSet = "Full Set"
  Schedule = "client"
  Storage = File
  Messages = Standard
  Pool = File
  Priority = 10
  Write Bootstrap = "/var/spool/bacula/%c.bsr"
}
```

Перезапускаем bacula сервер:

```
systemctl restart bacula-dir
```