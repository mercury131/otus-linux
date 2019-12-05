# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Docker** - система управления контейнерами


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson9** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

- 1) С помощью docker compose запускается 3 контейнера с бд/nginx/php, с развернутым внутри laravel
- 2) собран контейнер с простым python приложением, выводящим страницу с надписью hello otus




Используемые файлы и директории:
- В директории lesson9 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания:



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
cd otus-linux/lesson9
vagrant up 
vagrant ssh
```

Откройте следующие страницы в браузере для проверки:

```
http://192.168.11.101/
http://192.168.11.101:4000/
```

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
