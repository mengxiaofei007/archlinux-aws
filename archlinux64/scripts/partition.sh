#!/bin/bash -e
#
# Sets up disk partitions ready for file system formatting.
#
################################################################################

set -o pipefail

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Checking environment...                                               -"
echo "-------------------------------------------------------------------------"

hash grep
hash mdev
hash sync
hash mount
hash sleep
hash sgdisk
hash getopts
hash realpath

PARTITION_DEVICE=""
PARTITION_SHARED=""

while getopts "d:s:" PARTITION_OPT; do
  case ${PARTITION_OPT} in
    d)
      PARTITION_DEVICE="${OPTARG}"
      ;;
    s)
      PARTITION_SHARED="${OPTARG}"
      ;;
  esac
done

if [   -z "${PARTITION_DEVICE}" ]; then echo "FAIL: No device to partition specified (-d)"                    ; exit 1; fi
if [   -z "${PARTITION_SHARED}" ]; then echo "FAIL: No shared source specified for partition (-s)"            ; exit 1; fi
if [ ! -d "${PARTITION_SHARED}" ]; then echo "FAIL: Shared source specified for partition (-s) does not exist"; exit 1; fi

echo "Partition device: ${PARTITION_DEVICE}"
echo "Partition shared: ${PARTITION_SHARED}"
echo ""

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Partitioning disk...                                                  -"
echo "-------------------------------------------------------------------------"

PARTITION_DEVICE="$(realpath "${PARTITION_DEVICE}")"
[ -n "${PARTITION_DEVICE}" ]

! mount | grep "${PARTITION_DEVICE}" > /dev/null
PARTITION_MOUNTED=${?}

if [ ${PARTITION_MOUNTED} -eq 1 ]; then
  echo "ERROR! The target device for partitioning is mounted!"
  exit 1
fi

sgdisk --zap-all "${PARTITION_DEVICE}"
sgdisk --new "0:0:+512Mib" --typecode "0:ef00" --change-name "0:boot" "${PARTITION_DEVICE}"
sgdisk --new "0:0:0" --typecode "0:8304" --change-name "0:root" "${PARTITION_DEVICE}"

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Refreshing partitions...                                              -"
echo "-------------------------------------------------------------------------"

sync
mdev -s -f

################################################################################

echo "-------------------------------------------------------------------------"
echo "- Recording shared variables...                                         -"
echo "-------------------------------------------------------------------------"

echo -n "${PARTITION_DEVICE}" > "${PARTITION_SHARED}/partition-device"

################################################################################

echo "-------------------------------------------------------------------------"
echo "- DONE!                                                                 -"
echo "-------------------------------------------------------------------------"

################################################################################
