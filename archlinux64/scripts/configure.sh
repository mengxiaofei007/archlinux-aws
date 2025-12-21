#!/bin/bash -e
#
# Configures a newly installed Archlinux ARM installation.
#
################################################################################

set -o pipefail

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Checking environment...                                               -"
echo "-------------------------------------------------------------------------"

hash cp
hash cat
hash sed
hash eval
hash genfstab
hash arch-chroot

CONFIGURE_FILES=""
CONFIGURE_KEYMAP="uk"
CONFIGURE_REGION=""
CONFIGURE_SHARED=""
CONFIGURE_HOSTNAME="archlinux"
CONFIGURE_LANGUAGE="en_GB.UTF-8"
CONFIGURE_TIMEZONE="UTC"

while getopts "f:h:k:l:r:s:t:" CONFIGURE_OPT; do
  case ${CONFIGURE_OPT} in
    f)
      CONFIGURE_FILES="${OPTARG}"
      ;;
    h:)
      CONFIGURE_HOSTNAME="${OPTARG}"
      ;;
    k:)
      CONFIGURE_KEYMAP="${OPTARG}"
      ;;
    l:)
      CONFIGURE_LANGUAGE="${OPTARG}"
      ;;
    r)
      CONFIGURE_REGION="${OPTARG}"
      ;;
    s)
      CONFIGURE_SHARED="${OPTARG}"
      ;;
    t)
      CONFIGURE_TIMEZONE="${OPTARG}"
      ;;
  esac
done

if [   -z "${CONFIGURE_FILES}"  ]; then echo "FAIL: No files source specified for configure (-f)"             ; exit 1; fi
if [ ! -d "${CONFIGURE_FILES}"  ]; then echo "FAIL: Files source specified for configure (-f) does not exist" ; exit 1; fi
if [   -z "${CONFIGURE_SHARED}" ]; then echo "FAIL: No shared source specified for configure (-s)"            ; exit 1; fi
if [ ! -d "${CONFIGURE_SHARED}" ]; then echo "FAIL: Shared source specified for configure (-s) does not exist"; exit 1; fi

echo "Configure files   : ${CONFIGURE_FILES}"
echo "Configure keymap  : ${CONFIGURE_KEYMAP}"
echo "Configure region  : ${CONFIGURE_REGION}"
echo "Configure shared  : ${CONFIGURE_SHARED}"
echo "Configure hostname: ${CONFIGURE_HOSTNAME}"
echo "Configure language: ${CONFIGURE_LANGUAGE}"
echo "Configure timezone: ${CONFIGURE_TIMEZONE}"
echo ""

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Configuring mirrorlist...                                             -"
echo "-------------------------------------------------------------------------"

arch-chroot "/mnt" reflector        \
  --completion-percent 95           \
  --country "${CONFIGURE_REGION}"   \
  --protocol "https"                \
  --save "/etc/pacman.d/mirrorlist" \
  --sort "rate"                     \
  --verbose

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Installing configuration files...                                     -"
echo "-------------------------------------------------------------------------"

genfstab -p -U "/mnt" >> "/mnt/etc/fstab"

mkdir "/mnt/root/.config"

ln -sfr "/mnt/usr/share/zoneinfo/${CONFIGURE_TIMEZONE}" "/mnt/etc/localtime"
sed -i '/CheckSpace$/s/^#//g' "/mnt/etc/pacman.conf"
sed -i '/DownloadUser\ \=/s/^#//g' "/mnt/etc/pacman.conf"
sed -i "/${CONFIGURE_LANGUAGE}/s/^#//g" "/mnt/etc/locale.gen"
echo "BITSERVICES_MIRRORLIST_COUNTRY=${CONFIGURE_REGION}" >> "/mnt/etc/environment"
echo "LANG=${CONFIGURE_LANGUAGE}" > "/mnt/etc/locale.conf"
echo "LANG=${CONFIGURE_LANGUAGE}" > "/mnt/root/.config/locale.conf"
echo "${CONFIGURE_HOSTNAME}" > "/mnt/etc/hostname"
echo "KEYMAP=${CONFIGURE_KEYMAP}" > "/mnt/etc/vconsole.conf"

cat <<NETWORKMANAGER > "/mnt/etc/NetworkManager/NetworkManager.conf"
  [connection]
  ipv6.ip6-privacy=2
NETWORKMANAGER

mkdir "/mnt/etc/systemd/system-preset"
mkdir "/mnt/etc/systemd/timesyncd.conf.d"

cp -fv "${CONFIGURE_FILES}/etc/cloud/cloud.cfg" "/mnt/etc/cloud/cloud.cfg"
cp -fv "${CONFIGURE_FILES}/etc/conf.d/pretty-motd" "/mnt/etc/conf.d/pretty-motd"
cp -fv "${CONFIGURE_FILES}/etc/conf.d/prometheus-node-exporter" "/mnt/etc/conf.d/prometheus-node-exporter"
cp -fv "${CONFIGURE_FILES}/etc/mkinitcpio.conf" "/mnt/etc/mkinitcpio.conf"
cp -fv "${CONFIGURE_FILES}/etc/mkinitcpio.d/linux.preset" "/mnt/etc/mkinitcpio.d/linux.preset"
cp -fv "${CONFIGURE_FILES}/etc/systemd/system-preset/50-archlinux64.preset" "/mnt/etc/systemd/system-preset/50-archlinux64.preset"
cp -fv "${CONFIGURE_FILES}/etc/systemd/timesyncd.conf.d/ntp-ec2.conf" "/mnt/etc/systemd/timesyncd.conf.d/ntp-ec2.conf"
cp -fv "${CONFIGURE_FILES}/etc/udev/rules.d/70-ec2-nvme-devices.rules" "/mnt/etc/udev/rules.d/70-ec2-nvme-devices.rules"
cp -fv "${CONFIGURE_FILES}/usr/local/bin/ec2nvme-nsid" "/mnt/usr/local/bin/ec2nvme-nsid"
cp -fv "${CONFIGURE_FILES}/usr/local/bin/ebsnvme-id" "/mnt/usr/local/bin/ebsnvme-id"

chmod 755 "/mnt/usr/local/bin/ec2nvme-nsid"
chmod 755 "/mnt/usr/local/bin/ebsnvme-id"

################################################################################

CONFIGURE_TYPE="$(cat "${CONFIGURE_SHARED}/filesystem-type")"

if [ "${CONFIGURE_TYPE}" == "btrfs" ]; then
  echo "Adding BTRFS module..."
  eval "$(cat "/mnt/etc/mkinitcpio.conf" | grep "^MODULES=")"
  MODULES+=(btrfs)
  sed -i "s/^MODULES=(.*)$/MODULES=(${MODULES[*]})/g" "/mnt/etc/mkinitcpio.conf"
fi

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Generating locale...                                                  -"
echo "-------------------------------------------------------------------------"

arch-chroot "/mnt" locale-gen

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Locking root...                                                       -"
echo "-------------------------------------------------------------------------"

arch-chroot "/mnt" passwd -l "root"

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Installing bootloader...                                              -"
echo "-------------------------------------------------------------------------"

CONFIGURE_LOADER_ROOT_FLAGS="$(cat "${CONFIGURE_SHARED}/filesystem-root-flags")"
CONFIGURE_LOADER_ROOT_DEVICE="$(cat "${CONFIGURE_SHARED}/filesystem-root-device")"
CONFIGURE_LOADER_ROOT_BTRFS_VOLUME="$(cat "${CONFIGURE_SHARED}/filesystem-root-btrfs-subvolume-root")"

if [ "${CONFIGURE_TYPE}" == "btrfs" ]; then
  CONFIGURE_LOADER_ROOT_FLAGS="${CONFIGURE_LOADER_ROOT_FLAGS},subvol=${CONFIGURE_LOADER_ROOT_BTRFS_VOLUME}"
fi

CONFIGURE_LOADER_ROOT_UUID="$(blkid --match-tag "UUID" --output "value" "${CONFIGURE_LOADER_ROOT_DEVICE}")"
[ -n "${CONFIGURE_LOADER_ROOT_UUID}" ]

arch-chroot "/mnt" bootctl install --no-variables

cat <<LOADER > "/mnt/boot/loader/loader.conf"
editor       no
default      linux.conf
auto-entries no
LOADER

cat <<LOADERENTRY > "/mnt/boot/loader/entries/linux.conf"
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=${CONFIGURE_LOADER_ROOT_UUID} rootflags=${CONFIGURE_LOADER_ROOT_FLAGS} rw
LOADERENTRY

################################################################################

echo "-------------------------------------------------------------------------"
echo "- DONE!                                                                 -"
echo "-------------------------------------------------------------------------"

################################################################################
