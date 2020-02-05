# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Linux net tools** - сетевые утилиты Linux



Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson20** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

в Office1 в тестовой подсети появляется сервера с доп интерфесами и адресами
в internal сети testLAN
- testClient1 - 10.10.10.254
- testClient2 - 10.10.10.254
- testServer1- 10.10.10.1
- testServer2- 10.10.10.1

равести вланами
testClient1 <-> testServer1
testClient2 <-> testServer2

между centralRouter и inetRouter
"пробросить" 2 линка (общая inernal сеть) и объединить их в бонд
проверить работу c отключением интерфейсов

для сдачи - вагрант файл с требуемой конфигурацией
Разворачиваться конфигурация должна через ансибл




Используемые файлы и директории:
- В директории lesson20 расположен Vagrantfile с образом Centos 6/7 и автоматическими шагами развертывания



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
cd otus-linux/lesson20
vagrant up 
```

Далее зайдите на машину office1Router и выполните ansible playbook-и:

```
vagrant ssh office1Router
sudo -i
ansible-playbook /home/vagrant/vlan-playbook.yml  -i /home/vagrant/.ansible/inventory.yml
ansible-playbook /home/vagrant/bond-playbook.yml  -i /home/vagrant/.ansible/inventory.yml

```

Данные playbook-и создадум Vlan-ы и построят bond между серверами centralRouter и inetRouter

Проверить можно подключившись к centralRouter и выполнив ping:

```
vagrant ssh centralRouter

[root@centralRouter ~]# ping 10.10.11.2
PING 10.10.11.2 (10.10.11.2) 56(84) bytes of data.
64 bytes from 10.10.11.2: icmp_seq=1 ttl=64 time=1.41 ms
64 bytes from 10.10.11.2: icmp_seq=2 ttl=64 time=0.294 ms
64 bytes from 10.10.11.2: icmp_seq=3 ttl=64 time=0.284 ms
64 bytes from 10.10.11.2: icmp_seq=4 ttl=64 time=0.617 ms
64 bytes from 10.10.11.2: icmp_seq=5 ttl=64 time=0.300 ms
^C
--- 10.10.11.2 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4003ms
rtt min/avg/max/mdev = 0.284/0.581/1.413/0.435 ms

```

Проверить vlan можно подключившись к TestServer1 и выполнив ping:

```
vagrant ssh TestServer1


[root@TestServer1 ~]# ping 10.10.10.254
PING 10.10.10.254 (10.10.10.254) 56(84) bytes of data.
64 bytes from 10.10.10.254: icmp_seq=1 ttl=64 time=1.17 ms
64 bytes from 10.10.10.254: icmp_seq=2 ttl=64 time=0.296 ms
64 bytes from 10.10.10.254: icmp_seq=3 ttl=64 time=0.305 ms
64 bytes from 10.10.10.254: icmp_seq=4 ttl=64 time=0.293 ms
64 bytes from 10.10.10.254: icmp_seq=5 ttl=64 time=0.296 ms
^C
--- 10.10.10.254 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4003ms
rtt min/avg/max/mdev = 0.293/0.472/1.171/0.349 ms

```

Тоже самое делаем по аналогии с TestServer2

Выводы playbook:

```
[root@office1Router ~]# ansible-playbook /home/vagrant/bond-playbook.yml  -i /home/vagrant/.ansible/inventory.yml

PLAY [serversbond] ************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************

ok: [inetRouter]

ok: [centralRouter]

TASK [include_role : bonds] ***************************************************************************************************************************************************************************************************************************************************

TASK [bonds : Copy interface config 1] ****************************************************************************************************************************************************************************************************************************************
changed: [centralRouter]
changed: [inetRouter]

TASK [bonds : Copy interface config 2] ****************************************************************************************************************************************************************************************************************************************
changed: [centralRouter]
changed: [inetRouter]

TASK [bonds : Copy interface config 1] ****************************************************************************************************************************************************************************************************************************************
changed: [centralRouter]
changed: [inetRouter]

TASK [bonds : Copy BOND interface config] *************************************************************************************************************************************************************************************************************************************
changed: [centralRouter]
changed: [inetRouter]

RUNNING HANDLER [bonds : network restart] *************************************************************************************************************************************************************************************************************************************
changed: [centralRouter]
changed: [inetRouter]

PLAY RECAP ********************************************************************************************************************************************************************************************************************************************************************
centralRouter              : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
inetRouter                 : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

```
[root@office1Router ~]# ansible-playbook /home/vagrant/vlan-playbook.yml  -i /home/vagrant/.ansible/inventory.yml

PLAY [servers] ****************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************************************************************
ok: [TestServer1]
ok: [TestClient1]
ok: [TestServer2]
ok: [TestClient2]

TASK [include_role : vlans] ***************************************************************************************************************************************************************************************************************************************************

TASK [vlans : Copy interface config] ******************************************************************************************************************************************************************************************************************************************
changed: [TestServer2]
changed: [TestClient1]
changed: [TestClient2]
changed: [TestServer1]

TASK [vlans : Copy VLAN interface config] *************************************************************************************************************************************************************************************************************************************
changed: [TestServer1]
changed: [TestClient1]
changed: [TestServer2]
changed: [TestClient2]

RUNNING HANDLER [vlans : network restart] *************************************************************************************************************************************************************************************************************************************
changed: [TestServer1]
changed: [TestClient1]
changed: [TestServer2]
changed: [TestClient2]

PLAY RECAP ********************************************************************************************************************************************************************************************************************************************************************
TestClient1                : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
TestClient2                : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
TestServer1                : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
TestServer2                : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

