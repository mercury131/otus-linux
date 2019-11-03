# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Packer** - система создания и упаковки образов


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson1** - ссылка на данное домашнее задание

В рамках данного домашнего задания выполнено:
- **Установка ядра из дополнительного репозитория** 
- **Сборка и установка ядра с kernel.org** 
- **Шаги автоматизированы в vagrantfile** 

Используемые файлы и директории:
- Во вложенной директории kernel-ml расположен Vagrantfile с шаблоном гостевой ОС Centos 7 с установленным ядром kernel-ml 5-й версии
- Во вложенной директории kernel-ml-auto расположен Vagrantfile с шаблоном гостевой ОС Centos 7 с прописанными шагами установки ядра kernel-ml 5-й версии и установкой Virtual Box  Guest Additions (не требуется кастомный образ)
- Во вложенной директории kernel-source расположен Vagrantfile с шаблоном гостевой ОС Centos 7 с ядром собранным с kernel.org, 5-й версии
- Во вложенной директории kernel-source-auto расположен Vagrantfile с шаблоном гостевой ОС Centos 7 с ядром собранным с kernel.org, 5-й версии, с прописанными шагами установки и сборки ядра (не требуется кастомный образ)


# Как проверить домашнее задание?

Склонируйте репозиторий:

```
git clone git@github.com:mercury131/otus-linux.git
```

Установите необходимые плагины для vagrant:

```
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-disksize
```

Для запуска VM с шаблоном гостевой ОС Centos 7 с установленным ядром kernel-ml 5-й версии выполните:

```
cd otus-linux/lesson1/kernel-ml/
vagrant up 
vagrant ssh
uname -r
```

Для запуска VM с шаблоном гостевой ОС Centos 7 с прописанными шагами установки ядра kernel-ml 5-й версии и установкой Virtual Box  Guest Additions (не требуется кастомный образ) выполните:

```
cd otus-linux/lesson1/kernel-ml-auto/
vagrant up 
vagrant ssh
uname -r
```

Для запуска VM с шаблоном гостевой ОС Centos 7 с ядром собранным с kernel.org, 5-й версии, с прописанными шагами установки и сборки ядра (не требуется кастомный образ) выполните:

```
cd otus-linux/lesson1/kernel-source/
vagrant up 
vagrant ssh
uname -r
```

Для запуска VM с шаблоном гостевой ОС Centos 7 с ядром собранным с kernel.org, 5-й версии выполните (Сборка ядра может занять очень много времени!):

```
cd otus-linux/lesson1/kernel-source-auto/
vagrant up 
vagrant ssh
uname -r
```


Описание выполнения данного задания.

Установка ядра из репозитория kernel-ml

Для запуска виртуального окружения необходимо запустить Vagrantfile из директории https://github.com/mercury131/otus-linux/tree/master/lesson1 
Это образ чистой Centos 7 . 

```
vagrant up 
```

Далее подключиться по ssh к виртуальной машине:

```
vagrant ssh clean_Centos
```

Проверяем текущую версию ядра:

```
uname -r 
```

Вывод:
```
3.10.0-957.12.2.el7.x86_64
```

Подключаем репозиторий для установки ядра kernel-ml 5-й версии

```
sudo yum install -y http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
```

Устанавливаем ядро kernel-ml последней доступной версии в репозитории
```
sudo yum --enablerepo elrepo-kernel install kernel-ml -y
```

После установки ядра, необходимо сконфигурировать загрузчик Grub2,чтобы при загрузке ОС использовалось новое ядро.

Выполняем обновление конфигурации загрузчика

```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

Выставляем загрузку нового ядра по умолчанию:

```
sudo grub2-set-default 0
```

Перезагружаем виртуальную машину и проверяем версию ядра:

```
sudo reboot
uname -r 
```

Вывод:
```
5.3.8-1.el7.elrepo.x86_64
```

Теперь перейдем к процедуре создания образа с уже установленным ml ядром с помощью утилиты Packer


Во вложенной директории kernel-ml, расположена директория packer, со следующими файлами:

- **centos-7-5-ml.json** - файл содержит описание создаваемого образа (параметры сборки)
- **scripts** - каталог содержит файлы для установки ядра ml и очистки образа для уменьшения размера при сборке через packer
- **http** - каталог содержит файл vagrant.ks с описанием процедуры установки ОС из скачанного образа

Переходим в директорию packer и запускаем процесс сборки

```
packer build centos-7-5-ml.json
```

Далее протестируем собранный образ с помощью Vagrant.

Импортируем образ в vagrant, имя образа указываем centos-7-5-ml

```
vagrant box add --name centos-7-5-ml centos-7.7.1908-kernel-5-x86_64-Minimal.box
```

Проверяем что импортированный образ появился в списке:

```
vagrant box list
```

Вывод:
```
centos-7-5-ml (virtualbox, 0)
centos/7      (virtualbox, 1905.1)
```

Теперь создадим папку test и инициализируем в ней новый vagrantfile

```
mkdir test
cd test
vagrant init centos-7-5-ml
```

Запускаем виртуальную машину и проверяем что образ содержит новое ядро

```
vagrant up
vagrant ssh  
```

Вывод:

```
5.3.8-1.el7.elrepo.x86_64
```

Удаляем виртуальную машину после проверки и ее образ из локального хранилища:

```
vagrant destroy
vagrant box remove centos-7-5-ml
```

Далее регистрируемся на Vagrant Cloud, для дальнейшей публикации образа.

Подключаемся к облаку:

```
vagrant cloud auth login
```

Теперь публикуем собранный ранее образ, делаем это из директории packer:

vagrant cloud publish --release mercury131/centos-7-5-ml 1.0 virtualbox \
        centos-7.7.1908-kernel-5-x86_64-Minimal.box
		
Вывод после успешной публикации:

```
Complete! Published mercury131/centos-7-5-ml
tag:             mercury131/centos-7-5-ml
username:        mercury131
name:            centos-7-5-ml
private:         false
downloads:       0
created_at:      2019-11-02T09:13:47.381Z
updated_at:      2019-11-02T09:18:42.452Z
current_version: 1.0
providers:       virtualbox
old_versions:    ...
```

Теперь подготовим vagrantfile для запуска данного образа, переходим в директорию otus-linux/lesson1/kernel-ml и выполняем:

```
vagrant init mercury131/centos-7-5-ml
vagrant up
```

Созданный образ успешно запущен. 

Теперь перейдем ко второй части, а именн к сборке ядра linux из исходников.

из директории запустим vagrantfile с чистой Centos 7 и подключимся к ней по ssh

```
vagrant up
vagrant ssh
```

Проверяем текущую версию ядра:

```
uname -r 
```

Вывод:
```
3.10.0-957.12.2.el7.x86_64
```

Установим пакеты необходимые для сборки:

```
sudo yum install ncurses-devel make gcc bc openssl-devel elfutils-libelf-devel rpm-build wget flex bison -y
```

Далее перейдем на https://www.kernel.org/ и выберем самую последнюю, стабильную версию ядра - 5.3.8

Возвращаемся в виртуальную машину и скачиваем исходники утилитой wget:

```
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.3.8.tar.xz
```

Распаковываем архив и переходим в каталог с ядром

```
tar xvf linux-5.3.8.tar.xz
cd linux-5.3.8
```

Далее копируем конфиг файл текущего ядра в каталог с исходниками нового ядра:

```
sudo cp -v /boot/config-`uname -r` .config
```

Запустим утилиту menuconfig, для включения/отключения модулей/опций ядра:

```
make menuconfig
```

в качестве примера я добавил поддержку raiserfs

Запускаем процесс компиляции ядра:

```
make rpm-pkg
```

После сборки ядра установим скомпилированное ядро, для этого установим полученные rpm пакеты:

```
sudo rpm -iUv ~/rpmbuild/RPMS/x86_64/*.rpm
```

Перезагружаемся после установки и проверяем используемую версию ядра:

```
sudo reboot
uname -r 
```

Вывод:

```
[vagrant@localhost ~]$ uname -r
5.3.8

```



Теперь перейдем к процедуре создания образа с уже собранным и установленным ядром linux с помощью утилиты Packer


Во вложенной директории kernel-source, расположена директория packer, со следующими файлами:

- **centos-7-5-src.json** - файл содержит описание создаваемого образа (параметры сборки)
- **scripts** - каталог содержит файлы для сборки и установки ядра Linux и очистки образа для уменьшения размера при сборке через packer
- **http** - каталог содержит файл vagrant.ks с описанием процедуры установки ОС из скачанного образа

Переходим в директорию packer и запускаем процесс сборки

```
packer build centos-7-5-src.json
```

Далее протестируем собранный образ с помощью Vagrant.

Импортируем образ в vagrant, имя образа указываем centos-7-5-src

```
vagrant box add --name centos-7-5-src centos-7.7.1908-src-kernel-5-x86_64-Minimal.box
```

Проверяем что импортированный образ появился в списке:

```
vagrant box list
```

Вывод:
```
centos-7-5-src (virtualbox, 0)
centos/7      (virtualbox, 1905.1)
```

Теперь создадим папку test и инициализируем в ней новый vagrantfile

```
mkdir test
cd test
vagrant init centos-7-5-src
```

Запускаем виртуальную машину и проверяем что образ содержит новое ядро

```
vagrant up
vagrant ssh  
uname -r 
```

Вывод:

```
[vagrant@localhost ~]$ uname -r
5.3.8

```

Удаляем виртуальную машину после проверки и ее образ из локального хранилища:

```
vagrant destroy
vagrant box remove centos-7-5-src
```

Далее регистрируемся на Vagrant Cloud, для дальнейшей публикации образа.

Подключаемся к облаку:

```
vagrant cloud auth login
```

Теперь публикуем собранный ранее образ, делаем это из директории packer:

vagrant cloud publish --release mercury131/centos-7-5-src 1.0 virtualbox \
        centos-7.7.1908-src-kernel-5-x86_64-Minimal.box
		
Вывод после успешной публикации:

```
Complete! Published mercury131/centos-7-5-src
tag:             mercury131/centos-7-5-src
username:        mercury131
name:            centos-7-5-src
private:         false
downloads:       0
created_at:      2019-11-03T08:35:29.589Z
updated_at:      2019-11-03T09:23:20.241Z
current_version: 1.0
providers:       virtualbox
old_versions:    ...

```

Теперь подготовим vagrantfile для запуска данного образа, переходим в директорию otus-linux/lesson1/kernel-source и выполняем:

```
vagrant init mercury131/centos-7-5-src
vagrant up
```

Созданный образ успешно запущен. 



Теперь подготовим Vagrant файлы для запуска базового образа Centos 7 с shell скриптами после запуска, это позволит использовать базовый образ ОС и кастомизировать ее после запуска.
Таким образом мы можем не использовать кастомные образы, которые создали ранее.

Создадим Vagrantfile для использования Centos c 5-й версией ядра ml.

Создаем каталог kernel-ml-auto т переходим в него:

```
cd ..
mkdir kernel-ml-auto
cd kernel-ml-auto
```

Инициализируем Vagrantfile с базовой Centos 7

vagrant init centos/7

Установим плагин vagrant reload, для повторной инициализации VM после перезагрузки:

```
vagrant plugin install vagrant-reload
```

теперь отредактируем vagrantfile, добавив изменение конфигурации VM (cpu/ram/name) и выполнение кастомных скриптов после запуска, в том числе установим Virtual Box  Guest Additions:

```
    config.vm.define "Centos7-5-ml-kernel"
    config.vm.provider :virtualbox do |vb|
        vb.name = "Centos7-5-ml-kernel"
	vb.cpus = "2"
	vb.memory = "2048"
    end

	config.vm.provision "shell", inline: <<-SHELL
		echo Start provisioning...
		# Install elrepo
		yum install -y http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
		# Install new kernel
		yum --enablerepo elrepo-kernel install kernel-ml kernel-ml-devel kernel-ml-headers -y
		# Remove older kernels
		rm -f /boot/*3.10*
		# Update GRUB
		grub2-mkconfig -o /boot/grub2/grub.cfg
		grub2-set-default 0
		echo "Grub update done."
		shutdown -r now
		# Reboot VM
		shutdown -r now
	 SHELL
	 
	 config.vm.provision :reload
	 
	 	config.vm.provision "shell", inline: <<-SHELL
		echo Start provisioning...
		echo "Install Virtual Box Guest Additions"
		VBOX_VERSION=6.0.14
		yum install elfutils-libelf-devel -y
		rpm -Uvh http://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/d/dkms-2.7.1-1.el7.noarch.rpm
		yum -y install --enablerepo elrepo-kernel  wget perl gcc dkms  make bzip2
		wget http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/VBoxGuestAdditions_${VBOX_VERSION}.iso
		mkdir /media/VBoxGuestAdditions
		mount -o loop,ro VBoxGuestAdditions_${VBOX_VERSION}.iso /media/VBoxGuestAdditions
		sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
		rm -f VBoxGuestAdditions_${VBOX_VERSION}.iso
		umount /media/VBoxGuestAdditions
		rmdir /media/VBoxGuestAdditions
		unset VBOX_VERSION
		# Reboot VM
		shutdown -r now
	 SHELL
```

Запускам виртуальную машину и проверяем версию ядра:

```
vagrant up
vagrant ssh
uname -r
```

Версия будет:

```
[vagrant@localhost ~]$ uname -r
5.3.8-1.el7.elrepo.x86_64
```

Проверяем запущенные VBoxGuestAdditions:

```
[vagrant@localhost ~]$ systemctl status vboxadd
● vboxadd.service
   Loaded: loaded (/opt/VBoxGuestAdditions-6.0.14/init/vboxadd; enabled; vendor preset: disabled)
   Active: active (exited) since Sun 2019-11-03 11:59:44 UTC; 29s ago
  Process: 1407 ExecStart=/opt/VBoxGuestAdditions-6.0.14/init/vboxadd start (code=exited, status=0/SUCCESS)
 Main PID: 1407 (code=exited, status=0/SUCCESS)
   CGroup: /system.slice/vboxadd.service
[vagrant@localhost ~]$

```

Теперь по аналогии создадим Vagrantfile для использования Centos c 5-й версией собранного ядра linux из исходников.

Создаем каталог kernel-source-auto и переходим в него:

```
cd ..
mkdir kernel-source-auto
cd kernel-source-auto
```

Устанавливаем плагин для изменения размеров диска

```
vagrant plugin install vagrant-disksize
```

Инициализируем Vagrantfile с базовой Centos 7

vagrant init centos/7

теперь отредактируем vagrantfile, добавив изменение конфигурации VM (cpu/ram/name) и выполнение кастомных скриптов после запуска:

```
	config.disksize.size = '50GB'
    config.vm.define "Centos7-5-src-kernel"
    config.vm.provider :virtualbox do |vb|
        vb.name = "Centos7-5-src-kernel"
	vb.cpus = "4"
	vb.memory = "4096"
    end

	config.vm.provision "shell", inline: <<-SHELL
		echo Start provisioning...
		# Install packages
		yum install ncurses-devel make gcc bc openssl-devel elfutils-libelf-devel rpm-build wget flex bison rsync -y
		# Install new kernel
		wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.3.8.tar.xz
		tar xvf linux-5.3.8.tar.xz
		cd linux-5.3.8
		cp -v /boot/config-`uname -r` .config
		yes "" | make oldconfig
		make rpm-pkg
		rpm -iUv ~/rpmbuild/RPMS/x86_64/*.rpm
		# Reboot VM
		shutdown -r now
	 SHELL
```

Запускам виртуальную машину и проверяем версию ядра:

```
vagrant up
vagrant ssh
uname -r
```

Версия будет:

```
[vagrant@localhost ~]$ uname -r
5.3.8
```