#!/bin/bash -e
#
# Sets up file systems.
#
################################################################################

set -o pipefail

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Checking environment...                                               -"
echo "-------------------------------------------------------------------------"

hash cat
hash chmod
hash mount
hash btrfs
hash mkdir
hash umount
hash tune2fs
hash mkfs.fat
hash modprobe
hash mkfs.ext4
hash mkfs.btrfs

FILESYSTEM_FORMAT=""
FILESYSTEM_SHARED=""
FILESYSTEM_BOOT_LABEL="ARCH_BOOT"
FILESYSTEM_ROOT_LABEL="ARCH_SYSTEM"
FILESYSTEM_BOOT_PARTITION=""
FILESYSTEM_ROOT_PARTITION=""
FILESYSTEM_ROOT_BTRFS_COMPRESSION="zstd"
FILESYSTEM_ROOT_BTRFS_VOLUME_HOME="@home"
FILESYSTEM_ROOT_BTRFS_VOLUME_ROOT="@"
FILESYSTEM_ROOT_EXT4_FSCK_INTERVAL="1m"

while getopts "a:b:c:f:h:i:q:r:s:v:w:" FILESYSTEM_OPT; do
  case ${FILESYSTEM_OPT} in
    a)
      FILESYSTEM_BOOT_PARTITION="${OPTARG}"
      ;;
    b)
      FILESYSTEM_BOOT_LABEL="${OPTARG}"
      ;;
    c)
      FILESYSTEM_ROOT_BTRFS_COMPRESSION="${OPTARG}"
      ;;
    f)
      FILESYSTEM_FORMAT="${OPTARG}"
      ;;
    h)
      FILESYSTEM_ROOT_BTRFS_VOLUME_HOME="${OPTARG}"
      ;;
    i)
      FILESYSTEM_ROOT_EXT4_FSCK_INTERVAL="${OPTARG}"
      ;;
    q)
      FILESYSTEM_ROOT_PARTITION="${OPTARG}"
      ;;
    r)
      FILESYSTEM_ROOT_LABEL="${OPTARG}"
      ;;
    s)
      FILESYSTEM_SHARED="${OPTARG}"
      ;;
    v)
      FILESYSTEM_ROOT_BTRFS_VOLUME_ROOT=${OPTARG}
      ;;
  esac
done

if [   -z "${FILESYSTEM_FORMAT}"         ]; then echo "FAIL: No root file system format specified (-f)"                  ; exit 1; fi
if [   -z "${FILESYSTEM_SHARED}"         ]; then echo "FAIL: No shared source specified for file system (-s)"            ; exit 1; fi
if [ ! -d "${FILESYSTEM_SHARED}"         ]; then echo "FAIL: Shared source specified for file system (-s) does not exist"; exit 1; fi
if [   -z "${FILESYSTEM_BOOT_PARTITION}" ]; then echo "FAIL: No boot partition specified for file system (-a)"           ; exit 1; fi
if [   -z "${FILESYSTEM_ROOT_PARTITION}" ]; then echo "FAIL: No root partition specified for file system (-q)"           ; exit 1; fi

echo "File system type          : ${FILESYSTEM_FORMAT}"
echo "File system shared        : ${FILESYSTEM_SHARED}"
echo "File system boot label    : ${FILESYSTEM_BOOT_LABEL}"
echo "File system root label    : ${FILESYSTEM_ROOT_LABEL}"
echo "File system boot partition: ${FILESYSTEM_BOOT_PARTITION}"
echo "File system root partition: ${FILESYSTEM_ROOT_PARTITION}"
echo ""
echo "File system BTRFS only settings:"
echo "  - Compression   : ${FILESYSTEM_ROOT_BTRFS_COMPRESSION}"
echo "  - Root subvolume: ${FILESYSTEM_ROOT_BTRFS_VOLUME_ROOT}"
echo "  - Home subvolume: ${FILESYSTEM_ROOT_BTRFS_VOLUME_HOME}"
echo ""
echo "File system EXT4 only settings:"
echo "  - Check interval: ${FILESYSTEM_ROOT_EXT4_FSCK_INTERVAL}"
echo ""

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Resolving devices...                                                  -"
echo "-------------------------------------------------------------------------"

FILESYSTEM_DEVICE="$(cat "${FILESYSTEM_SHARED}/partition-device")"
FILESYSTEM_BOOT_DEVICE="${FILESYSTEM_DEVICE}${FILESYSTEM_BOOT_PARTITION}"
FILESYSTEM_ROOT_DEVICE="${FILESYSTEM_DEVICE}${FILESYSTEM_ROOT_PARTITION}"

echo "Boot device: ${FILESYSTEM_BOOT_DEVICE}"
echo "Root device: ${FILESYSTEM_ROOT_DEVICE}"
echo ""

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Create boot file system...                                            -"
echo "-------------------------------------------------------------------------"

mkfs.fat -F 32 -n "${FILESYSTEM_BOOT_LABEL}" "${FILESYSTEM_BOOT_DEVICE}"

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Creating and mounting root file system...                             -"
echo "-------------------------------------------------------------------------"

FILESYSTEM_ROOT_FLAGS="noatime,nodiratime"

if [ "${FILESYSTEM_FORMAT,,}" == "btrfs" ]; then
  FILESYSTEM_ROOT_FLAGS="${FILESYSTEM_ROOT_FLAGS},compress=${FILESYSTEM_ROOT_BTRFS_COMPRESSION},discard=async,ssd"
  modprobe "btrfs"
  mkfs.btrfs --force --label "${FILESYSTEM_ROOT_LABEL}" "${FILESYSTEM_ROOT_DEVICE}"
  mount -o "${FILESYSTEM_ROOT_FLAGS}" "${FILESYSTEM_ROOT_DEVICE}" "/mnt"
  btrfs subvolume create "/mnt/${FILESYSTEM_ROOT_BTRFS_VOLUME_ROOT}"
  btrfs subvolume create "/mnt/${FILESYSTEM_ROOT_BTRFS_VOLUME_HOME}"
  umount "/mnt"
  mount -o "${FILESYSTEM_ROOT_FLAGS},subvol=${FILESYSTEM_ROOT_BTRFS_VOLUME_ROOT}" "${FILESYSTEM_ROOT_DEVICE}" "/mnt"
  mkdir "/mnt/home"
  mount -o "${FILESYSTEM_ROOT_FLAGS},subvol=${FILESYSTEM_ROOT_BTRFS_VOLUME_HOME}" "${FILESYSTEM_ROOT_DEVICE}" "/mnt/home"
elif [ "${FILESYSTEM_FORMAT,,}" == "ext4" ]; then
  FILESYSTEM_ROOT_FLAGS="${FILESYSTEM_ROOT_FLAGS},discard"
  mkfs.ext4 -F -L "${FILESYSTEM_ROOT_LABEL}" "${FILESYSTEM_ROOT_DEVICE}"
  tune2fs -i ${FILESYSTEM_ROOT_EXT4_FSCK_INTERVAL} "${FILESYSTEM_ROOT_DEVICE}"
  mount -o "${FILESYSTEM_ROOT_FLAGS}" "${FILESYSTEM_ROOT_DEVICE}" "/mnt"
else
  echo "ERROR! Unknown root filesystem: ${FILESYSTEM_FORMAT}"
  exit 1
fi

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Mounting boot file system...                                          -"
echo "-------------------------------------------------------------------------"

FILESYSTEM_BOOT_FLAGS="discard,dmask=0077,fmask=0177,nodev,noexec,nosuid"

mkdir "/mnt/boot"
chmod 700 "/mnt/boot"
mount -t "vfat" -o "${FILESYSTEM_BOOT_FLAGS}" "${FILESYSTEM_BOOT_DEVICE}" "/mnt/boot"

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Recording shared variables...                                         -"
echo "-------------------------------------------------------------------------"

echo -n "${FILESYSTEM_FORMAT,,}" > "${FILESYSTEM_SHARED}/filesystem-type"

echo -n "${FILESYSTEM_BOOT_FLAGS}" > "${FILESYSTEM_SHARED}/filesystem-boot-flags"
echo -n "${FILESYSTEM_ROOT_FLAGS}" > "${FILESYSTEM_SHARED}/filesystem-root-flags"

echo -n "${FILESYSTEM_BOOT_DEVICE}" > "${FILESYSTEM_SHARED}/filesystem-boot-device"
echo -n "${FILESYSTEM_ROOT_DEVICE}" > "${FILESYSTEM_SHARED}/filesystem-root-device"

echo -n "${FILESYSTEM_ROOT_BTRFS_VOLUME_ROOT}" > "${FILESYSTEM_SHARED}/filesystem-root-btrfs-subvolume-root"
echo -n "${FILESYSTEM_ROOT_BTRFS_VOLUME_HOME}" > "${FILESYSTEM_SHARED}/filesystem-root-btrfs-subvolume-home"

################################################################################

echo "-------------------------------------------------------------------------"
echo "- DONE!                                                                 -"
echo "-------------------------------------------------------------------------"

################################################################################
