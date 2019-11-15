# **Введение**

Для выполнения задания использовались следующие инструменты:
- **VirtualBox** - ПО для создания виртуальных окружений
- **Vagrant** - ПО для конфигурирования/шаблонизирования виртуальных машин
- **Git** - система контроля версий
- **LVM** - Менеджер логических томов


Используемые репозитории:
- **https://github.com/mercury131/otus-linux** - репозиторий для выполнения домашних заданий OTUS
- **https://github.com/mercury131/otus-linux/tree/master/lesson3** - ссылка на данное домашнее задание

В рамках данного домашнего задания выполнено:
- **Создание Vagrantfile с встроенным скриптом для создания и тестирования LMV** 
- **Описаны шаги выполнения данного задания** 

Используемые файлы и директории:
- Во директории lesson3 расположен Vagrantfile с встроенным скриптом для создания и тестирования LVM

Vagrantfile выполняет следующие действия:
- уменьшает том /dev/mapper/VolGroup00-LogVol00 до 8 GB
- выделяет отдельный том под /home
- выделяет отдельный том под /var в режиме mirror
- создает снапшоты в /home
- создает снапшоты в /home, восстанавливается с них
- создает файловую систему btrfs для /opt и создает subvolume

# Как проверить домашнее задание?

Склонируйте репозиторий:

```
git clone git@github.com:mercury131/otus-linux.git
```

Установите необходимые плагины для vagrant:

```
vagrant plugin install vagrant-reload
```

Для запуска VM с встроенным скриптом выполните:

```
cd otus-linux/lesson3/
vagrant up 
vagrant ssh
```


# Описание выполнения данного задания.

Тестирование LVM

Для запуска виртуального окружения необходимо запустить Vagrantfile из директории https://github.com/mercury131/otus-linux/tree/master/lesson3 

```
vagrant up 
```

Далее подключиться по ssh к виртуальной машине:

```
vagrant ssh
```

Устанавливаем необходимые пакеты:

```
yum install xfsdump -y
```

Создаем PV для /home VG
```
pvcreate /dev/sdc  
```

Создаем VG для /home

```
vgcreate vghome /dev/sdc
```

Создаем LV для /home
```
lvcreate -n home -l 50%FREE vghome
```

Создаем файловую систему xfs на созданном LVM разделе и монтируем его

```
mkfs.xfs /dev/vghome/home
mount /dev/vghome/home /mnt
```

клонируем файлы из /home/ в /mnt/:

```
rsync -axu /home/ /mnt/
```

Создаем точку монтирования для нового /home :

```
umount /mnt/
echo "/dev/vghome/home /home                    xfs    defaults        0 2" >> /etc/fstab
echo " " >> /etc/fstab
```

Удаляем файлы из старого раздела /home и монтируем новый /home расположенный на LVM, также исправляем права доступа:
```
rm -rf /home/*
mount /dev/vghome/home
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys
fixfiles restore
```


Создаем снапшот LVM и тестируем удаление файлов и восстановление:

```
touch /home/test1
touch /home/test2
ls /home/
lvcreate -n home_snap -l 10%FREE -s /dev/vghome/home
lvs
rm -f /home/test1
rm -f /home/test2
ls /home/
umount /dev/vghome/home
lvconvert --merge /dev/vghome/home_snap
mount /dev/vghome/home
ls /home/
```


Далее создадим отдельный LVM для /var

Создаем PV для /var VG
```
pvcreate /dev/sdd /dev/sde
```

Создаем VG для /var

```
vgcreate vgvar /dev/sdd /dev/sde
```

Создаем LV для /var
```
lvcreate -n var -l 100%FREE vgvar -m1
```

Создаем файловую систему ext4 на созданном LVM разделе и монтируем его

```
mkfs.ext4 /dev/vgvar/var
mount /dev/vgvar/var /mnt
```

клонируем файлы из /var в /mnt/ и делаем relabel для selinux:

```
rsync -axu /var/ /mnt/
fixfiles restore
umount /mnt/
```

Создаем точку монтирования для нового /home :

```
umount /mnt/
echo "/dev/vgvar/var /var                    ext4    defaults        0 2" >> /etc/fstab
echo " " >> /etc/fstab
```

Удаляем файлы из старого раздела /home и монтируем новый /home расположенный на LVM, также исправляем права доступа:
```
rm -rf /var/*
mount /dev/vgvar/var

Создадим btrfs для /opt

```
mkfs.btrfs /dev/sdf
```

Создадим точку монтирования:

```
echo "/dev/sdf /opt                    btrfs    defaults        0 0" >> /etc/fstab
echo " " >> /etc/fstab
```

Подключаем раздел:
```
mount /opt
```

Создаем subvolume

```
btrfs subvolume create /opt/test1
```

Создаем тестовые файлы

```
touch /opt/test1/1
touch /opt/test1/2
touch /opt/test1/3
ls /opt/test1/
```

Создаем снапшот:

```
btrfs subvolume snapshot /opt/test1 /opt/test1/snapshot
```

Проверяем файлы в снапшоте:

```
ls /opt/test1/snapshot/
```


Теперь выполним уменьшение корневого раздела, размещенного на LVM и отформатированного в фс xfs

Создаем PV

```
pvcreate /dev/sdb
```

Добавляем его в VolGroup00:

```
vgextend VolGroup00 /dev/sdb
```
		
Создаем новый LVM под новый корневой раздел

```
lvcreate -n newroot -l 100%FREE VolGroup00
```

Форматируем новый раздел и подключаем:

```
mkfs.xfs /dev/VolGroup00/newroot
mount /dev/VolGroup00/newroot /mnt/
```

Выполняем резервное копирование xfs текущего корневого раздела на новый, созданный ранее LVM раздел

```
xfsdump -J  - / | xfsrestore -J - /mnt
```

Отключаем новый раздел:

```
umount /mnt/
```

Переименовываем новый LVM, чтобы GRUB мог успешно загрузить ос с нового раздела:
```
lvrename /dev/VolGroup00/LogVol00 oldroot
lvrename /dev/VolGroup00/newroot LogVol00
```

Перезагружаемся и проверяем:

```
shutdown -r now
```

Проверяем:

```
lsblk
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk
├─sda1                    8:1    0    1M  0 part
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part
  ├─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
  └─VolGroup00-oldroot  253:2    0 37.5G  0 lvm
sdb                       8:16   0 1000M  0 disk
└─VolGroup00-LogVol00   253:0    0  992M  0 lvm  /
sdc                       8:32   0 1000M  0 disk
└─vghome-home           253:3    0  496M  0 lvm  /home
sdd                       8:48   0 1000M  0 disk
├─vgvar-var_rmeta_0     253:4    0    4M  0 lvm
│ └─vgvar-var           253:8    0  992M  0 lvm  /var
└─vgvar-var_rimage_0    253:5    0  992M  0 lvm
  └─vgvar-var           253:8    0  992M  0 lvm  /var
sde                       8:64   0 1000M  0 disk
├─vgvar-var_rmeta_1     253:6    0    4M  0 lvm
│ └─vgvar-var           253:8    0  992M  0 lvm  /var
└─vgvar-var_rimage_1    253:7    0  992M  0 lvm
  └─vgvar-var           253:8    0  992M  0 lvm  /var
sdf                       8:80   0 1000M  0 disk /opt

```

Удаляем старый LVM:

```
lvremove /dev/VolGroup00/oldroot
```

