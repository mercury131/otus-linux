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
ping 10.10.11.2
```

Проверить vlan можно подключившись к TestServer1 и выполнив ping:

```
vagrant ssh TestServer1
ping 10.10.10.254
```

Тоже самое делаем по аналогии с TestServer2