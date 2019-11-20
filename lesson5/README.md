# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **systemd** - подсистема инициализации Linux 


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson5** - ссылка на данное домашнее задание

В рамках данного домашнего задания выполнено:
- **Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова** 
- **Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл** 
- **Дополнить юнит-файл apache httpd возможностью запустить несколько инстансов сервера с разными конфигами** 
- **Скачать демо-версию Atlassian Jira и переписать основной скрипт запуска на unit-файл** 

Используемые файлы и директории:
- Во директории lesson5 расположен Vagrantfile с образом Centos 7 , установленным на LVM раздел


# Как проверить домашнее задание?

Склонируйте репозиторий:

```
git clone git@github.com:mercury131/otus-linux.git
```

Установите необходимые плагины для vagrant:

```
vagrant plugin install vagrant-reload
```

Для запуска VM выполните:

```
cd otus-linux/lesson5/
vagrant up 
vagrant ssh
```


# Описание выполнения данного задания.

## Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова

После запуска VM, в каталоге /vagrant расположены следующие файлы

- watcher.service (сервис юнит, запускающий скрипт watcher.sh)
- watcher.target (таргет systemd, запускающий юнит watcher.service каждые 30 минут)
- watcher.sh (скрипт проверяющий наличие ключевого слова)

Копируем юнит файл и таргет в каталог systemd

```
cp /vagrant/watcher.service /etc/systemd/system/
cp /vagrant/watcher.target /etc/systemd/system/
```

копируем скрипт в /opt и даем ему права на запуск

```
cp /vagrant/watcher.sh /opt/ && chmod +x /opt/watcher.sh
```

Создаем файл /etc/sysconfig/watcher

```
touch /etc/sysconfig/watcher
```

Добавляем переменные в файл

```
echo 'WORD="USER_LOGIN"' >> /etc/sysconfig/watcher
echo 'FILE=/var/log/audit/audit.log' >> /etc/sysconfig/watcher
```

Обновим конфигурацию сервисов systemd 

```
systemctl daemon-reload
```

Запускаем сервис

```
systemctl start watcher.service
```

Проверяем вывод

```
systemctl status watcher.service


Nov 20 23:23:28 testsystemd systemd[1]: Started My watcher service.
Nov 20 23:24:36 testsystemd systemd[1]: Starting My watcher service...
Nov 20 23:24:36 testsystemd watcher.sh[18263]: WORD USER_LOGIN NOT found in  - Wed Nov 20 23:24:36 NZDT 2019
Nov 20 23:24:36 testsystemd systemd[1]: Started My watcher service.

```

## Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл

устанавливаем spawn-fcgi

```
yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y
```

Depecated сервис расположен - /etc/rc.d/init.d/spawn-fcgi

```
cat /etc/rc.d/init.d/spawn-fcgi
```

Раскомментируем переменные окружения в файле /etc/sysconfig/spawn-fcgi

```
vi /etc/sysconfig/spawn-fcgi

SOCKET=/var/run/php-fcgi.sock
OPTIONS="-u apache -g apache -s $SOCKET -S -M 0600 -C 32 -F 1 -P /var/run/spawn-fcgi.pid -- /usr/bin/php-cgi"

```

Создаем Юнит файл

```
vi /etc/systemd/system/spawn-fcgi.service
```

```
cat /etc/systemd/system/spawn-fcgi.service

[Unit]
Description=Spawn-fcgi startup service
After=network.target

[Service]

Type=simple
PIDFile=/var/run/spawn-fcgi.pid
EnvironmentFile=/etc/sysconfig/spawn-fcgi
ExecStart=/usr/bin/spawn-fcgi -n $OPTIONS
KillMode=process

[Install]
WantedBy=multi-user.target

```

Выполняем перезапуск конфигурации сервисов

```
systemctl daemon-reload
```

Запускаем сервис

```
systemctl start spawn-fcgi.service
```

Проверяем что сервис работает

```
systemctl status spawn-fcgi.service
● spawn-fcgi.service - Spawn-fcgi startup service
   Loaded: loaded (/etc/systemd/system/spawn-fcgi.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2019-11-21 00:15:15 NZDT; 5s ago
 Main PID: 25422 (php-cgi)
   CGroup: /system.slice/spawn-fcgi.service
           ├─25422 /usr/bin/php-cgi
           ├─25423 /usr/bin/php-cgi
           ├─25424 /usr/bin/php-cgi
           ├─25425 /usr/bin/php-cgi
           ├─25426 /usr/bin/php-cgi
           ├─25427 /usr/bin/php-cgi
           ├─25428 /usr/bin/php-cgi
           ├─25429 /usr/bin/php-cgi
           ├─25430 /usr/bin/php-cgi
           ├─25431 /usr/bin/php-cgi
           ├─25432 /usr/bin/php-cgi
           ├─25433 /usr/bin/php-cgi
           ├─25434 /usr/bin/php-cgi
           ├─25435 /usr/bin/php-cgi
           ├─25436 /usr/bin/php-cgi
           ├─25437 /usr/bin/php-cgi
           ├─25438 /usr/bin/php-cgi
           ├─25439 /usr/bin/php-cgi
           ├─25440 /usr/bin/php-cgi
           ├─25441 /usr/bin/php-cgi
           ├─25442 /usr/bin/php-cgi
           ├─25443 /usr/bin/php-cgi
           ├─25444 /usr/bin/php-cgi
           ├─25445 /usr/bin/php-cgi
           ├─25446 /usr/bin/php-cgi
           ├─25447 /usr/bin/php-cgi
           ├─25448 /usr/bin/php-cgi
           ├─25449 /usr/bin/php-cgi
           ├─25450 /usr/bin/php-cgi
           ├─25451 /usr/bin/php-cgi
           ├─25452 /usr/bin/php-cgi
           ├─25453 /usr/bin/php-cgi
           └─25454 /usr/bin/php-cgi

Nov 21 00:15:15 testsystemd systemd[1]: Started Spawn-fcgi startup service.
```

## Дополнить юнит-файл apache httpd возможностью запустить несколько инстансов сервера с разными конфигами

Для выполнения задания необходимо отредактировать следующий сервис:

```
systemctl cat httpd
# /usr/lib/systemd/system/httpd.service
[Unit]
Description=The Apache HTTP Server
After=network.target remote-fs.target nss-lookup.target
Documentation=man:httpd(8)
Documentation=man:apachectl(8)

[Service]
Type=notify
EnvironmentFile=/etc/sysconfig/httpd
ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
ExecStop=/bin/kill -WINCH ${MAINPID}
# We want systemd to give httpd some time to finish gracefully, but still want
# it to kill httpd after TimeoutStopSec if something went wrong during the
# graceful stop. Normally, Systemd sends SIGTERM signal right after the
# ExecStop, which would kill httpd. We are sending useless SIGCONT here to give
# httpd time to finish.
KillSignal=SIGCONT
PrivateTmp=true

[Install]
WantedBy=multi-user.target

```

Для редактирования скопируем сервис в /etc/systemd/system/

```
cp /usr/lib/systemd/system/httpd.service /etc/systemd/system/httpd@.service
```

Отредактируем сервис /etc/systemd/system/httpd.service , добавив ему -%I в строку указывающую на файл окружения

```
vi /etc/systemd/system/httpd@.service
```

```
cat /etc/systemd/system/httpd@.service

[Unit]
Description=The Apache HTTP Server %I
After=network.target remote-fs.target nss-lookup.target
Documentation=man:httpd(8)
Documentation=man:apachectl(8)

[Service]
Type=notify
EnvironmentFile=/etc/sysconfig/httpd-%I
ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
ExecStop=/bin/kill -WINCH ${MAINPID}
# We want systemd to give httpd some time to finish gracefully, but still want
# it to kill httpd after TimeoutStopSec if something went wrong during the
# graceful stop. Normally, Systemd sends SIGTERM signal right after the
# ExecStop, which would kill httpd. We are sending useless SIGCONT here to give
# httpd time to finish.
KillSignal=SIGCONT
PrivateTmp=true

[Install]
WantedBy=multi-user.target

```

Теперь создаим 2 файла с переменными окружения:

```
cp /etc/sysconfig/httpd /etc/sysconfig/httpd-2
cp /etc/sysconfig/httpd /etc/sysconfig/httpd-1

```


Создадим конфиги с PID и порт для данных сервисов:

```
vi /etc/httpd-1.conf
```

```
cat /etc/httpd-1.conf

Listen 81
User apache
Group apache
PidFile /var/run/httpd-1.pid

```

```
vi /etc/httpd-2.conf
```

```
cat /etc/httpd-2.conf

Listen 82
User apache
Group apache
PidFile /var/run/httpd-2.pid

```

Отредактируем файлы с переменными окружения:

```
vi /etc/sysconfig/httpd-1
vi /etc/sysconfig/httpd-2
```

```
cat /etc/sysconfig/httpd-1

OPTIONS=-f /etc/httpd-1.conf

#
# This setting ensures the httpd process is started in the "C" locale
# by default.  (Some modules will not behave correctly if
# case-sensitive string comparisons are performed in a different
# locale.)
#
LANG=C

```


```
cat /etc/sysconfig/httpd-2

OPTIONS=-f /etc/httpd-2.conf

#
# This setting ensures the httpd process is started in the "C" locale
# by default.  (Some modules will not behave correctly if
# case-sensitive string comparisons are performed in a different
# locale.)
#
LANG=C

```


Выполняем перезапуск конфигурации сервисов

```
systemctl daemon-reload
```

Запустим сервисы для проверки:

```
systemctl start httpd@1
```

