# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Ansible** - система управления конфигурациями
- **Nginx** - веб сервер
- **PHP** - скриптовый язык общего назначения, интенсивно применяемый для разработки веб-приложений
- **Python** - скриптовый язык общего назначения
- **Nodejs** - программная платформа, основанная на движке V8 (транслирующем JavaScript в машинный код), превращающая JavaScript из узкоспециализированного языка в язык общего назначения


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson28** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

Роль для настройки веб сервера
Варианты стенда
nginx + php-fpm (laravel/) + python (flask/django) + js(react/angular)


Реализации на выбор
- на хостовой системе через конфиги в /etc



Используемые файлы и директории:
- В директории lesson28 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания
- В директории lesson28/ansible , расположены playbook, inventory файл и роли по установке стендов

# Как проверить домашнее задание?

Склонируйте репозиторий:

```
git clone git@github.com:mercury131/otus-linux.git
```

Установите необходимые плагины для vagrant:

```
vagrant plugin install vagrant-reload
```


Добавьте в локальный файл hosts следующую строку:

```
192.168.11.102 laravel.local python.local js.local
```


Для запуска Vagrantfile автоматизированными шагами выполните:

```
cd otus-linux/lesson28
vagrant up 
vagrant ssh
```

Для установки стенда с Laravel (nginx/php-fpm на unix-socket) выполните:

```
vagrant ssh
sudo -i

ansible-playbook /home/vagrant/laravel.yml  -i /home/vagrant/.ansible/inventory.yml
```

После завершения playbook перейдите в браужере на страницу http://laravel.local


Для установки стенда с Python (nginx / uwscgi на unix-socket) выполните:

```
vagrant ssh
sudo -i

ansible-playbook /home/vagrant/python.yml  -i /home/vagrant/.ansible/inventory.yml
```

После завершения playbook перейдите в браужере на страницу http://python.local

Для установки стенда с React (nodejs) (nginx / nodejs /React ) выполните:

```
vagrant ssh
sudo -i

ansible-playbook /home/vagrant/js.yml  -i /home/vagrant/.ansible/inventory.yml
```

В данном стенде будет собрано стандартное React приложение.

После завершения playbook перейдите в браужере на страницу http://js.local

