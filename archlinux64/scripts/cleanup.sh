#!/bin/bash -e
#
# Cleanup an Archlinux ARM installation prior to image capture.
#
################################################################################

set -o pipefail

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Checking environment...                                               -"
echo "-------------------------------------------------------------------------"

hash rm
hash sed
hash find
hash sync
hash btrfs
hash e2fsck
hash fstrim
hash umount
hash e4defrag
hash fsck.fat
hash arch-chroot

CLEANUP_SHARED=""

while getopts "s:" CLEANUP_OPT; do
  case ${CLEANUP_OPT} in
    s)
      CLEANUP_SHARED="${OPTARG}"
      ;;
  esac
done

if [   -z "${CLEANUP_SHARED}" ]; then echo "FAIL: No shared source specified for cleanup (-s)"            ; exit 1; fi
if [ ! -d "${CLEANUP_SHARED}" ]; then echo "FAIL: Shared source specified for cleanup (-s) does not exist"; exit 1; fi

echo "Cleanup shared: ${CLEANUP_SHARED}"
echo ""

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Generating ramdisk...                                                 -"
echo "-------------------------------------------------------------------------"

arch-chroot "/mnt" mkinitcpio -p "linux"

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Removing orphaned dependancies...                                     -"
echo "-------------------------------------------------------------------------"

if CLEAN_ORPHAN_LIST="$(arch-chroot "/mnt" pacman -Qdtq)"; then
  arch-chroot "/mnt" pacman -Rns --noconfirm ${CLEAN_ORPHAN_LIST}
fi

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Running Pacman clean...                                               -"
echo "-------------------------------------------------------------------------"

echo -e "y\ny" | arch-chroot "/mnt" pacman -Scc

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Running Pacman keyring clean...                                       -"
echo "-------------------------------------------------------------------------"

rm -fv "/mnt/etc/pacman.d/gnupg/openpgp-revocs.d"/*
rm -fv "/mnt/etc/pacman.d/gnupg/private-keys-v1.d"/*
rm -fv "/mnt/etc/pacman.d/gnupg/pubring.gpg~"
rm -fv "/mnt/etc/pacman.d/gnupg"/S.*

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Cleanup generic files...                                              -"
echo "-------------------------------------------------------------------------"

rm -fv "/mnt/boot/initramfs-linux-fallback.img"
rm -fv "/mnt/etc/machine-id"

find "/mnt/var/cache"           -mindepth 1 -maxdepth 1 -exec rm -rfv "{}" \;
find "/mnt/var/log"             -mindepth 1 -type f -exec rm -fv "{}" \;
find "/mnt/var/lib/pacman/sync" -mindepth 1 -type f -exec rm -fv "{}" \;
find "/mnt/var/tmp"             -mindepth 1 -maxdepth 1 -exec rm -rfv "{}" \;

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Finalising file systems...                                            -"
echo "-------------------------------------------------------------------------"

CLEANUP_FINALISE_TYPE="$(cat "${CLEANUP_SHARED}/filesystem-type")"
CLEANUP_FINALISE_BOOT_DEVICE="$(cat "${CLEANUP_SHARED}/filesystem-boot-device")"
CLEANUP_FINALISE_ROOT_DEVICE="$(cat "${CLEANUP_SHARED}/filesystem-root-device")"

sync
umount "/mnt/boot"

if [ "${CLEANUP_FINALISE_TYPE,,}" == "btrfs" ]; then
  umount "/mnt/home"
elif [ "${CLEANUP_FINALISE_TYPE,,}" == "ext4" ]; then 
  e4defrag "${CLEANUP_FINALISE_ROOT_DEVICE}"
  sync
fi

umount "/mnt"

fsck.fat -a -r -V -v "${CLEANUP_FINALISE_BOOT_DEVICE}"

if [ "${CLEANUP_FINALISE_TYPE,,}" == "btrfs" ]; then
  btrfs check "${CLEANUP_FINALISE_ROOT_DEVICE}"
elif [ "${CLEANUP_FINALISE_TYPE,,}" == "ext4" ]; then 
  e2fsck -fyvD -E "discard" "${CLEANUP_FINALISE_ROOT_DEVICE}" || true
  e2fsck -fyv -E "discard" "${CLEANUP_FINALISE_ROOT_DEVICE}"
else
  echo "ERROR! Unknown root filesystem: ${CLEANUP_FINALISE_TYPE}"
  exit 1
fi

################################################################################

echo "-------------------------------------------------------------------------"
echo "- DONE!                                                                 -"
echo "-------------------------------------------------------------------------"

################################################################################
