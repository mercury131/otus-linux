# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Docker** - система управления контейнерами
- **Nginx** - веб сервер


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson27** - ссылка на данное домашнее задание
- **https://gitlab.com/otus_linux/nginx-antiddos-example** - исходные репозиторий с заданием


 


В рамках данного домашнего задания выполнено:

Написать конфигурацию nginx, которая даёт доступ клиенту только с определенной cookie.
Если у клиента её нет, нужно выполнить редирект на location, в котором кука будет добавлена, после чего клиент будет обратно отправлен (редирект) на запрашиваемый ресурс.
Смысл: умные боты попадаются редко, тупые боты по редиректам с куками два раза не пойдут

Защиту из предыдудщего задания можно проверить/преодолеть командой curl -c cookie -b cookie http://localhost/otus.txt -i -L
Ваша задача написать такую конфигурацию, которая отдает контент клиенту умеющему java script и meta-redirect



Используемые файлы и директории:
- В директории lesson27 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания:



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
cd otus-linux/lesson27
vagrant up 
vagrant ssh

docker run -d -p 80:80 mercury131/antiddos-nginx:latest
```

Откройте следующие страницы в браузере для проверки:

```
http://192.168.11.101/
```

![DDOS Cookie Protection](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson27/cookie.PNG)

Для проверка задания с js выполните:

```
vagrant ssh
docker ps 
docker kill antiddos-nginx
docker run -d -p 80:80 mercury131/antiddos-nginx:advanced
```

Откройте следующие страницы в браузере для проверки:

```
http://192.168.11.101/
```

![DDOS Cookie + js + meta Protection](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson27/cookie_js.PNG)

# Описание выполнения данного задания.

Устанавливаем необходимые пакеты:

```
yum install docker -y

```


Запускаем Docker

```
systemctl start docker
```

Собираем первый контейнер из каталога nginx-antiddos-example-master и публикуем на docker hub
Предварительно логинимся на docker hub
```
docker login
docker build -t antiddos-nginx:latest .
docker tag antiddos-nginx mercury131/antiddos-nginx:latest
docker push mercury131/antiddos-nginx:latest
```

Запускаем контейнер и проверяем в браузере что все работает:

```
docker run -d -p 80:80 mercury131/antiddos-nginx:latest
```

```
http://192.168.11.101/
```

![DDOS Cookie Protection](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson27/cookie.PNG)

Убиваем контейнер и собираем, публикуем, запускаем следующий с js и meta:
Сборка в директории nginx-antiddos-js

```
docker ps 
docker kill antiddos-nginx
docker build -t antiddos-nginx:advanced .
docker tag antiddos-nginx:advanced mercury131/antiddos-nginx:advanced
docker push mercury131/antiddos-nginx:advanced
docker run -d -p 80:80 mercury131/antiddos-nginx:advanced
```

Проверяем в браузере что все работает:

![DDOS Cookie + js + meta Protection](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson27/cookie_js.PNG)
