#!/bin/bash -e
#
# Installs Archlinux ARM to the newly created and mounted file system(s).
#
################################################################################

set -o pipefail

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Checking environment...                                               -"
echo "-------------------------------------------------------------------------"

hash cp
hash cat
hash sync
hash chmod
hash mkdir
hash pidof
hash pacman
hash killall
hash pacstrap
hash pacman-key

INSTALL_FILES=""
INSTALL_TIMEOUT=120
INSTALL_KEY_ARCHLINUX="02FD1C7A934E614545849F19A6234074498E9CEE"
INSTALL_KEY_BITSERVICES="B5973EDFB21CD20B"

while getopts "a:b:f:t:" INSTALL_OPT; do
  case ${INSTALL_OPT} in
    a)
      INSTALL_KEY_ARCHLINUX="${OPTARG}"
      ;;
    b)
      INSTALL_KEY_BITSERVICES="${OPTARG}"
      ;;
    f)
      INSTALL_FILES="${OPTARG}"
      ;;
    t)
      INSTALL_TIMEOUT=${OPTARG}
  esac
done

if [   -z "${INSTALL_FILES}" ]; then echo "FAIL: No files source specified for install (-f)"            ; exit 1; fi
if [ ! -d "${INSTALL_FILES}" ]; then echo "FAIL: Files source specified for install (-f) does not exist"; exit 1; fi

echo "Install files  : ${INSTALL_FILES}"
echo "Install timeout: ${INSTALL_TIMEOUT}"
echo ""
echo "Install key archlinux  : ${INSTALL_KEY_ARCHLINUX}"
echo "Install key bitservices: ${INSTALL_KEY_BITSERVICES}"
echo ""

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Configuring pacman...                                                 -"
echo "-------------------------------------------------------------------------"

mkdir "/etc/pacman.d"

cp -fv "${INSTALL_FILES}/etc/pacman.d/mirrorlist" "/etc/pacman.d/mirrorlist"
cp -fv "${INSTALL_FILES}/etc/pacman.conf" "/etc/pacman.conf"

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Initialising keys...                                                  -"
echo "-------------------------------------------------------------------------"

pacman-key --init
pacman-key --recv-key "${INSTALL_KEY_ARCHLINUX}"
pacman-key --lsign-key "${INSTALL_KEY_ARCHLINUX}"
pacman-key --add "${INSTALL_FILES}/bitservices.asc"
pacman-key --lsign "${INSTALL_KEY_BITSERVICES}"

pacman -Sydd --noconfirm \
  archlinux-keyring

pacman-key --delete "${INSTALL_KEY_ARCHLINUX}"
pacman-key --updatedb
pacman-key --populate "archlinux"

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Installing...                                                         -"
echo "-------------------------------------------------------------------------"

pacstrap -c -M -P "/mnt"   \
  aws-cli-v2               \
  base                     \
  bitservices-core         \
  btrfs-progs              \
  cloud-guest-utils        \
  cloud-init               \
  dosfstools               \
  e2fsprogs                \
  f2fs-tools               \
  inetutils                \
  linux                    \
  linux-firmware-other     \
  linux-headers            \
  logrotate                \
  neovim                   \
  net-tools                \
  networkmanager           \
  openssh                  \
  pacman-contrib           \
  pretty-motd              \
  prometheus-node-exporter \
  python                   \
  sudo

sync

chmod 644 "/mnt/etc/pacman.conf" # Currently a bug in pacstrap.

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Terminating GPG agent...                                              -"
echo "-------------------------------------------------------------------------"

killall "gpg-agent"

INSTALL_GPG_TIMEOUT=0
while pidof "gpg-agent" && (( INSTALL_GPG_TIMEOUT++ < INSTALL_TIMEOUT )); do
  sleep 1
done

if pidof "gpg-agent"; then echo "FAIL: Timeout exceeded for GPG agent to exit"; exit 1; fi

################################################################################

echo "-------------------------------------------------------------------------"
echo "- DONE!                                                                 -"
echo "-------------------------------------------------------------------------"

################################################################################
