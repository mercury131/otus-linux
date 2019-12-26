# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **InfluxDB** - timescale база данных
- **Telegraf** - система сбора и отправки метрик
- **Prometheus** - система мониторинга
- **Grafana** - система визуализации метрик


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson13** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

- 1) С помощью Grafana настроен дашборд с 4-мя графиками (процессор, память, диски, сеть)
- 2) Установлена система мониторинга Prometheus, в которую настроен сбор метрик
- 3) Установлена InfluxDB, в которую настроен сбор метрик
- 4) Процесс автоматизирован с помощью vagrantfile




Используемые файлы и директории:
- В директории lesson13 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания:



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
cd otus-linux/lesson13
vagrant up 
vagrant ssh
```

Откройте следующие страницы в браузере для проверки:

```
http://192.168.11.101:3000/
```

Авторизуйтесь в Grafana с помощью стандартного логина и пароля admin/admin

Откройте дашборды Prometheus и Influx

# Описание выполнения данного задания.

Устанавливаем необходимые пакеты:

```
yum install docker docker-compose -y
yum install epel-release -y
yum install docker-compose -y
```

Отключаем SELinux чтобы прокинуть volume в контейнер

```
setenforce 0
```

Запускаем Docker

```
systemctl start docker
```


Создаем сеть для контейнеров

```
docker network create testservice
```

Запускаем docker-compose

```
cd /vagrant/laravel-app
docker-compose up -d
```

Запускаем контейнер с python

```
docker run -d -p 4000:8081 mercury131/otus:hellootus
```

Описание процесса сборки и отправки его в Docker Hub. 

Копируем папку с приложением и файлами для сборки образа

```
cp -r /vagrant/docker-build ./
cd docker-build
```

Запускаем процесс сборки:

```
docker build ./ --tag=hellootus 
```

Логинимся на Docker Hub

```
docker login
```

Помечаем собранный образ тэгом

```
docker tag hellootus mercury131/otus:hellootus
```

Загружаем образ:

```
docker push mercury131/otus:hellootus
```

Теперь можно запустить собранный образ из нашего Docker Hub

```
docker run -d -p 4001:8081 mercury131/otus:hellootus
```

Проверяем что приложение внутри контейнера работает:

```
[root@testrpm ~]# docker ps
CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS              PORTS                    NAMES
c5255df21529        mercury131/otus:hellootus   "/usr/bin/dumb-ini..."   5 minutes ago       Up 5 minutes        0.0.0.0:4001->8081/tcp   gracious_turing
```

```
[root@testrpm ~]# curl http://localhost:4001
Hello OTUS!
```

Приложение собрано и работает.

Теперь соберем контейнер nginx, базой которого будет alpine linux.

переходим в каталог /vagrant/docker-build-nginx

```
cd /vagrant/docker-build-nginx
```

Для  сборки используется следующий dockerfile:

```
FROM alpine

RUN apk update && apk add nginx && apk del *-dev build-base autoconf libtool && rm -rf /var/cache/apk/* /tmp/*

RUN  mkdir -p /usr/share/nginx/html && mkdir -p /run/nginx && mkdir -p /var/lib/nginx/tmp

COPY index.html /usr/share/nginx/html/

COPY default.conf /etc/nginx/conf.d/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

Запустим сборку образа:

```
docker build -t alpine-nginx:latest .
```

Теперь отправим образ в docker hub

Логинимся на Docker Hub

```
docker login
```

Помечаем собранный образ тэгом

```
docker tag alpine-nginx mercury131/alpine-nginx:latest
```

Загружаем образ:

```
docker push mercury131/alpine-nginx:latest
```

Теперь можно запустить собранный образ из нашего Docker Hub

```
docker run -d -p 8080:80 mercury131/alpine-nginx:latest
```

Открываем в браузере страницу http://192.168.11.101:8080/ и видим запущенный контейнер.

Теперь ответим на вопрос чем отличается образ от контейнера? 

Образ, это сущность состоящая из слоев, которые мы выполняем при сборке. 

Образ можно использовать или переиспользовать при сборке других образов, либо для запуска, тогда мы получаем другую сущность контейнер.

Контейнер же является запущенным образом, м него можно вносить изменения, но нужно понимать что это stateless сущность, при перезапуске контейнера все внесенные изменения будут потеряны (если изменения вносились не на подключенный volume)

Итого - изменения можно и нужно вносить в образ, из которого потом тиражировать контейнеры.

Можно ли собрать ядро Linux в контейнере? 

Можно, в каталоге otus-linux/lesson9/docker-build-kernel/ , Dockerfile выглядит следующим образом:

```

FROM centos:centos7

RUN yum install openssl ncurses-devel make gcc bc openssl-devel elfutils-libelf-devel rpm-build wget flex bison rsync -y

COPY .config /tmp/.config

RUN  wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.3.8.tar.xz && tar xvf linux-5.3.8.tar.xz

RUN	 cd /linux-5.3.8 && cp /tmp/.config /linux-5.3.8/.config && cat  /tmp/.config && yes "" | make oldconfig &&	 make rpm-pkg 


CMD ["/bin/sh"]

```

Обратите внимание, что в контейнере нет каталога /boot/ , и взять конфиг оттуда не получится. 

Поэтому берем файл с "настоящей Centos 7 " и просто копируем его в контейнер при сборке.

Запускаем сборку:

```
docker build -t build-kernel:latest .
```

После ее завершения собранные RPM будут внутри контейнера, вытащить их можно командой docker cp

Каталог с собранными RPM /linux-5.3.8/rpmbuild/RPMS/x86_64/

