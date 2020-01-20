# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **ELK стек** - стек Elastic search, Kibana, Logstach - инструменты используемые для сбора логов и статистики


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson17** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

Настраиваем центральный сервер для сбора логов
в вагранте поднимаем 2 машины web и log
на web поднимаем nginx
на log настраиваем центральный лог сервер на любой системе на выбор
- journald
- rsyslog
- elk
настраиваем аудит следящий за изменением конфигов нжинкса

все критичные логи с web должны собираться и локально и удаленно
все логи с nginx должны уходить на удаленный сервер (локально только критичные)
логи аудита должны также уходить на удаленную систему


* развернуть еще машину elk
и таким образом настроить 2 центральных лог системы elk И какую либо еще
в elk должны уходить только логи нжинкса
во вторую систему все остальное 




Используемые файлы и директории:
- В директории lesson17 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания


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
cd otus-linux/lesson17
vagrant up 
vagrant ssh
```

Откройте следующие страницы в браузере для проверки:

```
http://192.168.11.101:5601/
http://192.168.11.102:5601/
```

# Описание выполнения данного задания.

Устанавливаем ELK стек на сервера elknginx и elksys

Устанавливаем репозитории EPEL,ELK и необходимые пакеты:

```
yum install epel-release -y
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cp /vagrant/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
yum install --enablerepo=elasticsearch elasticsearch -y
```

Выполняем настройку интефрейсов в конфиг файлах elasticsearch, чтобы у нас была возможность подключаться по внешнему ip адресу:

```
vi /etc/elasticsearch/elasticsearch.yml
network.host: 192.168.11.101
discovery.seed_hosts: ["192.168.11.101"]
```

Запускаем elasticsearch

```
systemctl start elasticsearch
systemctl enable elasticsearch
```

Устанавливаем Kibana:

```
yum install --enablerepo=elasticsearch kibana -y
```

Конфигурируем внешний адрес и подключение к elasticsearch в конфиге kibana:

```
vi  /etc/kibana/kibana.yml

server.host: "0.0.0.0"
elasticsearch.hosts: ["http://192.168.11.101:9200"]
```

Запускаем Kibana:

```
systemctl enable kibana
systemctl start kibana
```

Установим logstash:

Ставим java
```
yum install java-11-openjdk-devel -y
```
Ставим logstash

```
yum install --enablerepo=elasticsearch logstash -y
```

Копируем заранее подготовленные конфиги:

```
cp -f /vagrant/02-beats-input.conf /etc/logstash/conf.d/02-beats-input.conf
cp -f /vagrant/10-syslog-filter.conf /etc/logstash/conf.d/10-syslog-filter.conf
cp -f /vagrant/30-elasticsearch-output-nginx.conf /etc/logstash/conf.d/30-elasticsearch-output.conf
```

Запускаем logstash:

```
systemctl start logstash
systemctl enable logstash
```

На этом этапе у нас есть 2 сервера с ELK.
elknginx - под логи nginx
elksys - под логи системы и аудита

Теперь переходим к установке клиента, с которого будем собирать логи:

Включаем аудит каталога с конфигами nginx

```
auditctl -a exit,always -F path=/etc/nginx -F perm=wa
```

Добавляем репозиторий elk и устанавливаем агент filebeat

```
cp /vagrant/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
yum install --enablerepo=elasticsearch filebeat -y
```

Теперь скопируем сервис 

```
cp -f /vagrant/filebeat.service /etc/systemd/system/filebeat.service
```

Скопируем конфиги filebeat, с настройками отправки логов nginx в elk:

```
cp -rf /vagrant/filebeat /etc/filebeat
```

Теперь создадим вторую службу filebeat, которая будет отправлять системные логи во второй сервер elasticsearch:

```
cp -f /vagrant/filebeat-sys.service /etc/systemd/system/filebeat-sys.service
cp -rf /vagrant/filebeat2 /etc/filebeat2
cp -r /var/lib/filebeat /var/lib/filebeat2
mkdir /var/log/filebeat2
```

Запускаем обе службы:

```
systemctl start filebeat
systemctl start filebeat-sys
```

На этом этапе логи успешно отправляются в elasticsearch