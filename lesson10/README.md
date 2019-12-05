# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Ansible** - система управления конфигурациями


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson10** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

Подготовить стенд на Vagrant как минимум с одним сервером. На этом сервере используя Ansible необходимо развернуть nginx со следующими условиями:
- необходимо использовать модуль yum/apt
- конфигурационные файлы должны быть взяты из шаблона jinja2 с перемененными
- после установки nginx должен быть в режиме enabled в systemd
- должен быть использован notify для старта nginx после установки
- сайт должен слушать на нестандартном порту - 8080, для этого использовать переменные в Ansible
* Сделать все это с использованием Ansible роли




Используемые файлы и директории:
- В директории lesson10 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания
- В директории lesson10/ansible , расположены playbook, inventory файл и роль по установке nginx, в каталоге lesson10/ansible/my-nginx

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
cd otus-linux/lesson10
vagrant up 
vagrant ssh
```

Откройте следующие страницы в браузере для проверки:

```
http://192.168.11.102:8080
```

# Описание выполнения данного задания.

Устанавливаем необходимые пакеты:

```
yum install epel-release -y
yum install ansible vim -y
```

Копируем SSH ключи на машину с Ansible:

```
cp /vagrant/id_rsa /home/vagrant/.ssh/
cp /vagrant/id_rsa /root/.ssh/
```

Выставляем корректные права на SSH ключи

```
chmod 0600 /root/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa 
chmod 0600 /home/vagrant/.ssh/id_rsa
```

Прописываем второй хост, куда будем ставить nginx в hosts, чтобы обеспечить связанность по dns имени:

```
echo "192.168.11.102  web" >> /etc/hosts
```

Создаем структуру каталогов для Ansible и копируем роль для установки nginx в необходимые директории:
Роль копируем в домашние каталоги, для удобства при дебаге.
```
mkdir ~/ansible
mkdir -p /etc/ansible/roles/
mkdir -p /home/vagrant/.ansible/roles/
mkdir -p /root/.ansible/roles/
cp -r /vagrant/ansible/roles/ /etc/ansible/roles/
cp -r /vagrant/ansible/roles /home/vagrant/.ansible/
cp -r /vagrant/ansible/roles /root/.ansible/
```

Копируем Playbook и inventory файлы, для запуска роли, передачи переменной с портом nginx и указанием хостов из inventory

```
cp /vagrant/ansible/playbook.yml /home/vagrant/playbook.yml
cp /vagrant/ansible/inventory.yml /home/vagrant/.ansible/inventory.yml
```

В рамках сессии отключаем у ansible проверку на наличие ключей в known_hosts и добавляем отпечаток хоста web в known_hosts

```
ssh-keyscan -H web >> ~/.ssh/known_hosts
```

Теперь, на другом хосте web, добавляем публичный ключ ssh, чтобы хост ansible мог корректно подключиться

```
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQulD+SK4ggadzuJZdksaB7VVAXzDbeYHkd41savMnzxLiVXW4SFUXlBx4c1B8J4thzlgH/dXiDKgyPsjPPiHJaao446jJrJxBT/VATUg+MEYY48qUifCg9cTffAis512MhyvCGInfU2B/FMCz8zF9P0sDp+NoHWOCamawJ+B2Sk3r9VgtS30l34WTDBINbcqtlEq1IKTWHHLuDw84bRLHBF4x8bn6REYjb+UF98zHlhV539iikHjZSqQa1KHnp+1Ew9IY1WoUDukjwuAa6YGkWjO1ughAlZ4xpzgp1coOp+C0tTTI4V45soO2V2fG1xXIBqGteYv/oBDDZfQ6kj3z" >> /home/vagrant/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQulD+SK4ggadzuJZdksaB7VVAXzDbeYHkd41savMnzxLiVXW4SFUXlBx4c1B8J4thzlgH/dXiDKgyPsjPPiHJaao446jJrJxBT/VATUg+MEYY48qUifCg9cTffAis512MhyvCGInfU2B/FMCz8zF9P0sDp+NoHWOCamawJ+B2Sk3r9VgtS30l34WTDBINbcqtlEq1IKTWHHLuDw84bRLHBF4x8bn6REYjb+UF98zHlhV539iikHjZSqQa1KHnp+1Ew9IY1WoUDukjwuAa6YGkWjO1ughAlZ4xpzgp1coOp+C0tTTI4V45soO2V2fG1xXIBqGteYv/oBDDZfQ6kj3z" >> /root/.ssh/authorized_keys
```

Также заранее отключим службу firewalld, чтобы была возможность открыть страницу с nginx

```
sudo systemctl stop firewalld
```

Теперь возвращаемся на машину с ansible и запускаем Playbook для установки nginx на хост web

```
ansible-playbook /home/vagrant/playbook.yml  -i /home/vagrant/.ansible/inventory.yml
```

Вывод:

```
[WARNING]: Found both group and host with same name: web
    
PLAY [web] *********************************************************************
    
TASK [Gathering Facts] *********************************************************
ok: [web]
    
TASK [include_role : my-nginx] *************************************************
    
TASK [my-nginx : Add Nginx Repository] *****************************************
changed: [web]
    
TASK [my-nginx : Install Nginx] ************************************************
changed: [web]
    
TASK [my-nginx : Enable Nginx Service] *****************************************
changed: [web]
    
TASK [my-nginx : Add NGINX cofig] **********************************************
changed: [web]
    
TASK [my-nginx : Copy custom page] *********************************************
changed: [web]
    
RUNNING HANDLER [my-nginx : nginx start] ***************************************
changed: [web]
    
PLAY RECAP *********************************************************************
web    : ok=7    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

Для проверки открываем в браузере страницу http://192.168.11.102:8080

Данные шаги автоматизированы в vagrant

Описание файлов и роли.

Файлы запуска

Запуск роли осуществляется файлом Playbook, в котором перечисленны:
группа хостов
устанавливаемая роль
переменные

playbook.yml:
```
---
 - hosts: web
   become: true
   tasks:
   - include_role:
        name: my-nginx
     vars:
       port: 8080
```

В файл inventory, в котором перечисленны хосты и используемый ansible ssh пользователь

inventory.yml:
```
[web]
web ansible_user=vagrant
```

Каталог roles, в котором расположена роль ansible

Структура каталогов и файлов роли:

```
[root@ansible roles]# tree
.
└── roles
    └── my-nginx
        ├── files
        │   ├── index.html
        │   └── nginx.repo
        ├── handlers
        │   └── main.yml
        ├── meta
        │   └── main.yml
        ├── tasks
        │   └── main.yml
        ├── templates
        │   ├── default.conf
        │   └── nginx.conf
        └── vars
            └── main.yml

```

В каталоге files, расположеный файлы, которые будут скопированы на целевой хост.
В каталоге handlers,файл main.yml расположены команды обработчики, которые вызываются при запуске задач в данной роли. (В этом примере запуск сервиса nginx)
В каталоге meta,файл main.yml расположено описание зависимостей данной роли.
В каталоге tasks,файл main.yml расположены задачи, которые выполнит ansible на целевом хосте. (В этом примере установка / запуск nginx, запуск сервиса nginx, копирование конфигов)
В каталоге templates,файлы default.conf, nginx.conf расположены файлы шаблоны, которые копируются на хост и используют внутри переменные ansible, в формате {{ variable_name }} , которые используются при конфигурировании
В каталоге vars,файл main.yml, расположено описание переменных и их значение по умолчанию. (в данном примере порт на котором слушает nginx)

