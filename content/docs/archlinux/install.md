---
title: Install Guide Lazy Mode
weight: 99

---
# ArchLinux Install Guide *Lazy Mode*


### Disks Partitions

* /boot/efi/ -> fat32 - 500mb
* / -> ext4 - 40gb
* swap -> swap - 8gb
* /home -> ext4 - space left


### Configuration

```bash
### Disk Partitions `sfdisk --label gpt --list-types`
PARTITIONS='
    label: gpt

    size=500M, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, name="EFI System", bootable
    size= 40G, type=44479540-F297-41B2-9AF7-D131D5F0458A, name="Linux x86-64 root (/)"
    size=  8G, type=0657FD6D-A4AB-43C4-84E5-0933C84B4F4F, name="Linux swap"
               type=933AC7E1-2EB4-4F13-B844-0E14E2AEF915, name="Linux /home"
'

### Install Config
KEYMAP="br-abnt2"
MIRROR="BR"

### System Configuration
TIMEZONE="America/Sao_Paulo"
LOCALE="pt_BR.utf-8"
HOSTNAME="atlantis"
SERVICES=(
    NetworkManager.service
    lightdm.service
    systemd-timesyncd.service
)

NEW_GROUPS=(autologin docker)
USER_GROUPS=(autologin docker games wheel)
USERNAME="hellupline"
```


## LiveCD


### Internet

```bash
wifi-menu
```


### Set Keyboard Map

```bash
# ls /usr/share/kbd/keymaps/**/*.map.gz
loadkeys "${KEYMAP}"
```


### Partition Disks

```bash
# echo "${PARTITIONS}" | sfdisk /dev/sda
gfdisk /dev/sda
```


### Setup Filesystem

```bash
# Root
mkfs.ext4 /dev/sda2

# EFI
mkfs.fat -F 32 /dev/sda1

# Swap
mkswap /dev/sda3

# Home
mkfs.ext4 /dev/sda4
```


### Mount Filesystem

```bash
# Root
mount /dev/sda2 /mnt/
mkdir -p /mnt/boot/efi/ /mnt/home/

# EFI
mount /dev/sda1 /mnt/boot/efi/

# Swap
swapon /dev/sda3

# Home
mount /dev/sda4 /mnt/home/
```


### Pacman Mirrors

```bash
# alternative method
# vim /etc/pacman.d/mirrorlist "+5" "+read ! grep -A1 --no-group-separator ${MIRROR} %" "+wq"

local TMPFILE=$(mktemp --suffix=-mirrorlist)

pacman -Sy pacman-contrib
curl -s \
    "https://www.archlinux.org/mirrorlist/?country=${MIRROR}&protocol=https&use_mirror_status=on" \
    'https://www.archlinux.org/mirrorlist/?country=US&protocol=https&use_mirror_status=on' |
sed -e 's/^#Server/Server/' -e '/^#/d' |
sort -u |
rankmirrors -n 6 - > "${TMPFILE}"

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bkp
mv "${TMPFILE}" /etc/pacman.d/mirrorlist
```


### Install Base System

```bash
pacstrap /mnt base linux-lts refind-efi
```


### FSTAB

```bash
genfstab -U /mnt/ > /mnt/etc/fstab
```


## CHROOT


### Timezone

```bash
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
hwclock --systohc
```


### Locale

```bash
echo "KEYMAP=${KEYMAP}" > /etc/vconsole.conf
echo "LANG=${LOCALE}" > /etc/locale.conf

sed -i /etc/locale.gen \
    -e '24 {x;p;x}' \
    -e '24 i pt_BR.UTF-8 UTF-8' \
    -e '24 i en_US.UTF-8 UTF-8' \
    -e '24 {x;p;x}'
locale-gen
```


### Hostname

```bash
echo "${HOSTNAME}" > /etc/hostname
```


### Users

```bash
echo -e '123\n123' | passwd root

useradd --create-home "${USERNAME}"

for GROUP in ${NEW_GROUPS[@]}; do
    groupadd "${GROUP}"
done
usermod --append --groups "$(hell_helpers_array_join , ${USER_GROUPS[@]})" "${USERNAME}"

echo -e '123\n123' | passwd hellupline
```


### Install Packages

```bash
local TMPFILE=$(mktemp --suffix=-mirrorlist)

curl -o "${TMPFILE}" https://raw.githubusercontent.com/hellupline/settings/master/misc/archlinux-packages

grep -v '^\s*#' "${TMPFILE}" | xargs pacman \
    --sync \
    --verbose \
    --refresh \
    --sysupgrade \
    --needed \
    --noconfirm
```


### BootLoader

```bash
refind-install

# Enable LTS Kernel
sed -i /boot/efi/EFI/refind/refind.conf -e 's/^#\(extra_kernel_version_strings\)/\1/'
```


### Services

```bash
for SERVICE in ${SERVICES[@]}; do
    systemctl --no-reload enable "${SERVICE}"
done
systemctl --no-reload set-default graphical.target
```


### Pacman

```bash
sed -i /etc/pacman.conf \
    -e '/\[multilib\]/{s/^#//;n;s/^#//}' \
    -e 's/^#Color/Color/' \
    -e '/^# Misc options/a ILoveCandy'
```


### Sudo

```bash
echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/99_wheel_group_nopass
```


### Lightdm
```bash
sed -i /etc/lightdm/lightdm.conf \
    -e "/^#pam-service=lightdm$/s/^#//" \
    -e "/#pam-autologin-service=lightdm-autologin$/s/^#//" \
    -e "/^#autologin-user-timeout=0$/s/^#//" \
    -e "/^#autologin-user=$/s/#autologin-user=/autologin-user=${USERNAME}/"
```




## Helpers


### Array Join
```bash
function array_join { local IFS="$1"; shift; echo "$*"; }
```


### Install Aur

```bash
local PACKAGE=${1}; shift
local CURDIR=$(pwd)

mkdir -p aur
cd aur

wget "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=${PACKAGE}" -O "${PACKAGE}.pkgbuild"
makepkg --install \
    --syncdeps \
    --clean \
    --force \
    --check \
    --install \
    --needed \
    --noconfirm \
    -p ${PACKAGE}.pkgbuild

cd "${CURDIR}"
```


## Hardware Variations

### VirtualBox
```bash
mv /mnt/boot/efi/EFI/refind/{refind_,boot}x64.efi
mv /mnt/boot/efi/EFI/{refind,BOOT}

pacman --sync \
    virtualbox-guest-modules-arch \
    virtualbox-guest-utils \
    xf86-video-vesa
systemctl --no-reload enable vboxservice
```


### Nvidia
```bash
pacman --sync nvidia bumblebee
gpasswd -a "${USERNAME}" bumblebee
systemctl enable bumblebeed
```