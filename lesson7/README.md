# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Bash** - командный интерпретатор в юниксоподобных системах
- **Docker** - программное обеспечение для автоматизации развёртывания и управления приложениями в средах с поддержкой контейнеризации
- **yum** - открытый консольный менеджер пакетов для дистрибутивов Linux, основанных на пакетах формата RPM
- **rpm** - менеджер пакетов


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson7** - ссылка на данное домашнее задание

В рамках данного домашнего задания выполнено:
- **создать свой RPM (можно взять свое приложение, либо собрать к примеру апач с определенными опциями)** 
- **создать свой репо и разместить там свой RPM, реализовать это все либо в вагранте, либо развернуть у себя через nginx и дать ссылку на репо** 
- ** *реализовать дополнительно пакет через docker** 

Используемые файлы и директории:
- В директории lesson6 расположен Vagrantfile с образом Centos 7 и автоматизированными шагами выполнения задания


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
cd otus-linux/lesson7
vagrant up 
vagrant ssh
```


# Описание выполнения данного задания.

Устанавливаем необходимые пакеты:

```
yum install createrepo -y
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils
yum install openssl-devel zlib-devel pcre-devel gcc -y
```

Скачиваем Nginx Source RPM

```
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
```

Устанавливаем его

```
rpm -ivh nginx-1.14.1-1.el7_4.ngx.src.rpm
```

Скачиваем openssl

```
wget https://www.openssl.org/source/latest.tar.gz
```

Распаковываем:

```
tar -xvf latest.tar.gz
```

Устанавливаем зависимости необходимые для сборки пакета:

```
yum-builddep rpmbuild/SPECS/nginx.spec
```

Изменяем файл спецификации nginx

```
sed -i 's+--with-debug+--with-debug --with-openssl=/root/openssl-1.1.1d+' rpmbuild/SPECS/nginx.spec
```

Запускаем процесс сборки RPM

```
rpmbuild -bb rpmbuild/SPECS/nginx.spec
```

Установим собранный Nginx 

```
yum localinstall -y rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm
```

Запустим nginx 

```
systemctl start nginx;systemctl status nginx
```

Теперь установим докер , в нем запустим контейнер с nginx и разместим там репозиторий

```
yum install docker -y
systemctl start docker
```

Чтобы корректно примонтировать каталог хоста к контейнеру, отключим selinux (как альтернатива, можно перевести его в permissive)

```
echo 0 > /sys/fs/selinux/enforce
```

Создаем каталоги

```
mkdir /var/www
chmod -R 0755 /var/www
```

Копируем собранные RPM

```
cp /root/rpmbuild/RPMS/x86_64/nginx-* /var/www
```

Запускаем контейнер

```
docker run -d --name nginxrepo  -v /var/www:/usr/share/nginx/html -p 8080:80 nginx:latest
```

Активируем листинг каталогов в nginx:

```
docker cp /vagrant/default.conf nginxrepo:/etc/nginx/conf.d/default.conf
docker exec nginxrepo service nginx reload
```

Создаем репозиторий:

```
createrepo /var/www

```

Проверяем что rpm файл доступен

```
wget localhost:8080/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm
```