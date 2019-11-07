# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **Packer** - система создания и упаковки образов


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson2** - ссылка на данное домашнее задание

В рамках данного домашнего задания выполнено:
- **Создание Vagrantfile с встроенным скриптом для создания и тестирования отказа RAID массива** 
- **Создание Vagrantfile с встроенным скриптом для создания RAID массива и переноса на него ОС** 
- **Описаны шаги выполнения данного задания** 

Используемые файлы и директории:
- Во директории lesson2 расположен Vagrantfile с встроенным скриптом для создания и тестирования отказа RAID массива
- Во вложенной директории move расположен Vagrantfile с встроенным скриптом для создания RAID массива и переноса на него ОС


# Как проверить домашнее задание?

Склонируйте репозиторий:

```
git clone git@github.com:mercury131/otus-linux.git
```

Установите необходимые плагины для vagrant:

```
vagrant plugin install vagrant-reload
```

Для запуска VM с встроенным скриптом для создания и тестирования отказа RAID массива выполните:

```
cd otus-linux/lesson2/
vagrant up 
vagrant ssh
```

Для запуска VM с встроенным скриптом для создания RAID массива и переноса на него ОС выполните:

```
cd otus-linux/lesson2/move/
vagrant up 
vagrant ssh
```


# Описание выполнения данного задания.

Создание RAID 10 на Centos и тестирование отказа одного из дисков.

Для запуска виртуального окружения необходимо запустить Vagrantfile из директории https://github.com/mercury131/otus-linux/tree/master/lesson1 
Это образ чистой Centos 7 . 

```
vagrant up 
```

Далее подключиться по ssh к виртуальной машине:

```
vagrant ssh clean_Centos
```

Устанавливаем необходимые пакеты:

```
yum install -y mdadm smartmontools hdparm gdisk
```

Создаем партиции на свободных дисках, которые будем использовать под RAID:
```
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdb
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdc
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdd
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sde
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdf 
```

Создаем RAID 10 и дожидаемся его синхронизации:

```
mdadm --create --verbose /dev/md0 --level=10 --raid-devices=4 /dev/sd[bcde]1
mdadm --detail /dev/md0
```

Теперь повредим один из дисков в RAID массиве
```
echo -e "d\nw" | fdisk /dev/sdd
partprobe
```

Выполняем замену сбойного диска, удалем его из массива и добавляем новый, свободный диск

```
mdadm /dev/md0 -r -f /dev/sdd1
mdadm /dev/md0 -a /dev/sdf1
```

Проверяем стастус массива и дожидаемся синхронизации:

```
mdadm --detail /dev/md0
```

Теперь создадим GPT раздел и 5 партиций :

```
parted /dev/md0 mklabel gpt
parted /dev/md0 mkpart primary 0% 10%
parted /dev/md0 mkpart primary 10% 20%
parted /dev/md0 mkpart primary 20% 30%
parted /dev/md0 mkpart primary 30% 40%
parted /dev/md0 mkpart primary 40% 50%
```

Проверяем созданные партиции:
```
parted /dev/md0 print
```



Теперь перейдем к процедуре создания RAID 1 и перенесем на него ОС

Для запуска виртуального окружения необходимо запустить Vagrantfile из директории https://github.com/mercury131/otus-linux/tree/master/lesson1 
Это образ чистой Centos 7 . 

```
vagrant up 
```

Далее подключиться по ssh к виртуальной машине:

```
vagrant ssh clean_Centos
```


Устанавливаем необходимые пакеты

```
yum install -y mdadm smartmontools hdparm gdisk
```

Создаем партиции

```
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdb
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdc
```

Создаем RAID 1:

```
mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sd[bc]1
```

ПРоверяем что массив работает и синхронизировался:
```
mdadm --detail /dev/md0
```

Создаем раздел на RAID массиве

```
echo -e "n\np\n1\n\n\nw" | fdisk /dev/md0
```

Форматируем созданный раздел в файловую систему xfs

```
mkfs.xfs /dev/md0p1
```

Подключаем созданный раздел:

```
mount /dev/md0p1 /mnt/
```

Клонируем текущую систему в подключенный раздел:

```
rsync -axu / /mnt/
```

Теперь подключаем в /mnt следующие каталоги: /proc /dev /sys /run , это необходимо чтобы выполнить chroot в склонированную систему.

```
mount --bind /proc /mnt/proc && mount --bind /dev /mnt/dev && mount --bind /sys /mnt/sys && mount --bind /run /mnt/run
```

Выполняем chroot в склонированную систему:

```
chroot /mnt/
```
		
Внутри смонтированной системы выполним смену UUID в /etc/fstab, чтобы склонированная ОС загружалась с RAID массива

```
newid1=$(blkid /dev/md0p1 -s UUID -o value) && oldid1=$(blkid /dev/sda1 -s UUID -o value) && sed -i "s/$oldid1/$newid1/g" /etc/fstab
```

Создаем конфигурацию существующего RAID массива:

```
mdadm --detail --scan > /etc/mdadm.conf
```

Теперь создадим новый initramfs

```
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak && dracut /boot/initramfs-$(uname -r).img $(uname -r)
```

Далее, добавим в GRUB опцию ядра rd.auto, чтобы он мог автоматически обнаружить RAID:

```
sed -i "s/crashkernel=auto/crashkernel=auto rd.auto=1/g" /etc/default/grub
```

Формируем новый Grub конфиг и выполняем установку загрузчика на один из дисков RAID массива:
```
grub2-mkconfig -o /boot/grub2/grub.cfg && grub2-install /dev/sdb
```

Далее необходимо выполнить relabel файлов в новой ОС, иначе SElinux не позволит авторизоваться в склонированную ОС:

```
fixfiles restore
```

Теперь можно удалить раздел с текущей системы:

```
echo -e "d\nw" | fdisk /dev/sda
```

Выходим из chroot и перезагружаемся:

```
exit
shutdown -r now
```

Загрузившись в ОС, проверяем что она установлена на RAID массиве:

```
df -h
lsblk
```

Добавим диск, где была изначально установлена ОС в RAID массив как spare диск:

```
mdadm --add /dev/md0 /dev/sda
```

Проверяем стастус RAID массива

```
mdadm --detail /dev/md0
```

Перенос ОС на RAID массив завершен.