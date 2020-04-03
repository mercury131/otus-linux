# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Ansible** - система управления конфигурациями
- **FreeIPA** - централизованная система по управлению идентификацией пользователей
- **nfs** - Network File System — протокол сетевого доступа к файловым системам


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson36** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

Vagrant стенд для NFS или SAMBA
NFS или SAMBA на выбор:

vagrant up должен поднимать 2 виртуалки: сервер и клиент
на сервер должна быть расшарена директория
на клиента она должна автоматически монтироваться при старте (fstab или autofs)
в шаре должна быть папка upload с правами на запись
- требования для NFS: NFSv3 по UDP, включенный firewall

* Настроить аутентификацию через KERBEROS 




Используемые файлы и директории:
- В директории lesson36 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания
- В директории lesson36/ansible , расположены playbook, inventory файл и роль по вводу в домен freeipa

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
cd otus-linux/lesson36
vagrant up 
vagrant ssh ipa
```

Авторизуйтесь под root и запустите playbook для ввода клиента в домен:

```
sudo -i 
ansible-playbook /home/vagrant/install-client.yml  -i /home/vagrant/.ansible/hosts
```

После выполнения playbook, авторизуйтесь на клиенте по ssh:

```
vagrant ssh client
sudo -i
```

Получаем kerberos тикет (пароль superadmin123):

```
[root@client ~]# kinit admin
Password for admin@DOMAIN.LOCAL:
[root@client ~]# klist
Ticket cache: KEYRING:persistent:0:0
Default principal: admin@DOMAIN.LOCAL

Valid starting     Expires            Service principal
04/04/20 04:21:10  05/04/20 03:21:03  krbtgt/DOMAIN.LOCAL@DOMAIN.LOCAL


```

Выполняем монтирование nfs шары:

```
systemctl start nfs-secure
[root@client ~]# touch /mnt/nfsshare/test

[root@client ~]# df -h
Filesystem                         Size  Used Avail Use% Mounted on
devtmpfs                           3.9G     0  3.9G   0% /dev
tmpfs                              3.9G     0  3.9G   0% /dev/shm
tmpfs                              3.9G  8.6M  3.9G   1% /run
tmpfs                              3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/mapper/centos_centoslvm-root   50G  1.7G   49G   4% /
/dev/mapper/centos_centoslvm-home   67G   33M   67G   1% /home
/dev/sda1                         1014M  175M  840M  18% /boot
vagrant                            279G   81G  198G  29% /vagrant
tmpfs                              783M     0  783M   0% /run/user/0
tmpfs                              783M     0  783M   0% /run/user/1000
ipa.domain.local:/upload            50G  2.3G   48G   5% /mnt/nfsshare

[root@client ~]# ls /mnt/nfsshare/test
/mnt/nfsshare/test
[root@client ~]#

[root@client ~]# mount | grep nfs | grep ipa
ipa.domain.local:/upload on /mnt/nfsshare type nfs4 (rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5p,clientaddr=192.168.11.102,local_lock=none,addr=192.168.11.101,_netdev)

```
