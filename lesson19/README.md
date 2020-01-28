# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Ansible** - система управления конфигурациями
- **FreeIPA** - централизованная система по управлению идентификацией пользователей


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson19** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

1. Установить FreeIPA;
2. Написать Ansible playbook для конфигурации клиента;
3*. Настроить аутентификацию по SSH-ключам;
4**. Firewall должен быть включен на сервере и на клиенте.

В git - результирующий playbook. 




Используемые файлы и директории:
- В директории lesson19 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания
- В директории lesson19/ansible , расположены playbook, inventory файл и роль по вводу в домен freeipa

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
cd otus-linux/lesson19
vagrant up 
vagrant ssh ipa
```

Авторизуйтесь под root и запустите playbook:

```
sudo -i 
ansible-playbook /home/vagrant/install-client.yml  -i /home/vagrant/.ansible/hosts
```

После выполнения playbook, можно авторизоваться по ssh, на клиенте, с помощью доменной учетной записи testuser
При первом логине потребутся изменить пароль пользователя

```
[root@domain ~]# ssh testuser@client
Password:
Password expired. Change your password now.
Current Password:
New password:
Retype new password:
Creating home directory for testuser.
[testuser@client ~]$ pwd
/home/testuser
[testuser@client ~]$
```



# Описание выполнения данного задания.

Устанавливаем необходимые пакеты:

```
yum install ansible vim -y
yum update nss -y
yum install ipa-server ipa-server-dns -y
```
Если не обновить пакет nss, freeipa не установится корректно

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

Прописываем корректные адреса в hosts

```
echo " 127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 " > /etc/hosts
echo " ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
echo "192.168.11.102  client.domain.local client" >> /etc/hosts
echo "192.168.11.101  ipa.domain.local ipa domain.local" >> /etc/hosts
```

Включаем правила Firewall для freeIPA

```
firewall-cmd --permanent --add-service=ntp
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --permanent --add-service=ldap
firewall-cmd --permanent --add-service=ldaps
firewall-cmd --permanent --add-service=kerberos
firewall-cmd --permanent --add-service=kpasswd
firewall-cmd --permanent --add-service=dns
firewall-cmd --reload
```

Создаем структуру каталогов для Ansible и копируем роль для установки nginx в необходимые директории:
Роль копируем в домашние каталоги, для удобства при дебаге.
```
mkdir ~/ansible
mkdir -p /etc/ansible/roles/ && mkdir -p /home/vagrant/.ansible/roles/ && mkdir -p /root/.ansible/roles/
cp -r /vagrant/roles/* /etc/ansible/roles/ && cp -r /vagrant/roles /home/vagrant/.ansible/ && cp -r /vagrant/roles /root/.ansible/roles/
```

Копируем Playbook и inventory файлы, для запуска роли, передачи переменной с портом nginx и указанием хостов из inventory

```
cp /vagrant/install-client.yml /home/vagrant/install-client.yml
cp /vagrant/hosts /home/vagrant/.ansible/hosts
```

В рамках сессии отключаем у ansible проверку на наличие ключей в known_hosts и добавляем отпечаток хоста web в known_hosts

```
ssh-keyscan -H web >> ~/.ssh/known_hosts
```

Теперь, на другом хосте, добавляем публичный ключ ssh, чтобы хост ansible мог корректно подключиться

```
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQulD+SK4ggadzuJZdksaB7VVAXzDbeYHkd41savMnzxLiVXW4SFUXlBx4c1B8J4thzlgH/dXiDKgyPsjPPiHJaao446jJrJxBT/VATUg+MEYY48qUifCg9cTffAis512MhyvCGInfU2B/FMCz8zF9P0sDp+NoHWOCamawJ+B2Sk3r9VgtS30l34WTDBINbcqtlEq1IKTWHHLuDw84bRLHBF4x8bn6REYjb+UF98zHlhV539iikHjZSqQa1KHnp+1Ew9IY1WoUDukjwuAa6YGkWjO1ughAlZ4xpzgp1coOp+C0tTTI4V45soO2V2fG1xXIBqGteYv/oBDDZfQ6kj3z" >> /home/vagrant/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQulD+SK4ggadzuJZdksaB7VVAXzDbeYHkd41savMnzxLiVXW4SFUXlBx4c1B8J4thzlgH/dXiDKgyPsjPPiHJaao446jJrJxBT/VATUg+MEYY48qUifCg9cTffAis512MhyvCGInfU2B/FMCz8zF9P0sDp+NoHWOCamawJ+B2Sk3r9VgtS30l34WTDBINbcqtlEq1IKTWHHLuDw84bRLHBF4x8bn6REYjb+UF98zHlhV539iikHjZSqQa1KHnp+1Ew9IY1WoUDukjwuAa6YGkWjO1ughAlZ4xpzgp1coOp+C0tTTI4V45soO2V2fG1xXIBqGteYv/oBDDZfQ6kj3z" >> /root/.ssh/authorized_keys
```

Также настроим службу firewalld

```
firewall-cmd --permanent --add-service=dns
firewall-cmd --permanent --add-service=ssh
firewall-cmd --reload
```

Теперь сконфигурируем домен на машине ipa

```
ipa-server-install
```

Используемые входные аргументы параметры:

```
yes
ipa.domain.local
domain.local
DOMAIN.LOCAL
superadmin123
superadmin123
superadmin123
superadmin123
yes
yes
no
yes

```

После установки получаем Kerberos тикет

```
echo -e "superadmin123" | kinit admin
```

Создаем тестовую учетную запись:

```
echo -e " testuser123" | ipa user-add testuser  --first=Test --last=User --email=test@domain.local  --shell=/bin/bash --password
```

Создаем DNS A запись клиента 

```
ipa dnsrecord-add domain.local client --a-rec 192.168.11.102
```


Теперь переходим на клиента, и запускаем установку клиента freeIPA:

```
yum update -y
yum -y install freeipa-client ipa-admintools
```

Возвращаемся на FreeIPA сервер - ipa и запускаем под root, ansible playbook:

```
sudo -i
ansible-playbook /home/vagrant/install-client.yml  -i /home/vagrant/.ansible/hosts
```

В результате машина client будет введена в домен domain.local , развернутый в freeIPA

```
[vagrant@domain ~]$ sudo -i
[root@domain ~]# ansible-playbook /home/vagrant/install-client.yml  -i /home/vagrant/.ansible/hosts

PLAY [Playbook to configure IPA clients with username/password] ***************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************
The authenticity of host 'client.domain.local (<no hostip for proxy command>)' can't be established.
ECDSA key fingerprint is SHA256:Hp1hLVWEE6vqDrQeIXbXORGAyjB22R4UJ0OUnXFCo/E.
ECDSA key fingerprint is MD5:7b:d2:d1:b3:4a:1f:49:34:a9:5f:92:2a:90:58:fe:23.
Are you sure you want to continue connecting (yes/no)? yes
ok: [client.domain.local]

TASK [ipaclient : Import variables specific to distribution] ******************************************************************************************************************************************************************************************************************
ok: [client.domain.local] => (item=/etc/ansible/roles/ipaclient/vars/CentOS-7.yml)

TASK [ipaclient : Install IPA client] *****************************************************************************************************************************************************************************************************************************************
included: /etc/ansible/roles/ipaclient/tasks/install.yml for client.domain.local

TASK [ipaclient : Install - Ensure that IPA client packages are installed] ****************************************************************************************************************************************************************************************************
ok: [client.domain.local]

TASK [ipaclient : Install - Set ipaclient_servers] ****************************************************************************************************************************************************************************************************************************
ok: [client.domain.local]

TASK [ipaclient : Install - Set ipaclient_servers from cluster inventory] *****************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Check that either principal or keytab is set] *****************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Set default principal if no keytab is given] ******************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - IPA client test] **********************************************************************************************************************************************************************************************************************************
ok: [client.domain.local]

TASK [ipaclient : Install - Cleanup leftover ccache] **************************************************************************************************************************************************************************************************************************
ok: [client.domain.local]

TASK [ipaclient : Install - Configure NTP] ************************************************************************************************************************************************************************************************************************************
 [WARNING]: Unable to sync time with NTP server, assuming the time is in sync. Please check that 123 UDP port is opened.

ok: [client.domain.local]

TASK [ipaclient : Install - Make sure One-Time Password is enabled if it's already defined] ***********************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Disable One-Time Password for on_master] **********************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Test if IPA client has working krb5.keytab] *******************************************************************************************************************************************************************************************************
ok: [client.domain.local]

TASK [ipaclient : Install - Disable One-Time Password for client with working krb5.keytab] ************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Keytab or password is required for getting otp] ***************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Get One-Time Password for client enrollment] ******************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Report error for OTP generation] ******************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Store the previously obtained OTP] ****************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Store predefined OTP in admin_password] *********************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Check if principal and keytab are set] ************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Check if one of password or keytabs are set] ******************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Purge DOMAIN.LOCAL from host keytab] **************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - Backup and set hostname] **************************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - Join IPA] *****************************************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : fail] *******************************************************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : fail] *******************************************************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : fail] *******************************************************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Configure IPA default.conf] ***********************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - Configure SSSD] ***********************************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - Configure krb5 for IPA realm] *********************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - IPA API calls for remaining enrollment parts] *****************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - Fix IPA ca] ***************************************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Create IPA NSS database] **************************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - Configure SSH and SSHD] ***************************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - Configure automount] ******************************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - Configure firefox] ********************************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Install - Configure NIS] ************************************************************************************************************************************************************************************************************************************
changed: [client.domain.local]

TASK [ipaclient : Install - Restore original admin password if overwritten by OTP] ********************************************************************************************************************************************************************************************
skipping: [client.domain.local]

TASK [ipaclient : Cleanup leftover ccache] ************************************************************************************************************************************************************************************************************************************
ok: [client.domain.local]

TASK [ipaclient : Uninstall IPA client] ***************************************************************************************************************************************************************************************************************************************
skipping: [client.domain.local]

PLAY RECAP ********************************************************************************************************************************************************************************************************************************************************************
client.domain.local        : ok=21   changed=11   unreachable=0    failed=0

```