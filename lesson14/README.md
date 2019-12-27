# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **PAM** - подключаемые модули аутентификации
- **Policykit** - библиотека, используется для предоставления непривилегированным процессам возможности выполнения действий, требующих прав администратора



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson14** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

- 1) Запретить всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников
- 2) дать конкретному пользователю права работать с докером и возможность рестартить докер сервис





Используемые файлы и директории:
- В директории lesson14 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания:



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
cd otus-linux/lesson14
vagrant up 
vagrant ssh
```

Установите пароль пользователям admin и test

```
passwd admin
passwd test
```

Попробуйте авторизоваться пользователем test

Попробуйте авторизоваться пользователем root в выходной день.

Описание выполнения данного задания:

Добавляем группы, которым будет разрешен логин в систему:

```
echo "root" >  /etc/login.allowed
echo "wheel" >>  /etc/login.allowed
echo "admin" >>  /etc/login.allowed
```

Добавляем PAM правило с помощью которого вход в систему будет разрешен только из групп указанных выше:

```
sed -i '1iauth required pam_listfile.so onerr=fail item=group sense=allow file=/etc/login.allowed' /etc/pam.d/system-auth
```

Теперь настроим правило запрещающее логин в систему в выходные дни всем пользователям, кроме admin:

```
echo 'login & ssh;*;*!admin;Wd0900-1700' >> /etc/security/time.conf
```

Создаем тестовых пользователей для проверки:

```
adduser admin
adduser test

passwd admin
passwd test
```

Попробуйте авторизоваться пользователем test

Попробуйте авторизоваться пользователем root в выходной день.

Теперь установим докер:

```
yum install docker -y
systemctl start docker
```

Разрешим пользователю admin работать с докером:

```
setfacl -m user:admin:rw /var/run/docker.sock
```

Убеждаемся что теперь пользователь может работать с докером:

![Docker permission](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson14/docker-acl.PNG)

Теперь создадим следующие правило для Policykit, которое даст пользователю admin возможность управлять сервисом докера:

```
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.systemd1.manage-units" &&
        action.lookup("unit") == "docker.service" &&
        subject.user == "admin") {
        return polkit.Result.YES;
    }
});
```

Копируем правило:

```
cp /vagrant/51-manage-docker-daemon.rules /etc/polkit-1/rules.d/
```

Тут стоит отметить что action.lookup("unit") работает на systemd версии 226 и выше, в centos 7 используется версия 219. 

Есть пропатченная версия от facebook, установить ее можно так:

Переводим selinux в режим permissive

Далее выполняем:

```
wget https://copr.fedorainfracloud.org/coprs/jsynacek/systemd-backports-for-centos-7/repo/epel-7/jsynacek-systemd-backports-for-centos-7-epel-7.repo -O /etc/yum.repos.d/jsynacek-systemd-centos-7.repo
```

Обновляем systemd:

```
yum update systemd
```

Проверяем что пользователь может управлять сервисом:

![Docker service permission](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson14/docker-service.PNG)