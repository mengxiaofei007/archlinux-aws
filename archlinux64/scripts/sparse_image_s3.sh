#!/bin/bash -e
#
# A script that takes a VMDK image and writes it out to an intermediate file
# or volume. It then sparsely copies the intermediate to the final volume.
#
# The final snapshot can then be used as a cost effective EBS snapshot forming
# the base of an AMI image.
#
###############################################################################

set -o pipefail

###############################################################################

PS_REQUIRED_PACKAGES="ddpt qemu-img"

###############################################################################

echo "------------------------------------------------------------------------"
echo "- EBS Surrogate Volume Preparation Script                              -"
echo "------------------------------------------------------------------------"

PS_S3_VMDK_URL=""
PS_INTERMEDIATE=""
PS_VOLUME_FINAL=""

while getopts "i:f:s:" PS_OPT; do
  case ${PS_OPT} in
    i)
      PS_INTERMEDIATE="${OPTARG}"
      ;;
    f)
      PS_VOLUME_FINAL="${OPTARG}"
      ;;
    s)
      PS_S3_VMDK_URL="${OPTARG}"
      ;;
  esac
done


if [ -z "${PS_INTERMEDIATE}" ]; then echo "FAIL: No intermediate specified (-i)!"                    ; exit 1; fi
if [ -z "${PS_VOLUME_FINAL}" ]; then echo "FAIL: No final volume specified (-f)!"                    ; exit 1; fi
if [ -z "${PS_S3_VMDK_URL}"  ]; then echo "FAIL: No S3 URL to download VMDK artefact specified (-s)!"; exit 1; fi

echo "Intermediate: ${PS_INTERMEDIATE}"
echo "Final Volume: ${PS_VOLUME_FINAL}"
echo "S3 URL      : ${PS_S3_VMDK_URL}"
echo ""

###############################################################################

echo "------------------------------------------------------------------------"
echo "- Dependencies                                                         -"
echo "------------------------------------------------------------------------"

sudo amazon-linux-extras install epel

sudo yum install -y ${PS_REQUIRED_PACKAGES}

###############################################################################

echo "------------------------------------------------------------------------"
echo "- Downloading from S3                                                  -"
echo "------------------------------------------------------------------------"

PS_LOCAL_FILE="./$(basename "${PS_S3_VMDK_URL}")"

aws s3 cp --no-progress "${PS_S3_VMDK_URL}" "${PS_LOCAL_FILE}"

###############################################################################

echo "------------------------------------------------------------------------"
echo "- Extracting VMDK to Intermediate                                      -"
echo "------------------------------------------------------------------------"

sudo qemu-img convert "${PS_LOCAL_FILE}" -O raw ${PS_INTERMEDIATE}
sync

###############################################################################

echo "------------------------------------------------------------------------"
echo "- Creating Sparse Final Volume                                         -"
echo "------------------------------------------------------------------------"

sudo ddpt if=${PS_INTERMEDIATE} of=${PS_VOLUME_FINAL} bs=512 conv=sparse oflag=sparse,fsync
sync

###############################################################################

echo "------------------------------------------------------------------------"
echo "- DONE!                                                                -"
echo "------------------------------------------------------------------------"

###############################################################################
