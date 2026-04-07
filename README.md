# archlinux64

An [Archlinux] x86-64 image with a focus on being as automation-friendly as
possible. The aim is for this image to 'just work' on any platform with no
special bootstrapping or manual changes over SSH. As soon as the instance is
started it is ready for immediate provisioning with your chosen configuration
management tool.

This image is also aimed to be flexible. That means it is as close to bare
[Archlinux] as possible with just enough for it to work on cloud platforms
and for configuration management solutions to provision the instance further.
Decisions have been made with the design of this image to *try* to make it
integrate easily into complex environments.

The image is created by booting an [Alpine Linux] instance and installing the
[Archlinux] installation tools. From there, a completely fresh installation of
[Archlinux] is set up on an attached volume. The attached volume is later
captured to form the final image.

These scripts will publish an [Amazon EC2] AMI image.

--------------------------------------------------------------------------------

## Live Image Identifiers

Use the following AWS CLI commands to find the current AMI ID for this image.
All images are EBS-backed HVM AMIs.

### eu-west-1

```
aws ec2 describe-images                                         \
  --region eu-west-1                                            \
  --owners 656332075272                                         \
  --filters "Name=name,Values=archlinux64/linux/x86_64/hvm/ebs" \
  --query "Images[*].ImageId"                                   \
  --output text
```

### eu-west-2:

```
aws ec2 describe-images                                         \
  --region eu-west-2                                            \
  --owners 656332075272                                         \
  --filters "Name=name,Values=archlinux64/linux/x86_64/hvm/ebs" \
  --query "Images[*].ImageId"                                   \
  --output text
```

### Other Regions:

EC2 images are *beta*! Hence why they are only in the **EU** regions for now
and some functionality is missing. Currently GPU drivers for GPU instances are
not present.

--------------------------------------------------------------------------------

## User Accounts

This image comes with the following user accounts configured:

* **root**: Password authentication disabled and no SSH authorised keys.
* **archlinux**: Password authentication disabled, SSH key to be injected by cloud-init.

--------------------------------------------------------------------------------

## Package Manager Key

For security reasons, this image comes with the master 'lsign' key stripped.
Before running `pacman` within this image you should first generate a new master
key:

```
# pacman-key --init
```

--------------------------------------------------------------------------------

## Summary of Changes from base Archlinux

* **BIOS**: UEFI
* **Partition Scheme**: GPT
* **Root Filesystem Type**: BTRFS
    * **Label**: `ARCH_SYSTEM`
    * **Partition Type**: `8304` Linux x86-64 Root
    * **BTRFS Configuration**: 
        * **Compression**: zstd
        * **Options**:
            * discard=async
            * noatime
            * nodiratime
            * ssd
        * **Subvolumes**:
            * `@` **/**
            * `@home` **/home**
    * **EXT4 Configuration**:
        * **Check Interval**: `1m` (every 1 month)
        * **Options**:
            * discard
            * noatime
            * nodiratime
* **EFI Filesystem Type**: FAT32
    * **Label**: `ARCH_BOOT`
    * **Size**: 512 MB
    * **Partition Type**: `EF00` EFI System Partition
    * **Options**:
        * discard
        * dmask=0077
        * fmask=0177
        * nodev
        * noexec
        * nosuid
* **Packages**
    * **Pacman Options**:
        * Enabled `Color`
    * **Keys**:
        * Added `B5973EDFB21CD20B` (bitservices-packages.asc)
        * Removed master 'lsign' key
    * **Repositories**:
        * core
        * extra
        * bitservices (custom, signed)
    * **Mirrors**: Standard Archlinux mirrorlist with only **https** enabled **Worldwide** servers enabled
    * **Base Packages**:
        * [bitservices-packages-cloud]
        * linux
        * linux-firmware-other
        * linux-headers
    * **Cache**: Cleared before image capture
* **FSTAB**: Generated using `genfstab` using UUIDs
* **Hostname**: archlinux
* **Locale**:
    * **Language**: `en_GB.UTF-8`
    * **Keymap**: `uk`
* **Ramdisk**:
    * Disable fallback ramdisk
    * Include `btrfs` module (btrfs only)
    * Include `systemd` hook after `base`
    * Include `sd-vconsole` hook after `keyboard`
    * Remove `udev` hook
    * Remove `autodetect` hook
    * Remove `microcode` hook
    * Remove `kms` hook
    * Remove `keymap` hook
    * Remove `consolefont` hook
    * Remove `filesystems` hook
* **Device Manager**
    * **EC2 Only Device Manager Changes**:
        * Include Amazon EBS friendly name rules for NVMe disks
* **Cloud Init**
    * **Disable Root**: Enabled
    * **Preserve Hostname**: Disabled
    * **Resize Root Filesystem**: Enabled
    * **Distribution**: arch
    * **Default User**: archlinux
        * **Friendly Name**: Archlinux
        * **Shell**: /usr/bin/bash
        * **Sudo**: ALL=(ALL) NOPASSWD:ALL
        * **Lock Password**: Enabled
        * **Groups**:
            * adm
            * audio
            * floppy
            * users
            * uucp
            * video
            * wheel
    * **SSH Settings**:
        * **Service Name**: sshd
        * **Password Auth**: Disabled
        * **Generated SSH Host Key Types**: ed25519
    * **Modules**:
        * **Init**: `seed_random`
        * **Init**: `growpart`
        * **Init**: `resizefs`
        * **Init**: `bootcmd`
        * **Init**: `write-files`
        * **Init**: `mounts`
        * **Init**: `set_hostname`
        * **Init**: `update_hostname`
        * **Init**: `users-groups`
        * **Init**: `ssh`
        * **Config**: `set-passwords`
        * **Config**: `runcmd`
        * **Final**: `rightscale_userdata`
        * **Final**: `scripts-per-once`
        * **Final**: `scripts-per-boot`
        * **Final**: `scripts-per-instance`
        * **Final**: `scripts-user`
        * **Final**: `ssh-authkey-fingerprints`
        * **Final**: `keys-to-console`
        * **Final**: `final-message`
    * **Networking**: Management by cloud-init disabled
    * **Datasources**:
        * Ec2
        * None
* **Networking**
    * **Policies**:
        * **IPv6 Privacy**: Enabled (default)
* **Time**
    * **NTP**: Enabled
    * **Server**: `fd00:ec2::123`
    * **Zone**: UTC
* **Services**
    * Enabled `pretty-motd.service`
    * Enabled `sshd.service`
    * Enabled `systemd-timesyncd.service`
    * Enabled `NetworkManager.service`
    * Enabled `cloud-init-main.service`
    * Enabled `cloud-init-local.service`
    * Enabled `cloud-init-network.service`
    * Enabled `cloud-config.service`
    * Enabled `cloud-final.service`
    * Enabled `prometheus-node-exporter.service` (EC2 AMI only)
* **Bootloader**: systemd-boot
    * **Editor**: no
    * **Default**: linux.conf
    * **Auto Entries**: no
    * **Entries**:
        * linux.conf
* **User Accounts**
    * Root user is locked
    * Further user accounts configured with `cloud-init`
* **Metrics - EC2 AMI Only**
    * **Enabled Node Exporter Collectors**:
        * btrfs
        * cpu
        * cpufreq
        * diskstats
        * edac
        * entropy
        * filesystem
        * hwmon
        * loadavg
        * meminfo
        * netclass
        * netdev
        * netstat
        * nvme
        * stat
        * udp_queues

--------------------------------------------------------------------------------

## Builder Instance Specification

* **Operating System**: Alpine Linux
* **BIOS**: UEFI
* **Initialiser**: cloud-init
* **Packages**
    * **Pacman Options**:
        * Enabled `Color`
        * Disabled `CheckSpace`
        * Disabled `DownloadUser`
    * **Keys**:
        * Added `B5973EDFB21CD20B` (bitservices-packages.asc)
    * **Repositories**:
        * core
        * extra
        * bitservices (custom, signed)
    * **Mirrors**: Standard Archlinux mirrorlist with only **https** enabled **Worldwide** servers enabled
    * **Ensured Packages**:
        * arch-install-scripts
        * bash
        * btrfs-progs
        * dosfstools
        * e2fsprogs
        * e2fsprogs-extra
        * findmnt
        * sgdisk
* **Kernel**
    * **Ensured Modules**:
        * btrfs

--------------------------------------------------------------------------------

## How to 'Roll Your Own'

The process of creating this image has been automated as much as possible and
all code used in doing so has been uploaded into this repository.

In order to create this image on your own system, whether it be you would like
to customise the image or just for piece of mind, the process is as follows:

### Prerequisites

You will need the following:

* Access to a Linux Desktop with standard tools available such as Bash and Git.
* An [Amazon Web Services] account.
* Packer from Hashicorp: https://www.packer.io/

### Amazon AMI

1. Clone the git repository:
```
git clone https://gitlab.com/bitservices/packer/archlinux64-aws.git
```

2. Make sure you are in the correct folder to run Packer:
```
cd archlinux64-aws
```

3. Make any changes you wish to make to the packer HCL. At a minimum you will
need to change:
```
archlinux64/main.pkr.hcl: role - ARN of an IAM role that Packer can use to create a temporary EC2 instance to build the image with.
```

4. Make sure your AWS CLI configuration is correct. Make sure the following
variables are set (if required):
```
AWS_PROFILE: If you need to use non-default credentials to assume the Packer role successfully
```

5. Run Packer against the `archlinux64` folder:
```
packer build archlinux64
```

6. Observe any output or errors. If everything is successful the newly created
AMI images have their IDs printed to **stdout**.

--------------------------------------------------------------------------------

[Archlinux]:                  https://archlinux.org/
[Amazon EC2]:                 https://aws.amazon.com/ec2/
[Alpine Linux]:               https://alpinelinux.org/
[Amazon Web Services]:        https://aws.amazon.com/
[bitservices-packages-cloud]: https://gitlab.com/bitservices/archlinux/bitservices-packages
