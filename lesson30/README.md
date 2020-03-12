# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Postfix** - Почтовый сервер
- **Dovecot** - IMAP и POP3-сервер



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson30** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

установка почтового сервера
1. Установить в виртуалке postfix+dovecot для приёма почты на виртуальный домен любым обсужденным на семинаре способом
2. Отправить почту телнетом с хоста на виртуалку
3. Принять почту на хост почтовым клиентом

Результат
1. Полученное письмо со всеми заголовками
2. Конфиги postfix и dovecot



Используемые файлы и директории:
- В директории lesson30 расположен Vagrantfile с образами Centos 7 и автоматическими шагами развертывания


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
cd otus-linux/lesson30
vagrant up 
```

Подключитесь по ssh к клиентской машине и запустите почтовый клиент mutt, при подключении вы увидите ранее отправленное письмо:

```
vagrant ssh mailclient

sudo -i 

mutt
```

![inbox in mutt](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson30/mutt1.png)

![email in mutt](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson30/mutt2.png)


Письмо со всеми заголовками можно посмотреть в домашнем каталоге пользователя postfixtester, на сервере postfix

```
vagrant ssh postfix

sudo -i 

[root@postfix ~]# cat /home/postfixtester/Maildir/cur/1584015209.Vfd02I8010c42M457074.postfix\:2\,S
Return-Path: <admin@test.local>
X-Original-To: postfixtester
Delivered-To: postfixtester@test.local
Received: from 192.168.11.102 (unknown [192.168.11.103])
        by mail.test.local (Postfix) with ESMTP id 5B9D32ED2
        for <postfixtester>; Fri, 13 Mar 2020 01:13:29 +1300 (NZDT)

test admin mail

```

# Описание выполнения данного задания

Устанавливаем связку Postfix - MTA + LDA, Dovecot - MDA

Устанавливаем необходимые пакеты:

```
yum install epel-release wget -y
yum install postfix -y
alternatives --set mta /usr/sbin//root/sendmail.postfix
yum install dovecot -y
yum install telnet mutt nc -y
```

Для упрощения отключаем firewall:

```
systemctl stop firewalld
```

Настраиваем Postfix для домена test.local, редактируем файл /etc/postfix/main.cf

```
myhostname = mail.test.local
mydomain = test.local
myorigin = $mydomain
inet_interfaces = all
mydestination = $myhostname, localhost, $mydomain
mynetworks = 127.0.0.0/8, 192.168.11.0/24
relay_domains = $mydestination
home_mailbox = Maildir/
alias_maps = hash:/etc/aliases
virtual_mailbox_domains = test.local
virtual_transport = dovecot
```

Настраиваем dovecot , редактируем файл /etc/dovecot/dovecot.conf:

```
mail_location = maildir:~/Maildir

protocols = imap

passdb {
  driver = pam
  args = failure_show_msg=yes  
#args = session=yes dovecot
}

userdb {
  driver = passwd
}


ssl_protocols = !SSLv2 !SSLv3 !TLSv1
ssl_cipher_list = HIGH:!SSLv2:!SSLv3:!TLSv1.0:!aNULL:!MD5

auth_mechanisms = plain login
auth_debug=yes
auth_debug_passwords=yes

disable_plaintext_auth = no
ssl=yes



auth default {
  mechanisms = plain login
  passdb pam {
# If service name is "*", it means the authenticating service name is used, eg. pop3 or imap (/etc/pam.d/pop3, /etc/pam.d/imap)
  args = "*"
  }
  
userdb passwd {
  #args = /etc/passwd
  driver = passwd
  } 

}


service auth-worker {
  user = $default_internal_user
}
service auth {
  unix_listener /var/spool/postfix/private/auth {
    mode = 0660
    user = postfix
  }
}
```

В данном случае для авторизации пользователей используется PAM, поэтому настроим его:

файл /etc/pam.d/imap

```
#%PAM-1.0
auth    required        pam_unix.so nullok
account required        pam_unix.so
auth       required     pam_shells.so
auth       include      system-auth
account    include      system-auth
session    include      system-auth
```

файл /etc/pam.d/dovecot

```
#%PAM-1.0
auth required pam_listfile.so onerr=fail item=group sense=allow file=/etc/pam.d/mail_auth_group.allow
auth    required        pam_unix.so nullok
account required        pam_unix.so
```



Создаем тестового юзера, от которого будем отправлять email и получать почту:

```
useradd postfixtester
echo -n "RooTqwerty123\nRooTqwerty123" | passwd postfixtester
```

Запускаем сервисы:

```
systemctl start postfix
systemctl start dovecot
```

Теперь, для проверки настроим почтовый клиент mutt, создаем файл ~/.muttrc

```
set from = "postfixtester@test.local"
set realname = "postfixtester"

set smtp_url = "smtp://192.168.11.102:25/"

set ssl_starttls=no
set ssl_force_tls=no

set spoolfile=imap://postfixtester:RooTqwerty123@192.168.11.102/
set folder=imap://postfixtester123:RooTqwerty123@192.168.11.102/
```

Теперь отправим письмо через утилиту telnet:

```
telnet 192.168.11.102 smtp
ehlo 192.168.11.102
mail from:admin@test.local
rcpt to:<postfixtester>
data
test admin mail
.
```

Откроем потчовый клиент mutt, в нем будет наше письмо:

![inbox in mutt](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson30/mutt1.png)

![email in mutt](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson30/mutt2.png)


Письмо со всеми заголовками можно посмотреть в домашнем каталоге пользователя postfixtester, на сервере postfix

```
[root@postfix ~]# cat /home/postfixtester/Maildir/cur/1584015209.Vfd02I8010c42M457074.postfix\:2\,S
Return-Path: <admin@test.local>
X-Original-To: postfixtester
Delivered-To: postfixtester@test.local
Received: from 192.168.11.102 (unknown [192.168.11.103])
        by mail.test.local (Postfix) with ESMTP id 5B9D32ED2
        for <postfixtester>; Fri, 13 Mar 2020 01:13:29 +1300 (NZDT)

test admin mail

```

Разумеется этот пример - тестовый стенд, в Prod среде должны быть настроены правила firewall, ssl на интерфейсах, авторизация через БД/LDAP кластер, корректно настроены DNS, DMARC,DKIM