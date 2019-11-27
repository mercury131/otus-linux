# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Bash** - командный интерпретатор в юниксоподобных системах
- **AWK** - C-подобный скриптовый язык построчного разбора и обработки входного потока


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson6** - ссылка на данное домашнее задание

В рамках данного домашнего задания выполнено:
- **написать скрипт для крона** 
- **который раз в час присылает на заданную почту:** 
- **- X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта** 
- **- Y запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска** 
- **- все ошибки c момента последнего запуска** 
- **- список всех кодов возврата с указанием их кол-ва с момента последнего запуска** 
- **в письме должно быть прописан обрабатываемый временной диапазон** 
- **должна быть реализована защита от мультизапуска** 

Используемые файлы и директории:
- В директории lesson6 расположен Vagrantfile с образом Centos 7 и автоматизированными шагами установки скрипта в Cron + установка почтового сервера postfix для отправки писем


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
cd otus-linux/lesson6
vagrant up 
vagrant ssh
```

Внутри виртуальной машины скрипт расположен в каталоге /vagrant


# Описание выполнения данного задания.

Скрипт расположен в директории - https://github.com/mercury131/otus-linux/blob/master/lesson6/log-analizer.sh

Чтобы прочитать help по данному скрипту запустите:

```
bash log-analizer.sh help
```

Сделайте скрипт исполняемым, чтобы явно не указывать интерпритатор:

```
chmod +x log-analizer.sh
```

Для запуска анализа лога, передайте путь к логу в качестве параметра:

```

cd /vagrant

./log-analizer.sh access-4560-6440672.log

```

Вывод скрипта будет следующий:

```
#### Result ####

Requests count by CODE:

Code 200 requests count - 565
Code 301 requests count - 106
Code 304 requests count - 1
Code 400 requests count - 7
Code 403 requests count - 1
Code 404 requests count - 53
Code 405 requests count - 1
Code 499 requests count - 2
Code 500 requests count - 3

Unique IP - 174

Top 10 IP by accessing server:
221.132.27.142
217.196.115.205
217.118.66.161
216.10.242.46
213.32.18.50
213.202.100.91
212.57.117.19
210.14.72.78
209.17.96.74
209.17.96.226

Top 10 URL by accessing URL:
      5 /robots.txt
      5 /1
     35 /
      2 /.well-known/security.txt
      2 /sitemap.xml
      2 /admin/config.php
      1 /wp-includes/ID3/comay.php
      1 /wp-cron.php?doing_wp_cron=1565803543.6812090873718261718750
      1 /wp-cron.php?doing_wp_cron=1565760219.4257180690765380859375
      1 /wp-content/uploads/2018/08/seo_script.php

Last parsed line in log - 750
line:
 165.22.19.102 - - [14/Aug/2019:04:38:37 +0300] "POST /xmlrpc.php HTTP/1.1" 200 292 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:62.0) Gecko/20100101 Firefox/62.0"rt=0.309 uct="0.000" uht="0.246" urt="0.246"

Log analize events between 14/Aug/2019:04:12:10 - 14/Aug/2019:04:38:37

Run at Tue Nov 26 01:33:36 NZDT 2019

```

Если запустить скрипт повторно, то вывод будет следующим:

```
./log-analizer.sh access-4560-6440672.log

Last parsed line 750
Log file already parsed. (nothing to do)
Run at Tue Nov 26 01:35:24 NZDT 2019
```

Чтобы скрипт начал обрабатывать новые данные, добавим несколько дублирующих строк в конец лога:

```
tail -n 5 access-4560-6440672.log >> access-4560-6440672.log
```

Запустим скрипт еще раз:

```
./log-analizer.sh access-4560-6440672.log
Last parsed line 750

#### Result ####

Requests count by CODE:

Code 200 requests count - 6

Unique IP - 3

Top 10 IP by accessing server:
200.33.155.30
165.22.19.102
62.75.198.172

Top 10 URL by accessing URL:


Last parsed line in log - 755
line:
 165.22.19.102 - - [14/Aug/2019:04:38:37 +0300] "POST /xmlrpc.php HTTP/1.1" 200 292 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:62.0) Gecko/20100101 Firefox/62.0"rt=0.309 uct="0.000" uht="0.246" urt="0.246"

Log analize events between 14/Aug/2019:04:38:37 - 14/Aug/2019:04:38:37

Run at Tue Nov 26 01:37:17 NZDT 2019

```

Обработались только новые строки лога.

Теперь проверим защиту от мультизапуска.

Запускаем в фоне скрипт с параметром delay

```
./log-analizer.sh access-4560-6440672.log delay &
```

Теперь попробуем запустить скрипт в текущей сессии
```
[root@testbash vagrant]# ls /tmp/
lockfile  vagrant-shell

[root@testbash vagrant]# ./log-analizer.sh access-4560-6440672.log
Failed to acquire lockfile: /tmp/lockfile.
Locked by:
 root     19405  0.0  0.0 113180  1460 pts/0    S    01:55   0:00 /bin/bash ./log-analizer.sh access-4560-6440672.log delay
root     19411  0.0  0.0 113180  1460 pts/0    S+   01:55   0:00 /bin/bash ./log-analizer.sh access-4560-6440672.log
root     19412  0.0  0.0 113180   596 pts/0    S+   01:55   0:00 /bin/bash ./log-analizer.sh access-4560-6440672.log


```

Сработала проверка на мультизапуск, скрипт не будет запущен, пока не завершиться его фоновая копия.

