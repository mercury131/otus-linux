# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **InfluxDB** - timescale база данных
- **Telegraf** - система сбора и отправки метрик
- **Prometheus** - система мониторинга
- **Grafana** - система визуализации метрик


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson13** - ссылка на данное домашнее задание


 


В рамках данного домашнего задания выполнено:

- 1) С помощью Grafana настроен дашборд с 4-мя графиками (процессор, память, диски, сеть)
- 2) Установлена система мониторинга Prometheus, в которую настроен сбор метрик
- 3) Установлена InfluxDB, в которую настроен сбор метрик
- 4) Процесс автоматизирован с помощью vagrantfile




Используемые файлы и директории:
- В директории lesson13 расположен Vagrantfile с образом Centos 7 и автоматическими шагами развертывания:



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
cd otus-linux/lesson13
vagrant up 
vagrant ssh
```

Откройте следующие страницы в браузере для проверки:

```
http://192.168.11.101:3000/
```

Авторизуйтесь в Grafana с помощью стандартного логина и пароля admin/admin

Откройте дашборды Prometheus и Influx

Добавленные datasources
![Datasources](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson13/datasources.PNG)

Дашборд InfluxDB
![Influx dashboard](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson13/influx.PNG)

Дашборд Prometheus
![Prometheus dashboard](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson13/prometheus.PNG)

# Описание выполнения данного задания.

Установка Prometheus.

Отключаем SElinux

```
setenforce 0
```

Загружаем Prometheus

```
wget https://github.com/prometheus/prometheus/releases/download/v2.15.1/prometheus-2.15.1.linux-amd64.tar.gz
```

Создаем пользователя для Prometheus , создаем каталоги, корерктируем права доступа, распаковываем Prometheus и копируем в систему и импортируем конфиг

```
useradd --no-create-home --shell /bin/false prometheus
mkdir /etc/prometheus
mkdir /var/lib/prometheus
chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus
tar -xvzf prometheus-2.15.1.linux-amd64.tar.gz
mv prometheus-2.15.1.linux-amd64 prometheuspackage
cp prometheuspackage/prometheus /usr/local/bin/
cp prometheuspackage/promtool /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool
cp -r prometheuspackage/consoles /etc/prometheus
cp -r prometheuspackage/console_libraries /etc/prometheus
chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries
cp /vagrant/prometheus.yml /etc/prometheus/prometheus.yml
chown prometheus:prometheus /etc/prometheus/prometheus.yml
```

Конфиг Prometheus:

```
global:
  scrape_interval: 10s

scrape_configs:
  - job_name: 'prometheus_master'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter_centos'
    scrape_interval: 5s
    static_configs:
      - targets: ['192.168.11.101:9100']
```

Копируем systemd юнит для prometheus и запускаем его, также отключим firewall, чтобы открыть порты (Внимание, на PROD окружении так делать нельзя, необходимо создавать отдельные правила)

```
cp -f /vagrant/prometheus.service /etc/systemd/system/prometheus.service
systemctl daemon-reload
systemctl start prometheus
systemctl status prometheus
systemctl stop firewalld
systemctl disable firewalld
```

Теперь Prometheus доступен по ссылке - http://192.168.11.101:9090/graph

Переходим к установке node_exporter, который будет заливать метрики в prometheus

Загружаем архив с node_exporter, создаем для него пользователя, копируем в систему, создаем systemd юнит:

```
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar -xvzf node_exporter-0.18.1.linux-amd64.tar.gz
useradd -rs /bin/false nodeusr
mv node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin/
cp /vagrant/node_exporter.service /etc/systemd/system/node_exporter.service
systemctl daemon-reload
systemctl start node_exporter
```

Node exporter доступен по ссылке - http://192.168.11.101:9100/metrics

Таргеты Prometheus доступны по ссылке - http://192.168.11.101:9090/targets

Графики в prometheus можно построить по ссылке - http://192.168.11.101:9090/graph


Установка связки Influx / Telegraf / Grafana

Добавляем репозиторий Grafana

```
cp /vagrant/grafana.repo /etc/yum.repos.d/grafana.repo
```

Устанавливаем и запускаем Grafana

```
yum install grafana -y
systemctl start grafana-server
```

Добавляем репозиторий InfluxDB

```
cp /vagrant/influxdb.repo /etc/yum.repos.d/influxdb.repo
```

Устанавливаем InfluxDB и Telegraf:

```
cp /vagrant/influxdb.repo /etc/yum.repos.d/influxdb.repo
yum install influxdb telegraf -y
```

Заменяем конфиг telegraf

```
cp /vagrant/telegraf.conf /etc/telegraf/telegraf.conf
```

Запускаем сервисы InfluxDB и Telegraf:

```
systemctl start influxdb
systemctl start telegraf
```

На этом этапе метрики системы уже собираются в InfluxDB, теперь перейдем к настройке Grafana.

Создаем каталог для импорта дашбордов:

```
mkdir /var/lib/grafana/dashboards
```

Копируем дашборды:

```
cp /vagrant/Prometheus.json /var/lib/grafana/dashboards/
cp /vagrant/Influx.json /var/lib/grafana/dashboards/
```

Копируем конфигурации datasources, в которых указаны подключения к Prometheus и InfluxDB и конфиг для импорта дашбордов

```
cp /vagrant/Prometheus-db.yaml /etc/grafana/provisioning/dashboards/
cp /vagrant/datasources.yaml /etc/grafana/provisioning/datasources/
```

Скопируем конфиг Grafana, в котором активирован provisioning:

```
mv /etc/grafana/grafana.ini /etc/grafana/grafana.ini.bak
cp /vagrant/grafana.ini /etc/grafana/grafana.ini
```

Перезапускаем Grafana

```
systemctl restart grafana-server
```

Теперь можно перейти по ссылке http://192.168.11.101:3000/

Авторизуйтесь в Grafana с помощью стандартного логина и пароля admin/admin

В папке Monitoring будут доступны импортированные дашборды:

Добавленные datasources
![Datasources](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson13/datasources.PNG)

Дашборд InfluxDB
![Influx dashboard](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson13/influx.PNG)

Дашборд Prometheus
![Prometheus dashboard](https://raw.githubusercontent.com/mercury131/otus-linux/master/lesson13/prometheus.PNG)