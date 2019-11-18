# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **LVM** - Менеджер логических томов
- **GRUB2** - Загрузчик ОС


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson4** - ссылка на данное домашнее задание

В рамках данного домашнего задания выполнено:
- **Вход в систему без пароля несколькими способами** 
- **Установить систему с LVM, после чего переименовать VG** 
- **Добавить модуль в initrd (изменение размера LVM на /)** 
- **Сконфигурировать систему без отдельного раздела с /boot, а только с LVM** 

Используемые файлы и директории:
- Во директории lesson4 расположен Vagrantfile с образом Centos 7 , установленным на LVM раздел


# Как проверить домашнее задание?

Склонируйте репозиторий:

```
git clone git@github.com:mercury131/otus-linux.git
```

Установите необходимые плагины для vagrant:

```
vagrant plugin install vagrant-reload
```

Для запуска VM выполните:

```
cd otus-linux/lesson4/
vagrant up 
vagrant ssh
```


# Описание выполнения данного задания.

Вход в систему без пароля несколькими способами

Первый способ получить root доступ без пароля. 

Запускаем виртуальную машину
```
vagrant up 
```

Далее подключиться по ssh к виртуальной машине:

```
vagrant ssh
```

перезагружаемся:

```
sudo reboot
```

На этапе когда GRUB загрузился, выбираем опцию загрузки и нажимаем e, чтобы перейти в режим редактирования

![Grub edit](https://i.gyazo.com/183f92cb785af372e58c63be93ca2871.png)

Добавляем параметр загрузки rd.break

![Grub edit](https://i.gyazo.com/bbb30316ef34e772edb9e218d5063a80.png)


Нажимаем ctrl X для запуска ОС добавленным параметром

После загрузки мы попадаем в режим восстановления.

Монтируем раздел где установлена наша ОС

```
mount -o remount,rw /sysroot
```

Выполняем chroot и пападаем в шелл установленной ос

```
chroot /sysroot
```

![chroot](https://i.gyazo.com/1eb5ec0dad49a0e4314aaff422af59de.png)



Второй способ. 

перезагружаемся:

```
sudo reboot
```

На этапе когда GRUB загрузился, выбираем опцию загрузки и нажимаем e, чтобы перейти в режим редактирования

![Grub edit](https://i.gyazo.com/183f92cb785af372e58c63be93ca2871.png)

Добавляем параметр загрузки init=/bin/sh

Нажимаем ctrl X для запуска ОС добавленным параметром


![init=/bin/sh](https://i.gyazo.com/84f0e3a5b71b17c7791e59f098854016.png)


После загрузки попадаем в шелл нашей ОС, но файловая система находится в режиме Read Only, переводим ее в режим записи:

```
mount -o remount,rw /
```

![init shell](https://i.gyazo.com/df9d519b288822a1cb2b38e6aa905a9b.png)


Третий способ.

перезагружаемся:

```
sudo reboot
```

На этапе когда GRUB загрузился, выбираем опцию загрузки и нажимаем e, чтобы перейти в режим редактирования

![Grub edit](https://i.gyazo.com/183f92cb785af372e58c63be93ca2871.png)

Изменяем параметр загрузки ro на rw init=/sysroot/bin/sh

![rw init=/sysroot/bin/sh](https://i.gyazo.com/3a67f37a6c1f084bae1f8583e15fcd49.png)

Нажимаем ctrl X для запуска ОС добавленным параметром

После этого мы попадаем в режим восстановления, с уже смонтированной корневой файловой системой в режиме записи.


Теперь рассмотрим восстановление загрузки ОС, после переименования LVM раздела с корневой ос


подключаемся по ssh и переименовываем раздел:
```

[root@centoslvm ~]# lvrename /dev/centos_centoslvm/root failroot
  Renamed "root" to "failroot" in volume group "centos_centoslvm"

```


Перезагружаемся и убеждаемся что ос не загрузилась

![fail boot](https://i.gyazo.com/028762271de84d398548d08b2ee849f8.png)

Чтобы восстановить загрузку, перезагружаемся и переходим в Grub в режим редактирования. 
Указываем правильный LVM раздел в параметрах загрузки:

![fix lvm in boot parameter](https://i.gyazo.com/80a9913b5f802492070d10b24d9775a5.png)


Нажимаем ctrl X для запуска ОС с исправленным параметром.

После загрузки ОС подключаемся по ssh и редактируем файл /etc/default/grub, в который внесем примененные для корректной загрузки изменения (импользуемые в GRUB ранее)


```
vi /etc/default/grub

```

Проверяем что изменения внесены верно:

```
[root@centoslvm ~]# cat /etc/default/grub
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=centos_centoslvm/failroot rd.lvm.lv=centos_centoslvm/swap rhgb quiet"
GRUB_DISABLE_RECOVERY="true"
```

Теперь применим конфиг с измененными параметрами:

```
[root@centoslvm ~]# grub2-mkconfig -o /boot/grub2/grub.cfg
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-3.10.0-957.12.2.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-957.12.2.el7.x86_64.img
Found linux image: /boot/vmlinuz-0-rescue-c76ad8c81fff4aaf877e1846ef94f610
Found initrd image: /boot/initramfs-0-rescue-c76ad8c81fff4aaf877e1846ef94f610.img
done

```

Перезагружаемся и проверяем что ОС запускается корректно.


Теперь рассмотрим установку модуля с помощью dracut

В примере ниже модуль будет расширять LVM раздел с /

Устанавливаем git

```
yum install git -y
```

Клонируем репозиторий с модулем dracut

```
git clone https://github.com/thedolphin/dracut-root-lv-resize.git
```

Переходим в каталог с модулем

```
cd dracut-root-lv-resize/
```

Копируем файлы:

опции модуля в /etc 

```
cp etc/dracut.conf.d/lvm-resize-root.conf  /etc/dracut.conf.d/
```

копируем сам модуль:

```
cp -r usr/lib/dracut/modules.d/99lvm-resize-root /usr/lib/dracut/modules.d/
```

Теперь добавим PV и расширим VG корневого раздела, чтобы было свободное место для расширения LV

```
pvcreate  /dev/sdc
pvcreate /dev/sdd
vgextend centos_centoslvm /dev/sdc /dev/sdd
```

Теперь посмотрим насколько можно расширить корневой раздел:

```
lvdisplay

  LV Path                /dev/centos_centoslvm/root
  LV Name                root
  VG Name                centos_centoslvm
  LV UUID                1e46sm-jT2i-0BVX-m72Q-kUn6-qoba-1tJGJl
  LV Write Access        read/write
  LV Creation host, time localhost, 2019-06-03 14:49:52 +1200
  LV Status              available
  # open                 1
  LV Size                50.00 GiB
  Current LE             12800
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0

```

Расширим раздел до 51 Gb с помощью опции в файле lvm-resize-root.conf (lvm_resize=51G)

```
vi /etc/dracut.conf.d/lvm-resize-root.conf
```

Применяем изменения в initrd:

```
dracut -f -v
```

Перезагружаемся:

```
reboot
```

Подключаемся по ssh и проверяем:

```
vagrant ssh
lvdisplay

  LV Path                /dev/centos_centoslvm/root
  LV Name                root
  VG Name                centos_centoslvm
  LV UUID                1e46sm-jT2i-0BVX-m72Q-kUn6-qoba-1tJGJl
  LV Write Access        read/write
  LV Creation host, time localhost, 2019-06-03 14:49:52 +1200
  LV Status              available
  # open                 1
  LV Size                51.00 GiB
  Current LE             13056
  Segments               3
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0

```

