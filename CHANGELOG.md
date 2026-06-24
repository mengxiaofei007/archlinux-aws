<!----------------------------------------------------------------------------->

### **3.1.6**
* **Archlinux Package Level**: 24 June 2026
* **Change**: Update pacman initial mirrorlist (version: 2026-06-10). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.1.5**
* **Archlinux Package Level**: 28 April 2026
* **Change**: Update pacman initial mirrorlist (version: 2026-04-06). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.1.4**
* **Archlinux Package Level**: 7 April 2026
* **Remove**: Remove explicit installation of `iptables-nft` as it is now default. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.1.3**
* **Archlinux Package Level**: 2 March 2026
* **Change**: Update pacman initial mirrorlist (version: 2026-02-13). - [Rich Lees]
* **Change**: Update initial trusted Archlinux key for keyring initialisation. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.1.2**
* **Archlinux Package Level**: 25 January 2026
* **Change**: Update pacman initial mirrorlist (version: 2026-01-05). - [Rich Lees]
* **Change**: Update initial trusted Archlinux key for keyring initialisation. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.1.1**
* **Archlinux Package Level**: 28 December 2025
* **Change**: Package: `networkmanager` is no longer explicitly installed. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.1.0**
* **Archlinux Package Level**: 21 December 2025
* **Change**: Use **ED25519** temporary key for the builder instance. - [Rich Lees]
* **Change**: Update `pacman.conf` (only comments affected). - [Rich Lees]
* **Change**: Update pacman GPG key for the **bitservices** repository. - [Rich Lees]
* **Change**: **Logrotate** setting for **compress** now managed by package instead. - [Rich Lees]
* **Change**: Package: `aws-cli-v2` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `base` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `bitservices-core` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `btrfs-progs` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `cloud-guest-utils` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `cloud-init` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `dosfstools` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `e2fsprogs` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `f2fs-tools` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `inetutils` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `logrotate` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `neovim` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `net-tools` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `openssh` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `pacman-contrib` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `pretty-motd` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `prometheus-node-exporter` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `python` is no longer explicitly installed. - [Rich Lees]
* **Change**: Package: `sudo` is no longer explicitly installed. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.0.9**
* **Archlinux Package Level**: 11 November 2025
* **Change**: Update pacman initial mirrorlist (version: 2025-10-21). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.0.8**
* **Archlinux Package Level**: 8 September 2025

<!----------------------------------------------------------------------------->

### **3.0.7**
* **Archlinux Package Level**: 18 August 2025

<!----------------------------------------------------------------------------->

### **3.0.6**
* **Archlinux Package Level**: 4 August 2025

<!----------------------------------------------------------------------------->

### **3.0.5**
* **Archlinux Package Level**: 22 July 2025
* **Change**: Update pacman initial mirrorlist (version: 2025-07-02). - [Rich Lees]
* **Remove**: Disable `mdadm` collector for **Node Exporter**. - [Rich Lees]
* **Remove**: Disable `nfs` collector for **Node Exporter**. - [Rich Lees]
* **Remove**: Disable `pressure` collector for **Node Exporter**. - [Rich Lees]
* **Remove**: Disable `thermal_zone` collector for **Node Exporter**. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.0.4**
* **Archlinux Package Level**: 25 June 2025
* **Add**: Add the `linux-firmware-other` package. - [Rich Lees]
* **Remove**: Remove the `linux-firmware` package. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.0.3**
* **Archlinux Package Level**: 23 June 2025

<!----------------------------------------------------------------------------->

### **3.0.2**
* **Archlinux Package Level**: 9 June 2025
* **Change**: Update pacman initial mirrorlist (version: 2025-05-22). - [Rich Lees]
* **Bugfix**: Fix permissions of pacman configuration files. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.0.1**
* **Archlinux Package Level**: 21 April 2025
* **Add**: Add **btrfs** module in `mkinitcpio.conf` when BTRFS is the selected file system. - [Rich Lees]
* **Remove**: Remove the `mdadm` package. - [Rich Lees]
* **Remove**: Remove the **mdmon** binary in `mkinitcpio.conf`. - [Rich Lees]
* **Remove**: Remove the **mdadm_udev** hook in `mkinitcpio.conf`. - [Rich Lees]
* **Remove**: Remove the **filesystems** hook in `mkinitcpio.conf`. - [Rich Lees]
* **Remove**: Remove the **/etc/os-release** file in `mkinitcpio.conf` since its no longer required. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **3.0.0**
* **Archlinux Package Level**: 24 March 2025
* **Add**: A FAT32 **EFI** partition (**EF00**) with label **ARCH_BOOT** that is **512 MB** and mounted at `/boot/`. - [Rich Lees]
* **Add**: Add the following mount options for the **EFI** file system: `discard`, `dmask=0077`, `fmask=0177`, `nodev`, `noexec` and `nosuid`. - [Rich Lees]
* **Add**: Add the following mount options for the root **BTRFS** file sytem: `noatime` and `nodiratime`. - [Rich Lees]
* **Add**: Add the following mount options for the root file system when built with **EXT4**: `noatime` and `nodiratime`. - [Rich Lees]
* **Add**: Add the `e2fsprogs` package. - [Rich Lees]
* **Add**: Add the `neovim` package. - [Rich Lees]
* **Add**: Add `systemd-boot` entry: `linux.conf`. - [Rich Lees]
* **Add**: Add time zone information: `UTC`. - [Rich Lees]
* **Change**: **Build system change! See notice below.** - [Rich Lees]
* **Change**: Use UEFI BIOS, legacy is no longer supported. - [Rich Lees]
* **Change**: The partition scheme of the generated image is now **GPT**. - [Rich Lees]
* **Change**: The root partition type is now **8304** (Linux x86-64 Root). - [Rich Lees]
* **Change**: Change the root **BTRFS** `discard` mount option to: `discard=async`. - [Rich Lees]
* **Change**: Refresh `mkinitcpio.conf` which just has some different comments. - [Rich Lees]
* **Change**: Refresh `pacman.conf`, which no longer provides the **community** repository. - [Rich Lees]
* **Change**: Change the ordering of **mkinitcpio** hooks to closer match Archlinux default. - [Rich Lees]
* **Change**: Change `cloud-init` default user shell to: `/usr/bin/bash`. - [Rich Lees]
* **Change**: Update pacman initial mirrorlist (version: 2025-03-11). - [Rich Lees]
* **Change**: Use IPv6 VPC NTP endpoint: `fd00:ec2::123`. - [Rich Lees]
* **Change**: Use **mdev** instead of **partprobe** to update kernel devices after partitioning. - [Rich Lees]
* **Change**: Use `systemd-boot` bootloader instead of `grub`. - [Rich Lees]
* **Change**: Configure `systemd-boot` with: **Editor** `disabled`, **Auto Entries** `disabled` and **Default** as `linux.conf`. - [Rich Lees]
* **Change**: Use a systemd preset to set the initial service state. - [Rich Lees]
* **Remove**: **Vagrant box is no longer provided!** - [Rich Lees]
* **Remove**: No longer manage parallel downloads and use the Archlinux default. - [Rich Lees]
* **Remove**: Remove **NoCloud** data source for `cloud-init`. - [Rich Lees]
* **Remove**: Remove the space cache v2 options for the root **BTRFS** file system as it is now default. - [Rich Lees]
* **Remove**: Remove master 'lsign' keys from final image for security reasons. - [Rich Lees]
* **Remove**: Remove some more temporary/stateful files that are not required. - [Rich Leees]
* **Remove**: Remove generated **machine-id** as it should be unique for every system. - [Rich Lees]
* **Remove**: Remove systemd network overrides (device naming and MAC address policy) that no longer seem to do anything. - [Rich Lees]
* **Remove**: Remove the `grub` package. - [Rich Lees]
* **Remove**: Remove the `vim` package. - [Rich Lees]
* **Remove**: Remove the **kms** hook in `mkinitcpio.conf` to dramatically lower initial ramdisk size (cannot boot on nano instances otherwise). - [Rich Lees]

**NOTE**: The build system is completely different - images are now created by
booting an Alpine Linux EC2 instance and installing the Archlinux installation
tools. From there, a completely fresh installation of Archlinux is set up on an
attached volume. The attached volume is later captured to form the final image.
Since the build system has no bearing on the output image, build system
configuration will no longer be maintained in documentation. Previous CHANGELOG
notes regarding the build system are no longer relevant.

For initial builder configuration, please see [README.md](README.md).

<!----------------------------------------------------------------------------->

### **2.0.13**
* **Archlinux Package Level**: 11 February 2025
* **Archlinux Boot ISO Used**: archlinux-2025.02.01-dual.iso

<!----------------------------------------------------------------------------->

### **2.0.12**
* **Archlinux Package Level**: 16 January 2025
* **Archlinux Boot ISO Used**: archlinux-2025.01.01-dual.iso
* **Change**: Update pacman initial mirrorlist (version: 2025-01-01). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **2.0.11**
* **Archlinux Package Level**: 8 November 2024
* **Archlinux Boot ISO Used**: archlinux-2024.11.01-dual.iso
* **Add**: Enable service unit `cloud-init-main.service`. - [Rich Lees]
* **Add**: Enable service unit `cloud-init-network.service`. - [Rich Lees]
* **Remove**: No longer enable deprecated service unit `cloud-init.service`. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **2.0.10**
* **Archlinux Package Level**: 1 October 2024
* **Archlinux Boot ISO Used**: archlinux-2024.10.01-dual.iso

<!----------------------------------------------------------------------------->

### **2.0.9**
* **Archlinux Package Level**: 1 September 2024
* **Archlinux Boot ISO Used**: archlinux-2024.09.01-dual.iso
* **Add**: Add package `cloud-guest-utils` to get built in support for partition resizing. - [Rich Lees]
* **Add**: Add **growpart** `cloud-init` module. - [Rich Lees]
* **Change**: Migrated to Hashicorp HCP for Vagrant box hosting. New tag is: `bitservices/archlinux64`. - [Rich Lees]
* **Remove**: Remove package `grow-root-part` as it should no longer be needed. - [Rich Lees]
* **Remove**: Remove **growrootpart** hook from `mkinitcpio.conf`. - [Rich Lees]
* **Remove**: Remove **migrator** `cloud-init` module. - [Rich Lees]

**IMPORTANT**: For Vagrant box, please use: `bitservices/archlinux64` instead.

<!----------------------------------------------------------------------------->

### **2.0.8**
* **Archlinux Package Level**: 12 August 2024
* **Archlinux Boot ISO Used**: archlinux-2024.08.01-dual.iso
* **Change**: Update pacman initial mirrorlist (version: 2024-07-17). - [Rich Lees]
* **Bugfix**: The mirrorlist region is now being set correctly - attempt 2. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v2.0.7**
* **Archlinux Package Level**: 21 June 2024
* **Archlinux Boot ISO Used**: archlinux-2024.06.01-dual.iso
* **Add**: Add `prometheus-node-exporter` package. - [Rich Lees]
* **Add**: Enabled the `prometheus-node-exporter.service` service. - [Rich Lees]
* **Change**: Disable all Prometheus Node Exporter collectors by default. - [Rich Lees]
* **Change**: Enable the following Prometheus Node Exporter collectors: `btrfs`, `cpu`, `cpufreq`, `diskstats`, `edac`, `entropy`, `filesystem`, `hwmon`, `loadavg`, 'mdadm', 'meminfo', 'netclass', 'netdev', 'netstat', 'nfs', 'nvme', 'pressure', 'stat', 'thermal_zone' and 'udp_queues'. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v2.0.6**
* **Archlinux Package Level**: 1 June 2024
* **Archlinux Boot ISO Used**: archlinux-2024.06.01-dual.iso
* **Change**: Use `aws-cli-v2-bits` package instead since `aws-cli-v2` has been demoted to the AUR. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **2.0.5**
* **Archlinux Package Level**: 1 April 2024
* **Archlinux Boot ISO Used**: archlinux-2024.04.01-dual.iso
* **Change**: Management of **makepkg** settings now done by `bitservices-core`. - [Rich Lees]

**NOTE**: Includes fixes and mitigation for:
[https://archlinux.org/news/the-xz-package-has-been-backdoored/](https://archlinux.org/news/the-xz-package-has-been-backdoored/)

<!----------------------------------------------------------------------------->

### **2.0.4**
* **Archlinux Package Level**: 20 March 2024
* **Archlinux Boot ISO Used**: archlinux-2024.03.01-dual.iso
* **Change**: Change **makepkg** option `debug` to `!debug`. - [Rich Lees]
* **Change**: Stop **makepkg** from compressing packages. - [Rich Lees]
* **Change**: Update **mkinitcpio** configuration files to latest. - [Rich Lees]
* **Bugfix**: The mirrorlist region is now being set correctly. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **2.0.3**
* **Archlinux Package Level**: 1 March 2024
* **Archlinux Boot ISO Used**: archlinux-2024.02.01-dual.iso

<!----------------------------------------------------------------------------->

### **2.0.2**
* **Archlinux Package Level**: 27 October 2023
* **Archlinux Boot ISO Used**: archlinux-2023.10.14-dual.iso
* **Change**: Builder machine now uses `5120` megabytes of memory when running in CI. - [Rich Lees]
* **Change**: Update pacman initial mirrorlist (version: 2023-10-01). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **2.0.1**
* **Archlinux Package Level**: 4 August 2023
* **Archlinux Boot ISO Used**: archlinux-2023.08.01-dual.iso
* **Change**: Update pacman initial mirrorlist (version: 2023-06-28). - [Rich Lees]
* **Change**: Builder machine now uses `TCG` acceleration when running in CI. - [Rich Lees]
* **Change**: Builder machine now uses `qemu64` CPU when running in CI. - [Rich Lees]
* **Change**: Builder machine now uses `2` CPUs. - [Rich Lees]
* **Change**: Builder machine now uses `2048` megabytes of memory (`10240` when running in CI). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **2.0.0**
* **Archlinux Package Level**: 25 July 2023
* **Archlinux Boot ISO Used**: archlinux-2023.07.01-dual.iso
* **Add**: Vagrant box for the `libvirt` provider. - [Rich Lees]
* **Add**: Do not pacstrap during build until **Pacman** is fully initialised with a `300` second timeout. - [Rich Lees]
* **Change**: Use **QEMU** as the base builder instead of **VirtualBox**. - [Rich Lees]
* **Change**: Builder machine uses `Q35` chipset instead of `PIIX3`. - [Rich Lees]
* **Change**: Builder machine uses `virtio` controller for storage instead of `sata`. - [Rich Lees]
* **Change**: Builder machine uses `writeback` caching for storage. - [Rich Lees]
* **Change**: Builder machine uses compression for storage. - [Rich Lees]
* **Change**: Builder machine uses `qcow2` format for storage. - [Rich Lees]
* **Change**: Builder machine uses `virtio-net` in `user` mode for networking. - [Rich Lees]
* **Change**: Builder machine uses `virtio` display adapter. - [Rich Lees]
* **Change**: Builder machine has the TPM explicitly disabled. - [Rich Lees]
* **Change**: Builder machine uses the QEMU defaults for audio. - [Rich Lees]
* **Change**: Builder machine uses the QEMU defaults for USB. - [Rich Lees]
* **Change**: Use `zstd` instead of `lzo` for **BTRFS** compression. - [Rich Lees]
* **Remove**: NoCloud cloud-init data no longer provided with Vagrant box. You MUST provide one yourself or login won't be possible! - [Rich Lees]
* **Remove**: Vagrant box for the `virtualbox` provider. - [Rich Lees]
* **Remove**: Remove `virtualbox-guest-utils-nox` package from Vagrant box. - [Rich Lees]
* **Remove**: NetworkManager exception to `enp0s8` on the Vagrant box. NetworkManager will now manage all interfaces. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v1.0.3**
* **Archlinux Package Level**: 24 June 2023
* **Archlinux Boot ISO Used**: archlinux-2023.06.01-dual.iso
* **Add**: Add `aws-cli-v2` package. - [Rich Lees]
* **Add**: Add **reflector** pacman hook to refresh mirror lists automatically. - [Rich Lees]
* **Add**: Retain the **kms** hook in `mkinitcpio.conf` since GPU instances might need it. - [Rich Lees]
* **Change**: Use `bitservices-core` package to manage some previously manually managed settings. - [Rich Lees]
* **Change**: Put EC2 NTP configuration into `timesyncd.conf.d` folder. No tangible change. - [Rich Lees]
* **Change**: Refresh `linux.preset` file for **mkinitcpio**. No tangible change. - [Rich Lees]
* **Change**: Update pacman initial mirrorlist (version: 2023-04-10). - [Rich Lees]
* **Change**: Refresh `pacman.conf`. No tangible change. - [Rich Lees]
* **Remove**: Remove `aws-cli` package. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **1.0.2**
* **Archlinux Package Level**: 13 February 2023
* **Archlinux Boot ISO Used**: archlinux-2023.02.01-dual.iso

<!----------------------------------------------------------------------------->

### **1.0.1**
* **Archlinux Package Level**: 4 December 2022
* **Archlinux Boot ISO Used**: archlinux-2022.12.01-dual.iso
* **Change**: Update pacman mirrorlist (version: 2022-12-04). - [Rich Lees]
* **Change**: Update `mkinitcpio.conf` from latest Archlinux. - [Rich Lees]
* **Change**: Update `cloud.cfg` from latest Archlinux. - [Rich Lees]
* **Add**: Add file `/etc/os-release` to **mkinitcpio** files. - [Rich Lees]
* **Add**: Add **migrator** `cloud-init` module. - [Rich Lees]
* **Add**: Add **seed_random** `cloud-init` module. - [Rich Lees]
* **Add**: Add **mounts** `cloud-init` module. - [Rich Lees]
* **Add**: Add **uucp** to the default users groups using `cloud-init`. - [Rich Lees]
* **Change**: Change **datasource_list** format in `cloud.cfg` for increased compatibility. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **1.0.0**
* **Archlinux Package Level**: 2 November 2022
* **Archlinux Boot ISO Used**: archlinux-2022.11.01-dual.iso
* **Add**: Add `discard` mount option for disks during provisioning. - [Rich Lees]
* **Add**: Add `ssd` mount option for disks during provisioning (BTRFS only). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **0.5.0**
* **Archlinux Package Level**: 2 November 2022
* **Archlinux Boot ISO Used**: archlinux-2022.11.01-dual.iso
* **Add**: Add `-K` parameter to **pacstrap** as per Arch Linux installation guide. - [Rich Lees]
* **Change**: Use HCL Packer scripts instead of JSON. - [Rich Lees]
* **Change**: Update pacman mirrorlist (version: 2022-10-16). - [Rich Lees]
* **Change**: Use **64** megabytes of video RAM during provisioning. -[Rich Lees]
* **Change**: Guest audio controller is now **ac97** since none is not an option. - [Rich Lees]
* **Change**: Use **boxsvga** video controller for provisioning without 3D acceleration. - [Rich Lees]
* **Change**: Configure hard disk used for provisioning as an SSD with **discard** enabled. - [Rich Lees]
* **Remove**: Remove step to fill disk with zeros since we are using **discard** mode now. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.4.1**
* **Archlinux Package Level**: 10 January 2022
* **Archlinux Boot ISO Used**: archlinux-2022.01.01-dual.iso
* **Add**: Add a `partprobe` step after creating partitions and file systems since this no longer seems to be updated automatically. - [Rich Lees]
* **Change**: Revert system volume size back to 3 GB. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.4.0**
* **Archlinux Package Level**: 10 January 2022
* **Archlinux Boot ISO Used**: archlinux-2022.01.01-dual.iso
* **Add**: Set `match` directive to match all original network interfaces in `99-default.link`. - [Rich Lees]
* **Add**: Set `NamePolicy` directive in `99-default.link` to match Archlinux defaults. - [Rich Lees]
* **Add**: Set `AlternativeNamesPolicy` directive in `99-default.link` to match Archlinux defaults. - [Rich Lees]
* **Change**: NetworkManager now manages all network interfaces (except `enp0s8` on the Vagrant box build). - [Rich Lees]
* **Change**: Increase system volume size to 5 GB. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.3.7**
* **Archlinux Package Level**: 10 January 2022
* **Archlinux Boot ISO Used**: archlinux-2022.01.01-dual.iso
* **Change**: Configure `cloud-init` to only generate an `ed25519` SSH host key. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.3.6**
* **Archlinux Package Level**: 10 January 2022
* **Archlinux Boot ISO Used**: archlinux-2022.01.01-dual.iso
* **Change**: Update pacman mirrorlist (version: 2021-12-12). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.3.5**
* **Archlinux Package Level**: 01 October 2021
* **Archlinux Boot ISO Used**: archlinux-2021.09.01-dual.iso
* **Change**: Update pacman mirrorlist (version: 2021-08-22). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.3.4**
* **Archlinux Package Level**: 13 July 2021
* **Archlinux Boot ISO Used**: archlinux-2021.07.01-dual.iso
* **Change**: Update pacman mirrorlist (version: 2021-05-09). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.3.3**
* **Archlinux Package Level**: 01 June 2021
* **Archlinux Boot ISO Used**: archlinux-2021.06.01-dual.iso
* **Add**: Enable pacman option `ParallelDownloads` and set the limit to `3` since any more would kill most DSL connections. - [Rich Lees]
* **Remove**: Remove pacman option `TotalDownload` as it no longer exists for pacman 6. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.3.2**
* **Archlinux Package Level**: 17 May 2021
* **Archlinux Boot ISO Used**: archlinux-2021.05.01-dual.iso
* **Remove**: Remove package `virtualbox-guest-dkms` from Vagrant box as it no longer exists. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.3.1**
* **Archlinux Package Level**: 20 April 2021
* **Archlinux Boot ISO Used**: archlinux-2021.04.01-dual.iso
* **New**: Trust BITServices packaging singing key `7FC5C97F4044C19A` (bitservices-packages.asc). - [Rich Lees]
* **New**: Add `bitservices` repo to pacman. - [Rich Lees]
* **New**: Add `pretty-motd` bitservices package. - [Rich Lees]
* **Change**: Enable pacman options `Color` and `TotalDownload`. - [Rich Lees]
* **Change**: Install `grow-root-part` from the bitservices repo rather than as a manual download. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.3.0**
* **Archlinux Package Level**: 17 April 2021
* **Archlinux Boot ISO Used**: archlinux-2021.04.01-dual.iso
* **New**: NTP is now enabled using `systemd-timesyncd`. - [Rich Lees]
* **New**: Configure `cloud-init` to lock the default users password. - [Rich Lees]
* **New**: Use the built-in Amazon Web Services NTP server. - [Rich Lees]
* **Change**: Update pacman mirrorlist (version: 2021-04-05). - [Rich Lees]
* **Change**: Use the `kyber` scheduler for non-rotational NVMe disks. - [Rich Lees]
* **Change**: Use `CIDATA` instead of `cidata` as the label for the NoCloud volume used by the Vagrant box. - [Rich Lees]
* **Change**: Change AMI name format, to allow easier filtering on kernel name. - [Rich Lees]
* **Change**: Include architecture in the AMI name. - [Rich Lees]
* **Remove**: No longer provide Artemis images.
* **Remove**: Remove package: `netctl` due to it no longer being required for networking. - [Rich Lees]
* **Remove**: Remove package: `python-pyopenssl` as Ansible working out the box is no longer a project aim. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.27**
* **Archlinux Package Level**: 17 June 2020
* **Archlinux Boot ISO Used**: archlinux-2020.06.01-dual.iso
* **Artemis Version**: v3.0.0

<!----------------------------------------------------------------------------->

### **v0.2.26**
* **Archlinux Package Level**: 06 April 2020
* **Archlinux Boot ISO Used**: archlinux-2020.04.01-dual.iso
* **Artemis Version**: v3.0.0

<!----------------------------------------------------------------------------->

### **v0.2.25**
* **Archlinux Package Level**: 24 February 2020
* **Archlinux Boot ISO Used**: archlinux-2020.02.01-dual.iso
* **Artemis Version**: v3.0.0
* **Change**: Update pacman mirrorlist (version: 2020-02-07). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.24**
* **Archlinux Package Level**: 06 January 2020
* **Archlinux Boot ISO Used**: archlinux-2020.01.01-dual.iso
* **Artemis Version**: v3.0.0
* **New**: Include the following packages following the Arch Linux **base** meta-package change: `inetutils`. - [Rich Lees]
* **Change**: Update pacman mirrorlist (version: 2020-01-03). - [Rich Lees]
* **Change**: Use official `cloud-init` package now that it is available again. - [Rich Lees]
* **Bugfix**: Comment out United Kingdom mirrors so only worldwide mirrors are selected. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.23**
* **Archlinux Package Level**: 13 October 2019
* **Archlinux Boot ISO Used**: archlinux-2019.10.01-dual.iso
* **Artemis Version**: v3.0.0
* **New**: Include the following packages following the Arch Linux **base** meta-package change: `linux`, `linux-firmware`, `logrotate`, `netctl`. - [Rich Lees]
* **Change**: Update pacman mirrorlist (version: 2019-10-01). - [Rich Lees]
* **Change**: Only use **https** enabled **worldwide** mirrors. - [Rich Lees]
* **Remove**: No longer disable `sshd.socket` as it no longer ships with Arch Linux. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.22**
* **Archlinux Package Level**: 10 September 2019
* **Archlinux Boot ISO Used**: archlinux-2019.09.01-dual.iso
* **Artemis Version**: v3.0.0
* **Change**: Update pacman mirrorlist (version: 2019-08-21). - [Rich Lees]
* **Change**: Artemis now uses the **rlees85** fork. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.21**
* **Archlinux Package Level**: 04 August 2019
* **Archlinux Boot ISO Used**: archlinux-2019.08.01-dual.iso
* **Artemis Version**: archlinux (unreleased)

<!----------------------------------------------------------------------------->

### **v0.2.20**
* **Archlinux Package Level**: 19 July 2019
* **Archlinux Boot ISO Used**: archlinux-2019.07.01-dual.iso
* **Artemis Version**: archlinux (unreleased)
* **New**: Include `pacman-contrib` package. - [Rich Lees]
* **New**: Include `aws-cli` package. - [Rich Lees]
* **Change**: Update pacman mirrorlist (version: 2019-06-14). - [Rich Lees]
* **Remove**: No longer use custom `journald.conf` with custom **SystemMaxUse** setting. - [Rich Lees]
* **Remove**: No longer use custom `cloud-init.service`. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.19**
* **Archlinux Package Level**: 10 May 2019
* **Archlinux Boot ISO Used**: archlinux-2019.05.02-dual.iso
* **Artemis Version**: archlinux (unreleased)
* **New**: Include `python-pyopenssl` package. - [Rich Lees]
* **New**: Add `cloud-init` module **update_hostname** to run during the **init** stage. - [Rich Lees]
* **Change**: Change `cloud-init` configuration **Preserve Hostname** to **Disabled**. - [Rich Lees]
* **Change**: Change `cloud-init` configuration **SSH Service Name** to **sshd**. - [Rich Lees]
* **Change**: Change `cloud-init` default user group membership to include **adm**, **audio**, **floppy** and **ideo**. - [Rich Lees]
* **Change**: Remove `cloud-init` logging override configuration and just use defaults. - [Rich Lees]
* **Change**: Amend `ebsnvme-id` script to work with **Python 3**. - [Rich Lees]
* **Remove**: Remove `python2` package. - [Rich Lees]
* **Remove**: Remove `python2-pyopenssl` package. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.18**
* **Archlinux Package Level**: 02 April 2019
* **Archlinux Boot ISO Used**: archlinux-2019.04.01-dual.iso
* **Artemis Version**: archlinux (unreleased)
* **Change**: For all AMIs the primary hard disk size has been increased to `3GB` by default. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.17**
* **Archlinux Package Level**: 06 March 2019
* **Archlinux Boot ISO Used**: archlinux-2019.03.01-dual.iso
* **Artemis Version**: archlinux (unreleased)

<!----------------------------------------------------------------------------->

### **v0.2.16**
* **Archlinux Package Level**: 12 February 2019
* **Archlinux Boot ISO Used**: archlinux-2019.02.01-dual.iso
* **Artemis Version**: archlinux (unreleased)
* **Change**: Update pacman mirrorlist (version: 2019-01-09). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.15**
* **Archlinux Package Level**: 02 January 2019
* **Archlinux Boot ISO Used**: archlinux-2019.01.01-dual.iso
* **Artemis Version**: archlinux (unreleased)

<!----------------------------------------------------------------------------->

### **v0.2.14**
* **Archlinux Package Level**: 24 December 2018
* **Archlinux Boot ISO Used**: archlinux-2018.12.01-dual.iso
* **Artemis Version**: archlinux (unreleased)
* **Change**: Update pacman mirrorlist (version: 2018-12-05). - [Rich Lees]
* **Change**: Replace `growfs` files/hook with `grow-root-part` external package. - [Rich Lees]
* **Change**: Add `systemd`, `sd-vconsole`, `growrootpart` hooks and remove `udev`, `keymap`, `growfs` hooks from initramfs. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.13**
* **Archlinux Package Level**: 01 December 2018
* **Archlinux Boot ISO Used**: archlinux-2018.12.01-dual.iso
* **Artemis Version**: archlinux (unreleased)
* **Change**: `mkfs.vfat` now requires the **-I** parameter to create the Vagrant NoCloud configuration disk in superfloppy mode. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.12**
* **Archlinux Package Level**: 13 October 2018
* **Archlinux Boot ISO Used**: archlinux-2018.10.01-dual.iso
* **Artemis Version**: archlinux (unreleased)
* **Change**: Update pacman mirrorlist (version: 2018-09-12). - [Rich Lees]
* **Change**: Use the worldwide mirrors. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.11**
* **Archlinux Package Level**: 01 September 2018
* **Archlinux Boot ISO Used**: archlinux-2018.09.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **Change**: Add `keymap` hook and remove `shutdown` hook from initramfs. - [Rich Lees]
* **Change**: Artemis AMIs now have a much more sensible **login.defs** UMASK `077` - [Rich Lees]
* **Change**: Artemis AMIs now have the timezone set to `UTC` - [Rich Lees]
* **Bugfix**: Fix `growfs` hook to work with NVMe devices. - [Rich Lees]
* **Bugfix**: Fixed bug where Artemis AMIs have IPv6 router advertisements disabled - [Rich Lees]
    * sysctl parameter `net.ipv6.conf.all.accept_ra` now set to **1**
    * sysctl parameter `net.ipv6.conf.default.accept_ra` now set to **1**

<!----------------------------------------------------------------------------->

### **v0.2.10**
* **Archlinux Package Level**: 04 July 2018
* **Archlinux Boot ISO Used**: archlinux-2018.07.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **New**: Include Amazon EBS friendly name rules for NVMe disks (EC2 AMIs only) - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.9**
* **Archlinux Package Level**: 02 June 2018
* **Archlinux Boot ISO Used**: archlinux-2018.06.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **Change**: Update pacman mirrorlist (version: 2018-05-24). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.8**
* **Archlinux Package Level**: 08 May 2018
* **Archlinux Boot ISO Used**: archlinux-2018.05.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **New**: Include `python2-pyopenssl` package to allow **OpenSSL** modules in **Ansible**. - [Rich Lees]
* **Change**: Update pacman mirrorlist (version: 2018-04-15). - [Rich Lees]
* **Change**: **Artemis** AMIs now configure NTPD to use the AWS timeserver: `169.254.169.123`. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.7**
* **Archlinux Package Level**: 09 April 2018
* **Archlinux Boot ISO Used**: archlinux-2018.04.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **New**: Include **Network Manager** to manage **eth0** (allows for IPv6). - [Rich Lees]
* **New**: **BTRFS** root volumes are checked with `btrfs check` at build time. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.6**
* **Archlinux Package Level**: 03 April 2018
* **Archlinux Boot ISO Used**: archlinux-2018.04.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **Change**: Update pacman mirrorlist (version: 2018-02-24). - [Rich Lees]
* **Change**: Update the **growpart** binary. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.5**
* **Archlinux Package Level**: 06 March 2018
* **Archlinux Boot ISO Used**: archlinux-2018.03.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **New**: Set `vm.swappiness` to **25** on all images. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.4**
* **Archlinux Package Level**: 02 February 2018
* **Archlinux Boot ISO Used**: archlinux-2018.02.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **Change**: Switch top two UK mirrors due to recent issues with bytemark. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.3**
* **Archlinux Package Level**: 02 January 2018
* **Archlinux Boot ISO Used**: archlinux-2018.01.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **Change**: Update pacman mirrorlist (version: 2017-12-03). - [Rich Lees]
* **Change**: All AMIs have flag set for **SR-IOV** and **Amazon ENA** support. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.2**
* **Archlinux Package Level**: 02 December 2017
* **Archlinux Boot ISO Used**: archlinux-2017.12.01-dual.iso
* **Artemis Version**: v2.1.0-archlinux
* **Change**: Update pacman mirrorlist (version: 2017-10-27). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **v0.2.1**
* **Archlinux Package Level**: 01 November 2017
* **Archlinux Boot ISO Used**: archlinux-2017.11.01-dual.iso
* **Artemis Version**: v2.0.0-archlinux
* **Change**: Update `mkinitcpio.conf` format. - [Rich Lees]

**Note**: With this release, due to Artemis not having a release yet that is compatible with
OpenSSH 7.6, the Artemis AMIs with this release are limited (by overrides) to using the following
SSH daemon MACs:

* hmac-sha2-512-etm@openssh.com
* hmac-sha2-256-etm@openssh.com

<!----------------------------------------------------------------------------->

### **v0.2.0**
* **Archlinux Package Level**: 01 October 2017
* **Archlinux Boot ISO Used**: archlinux-2017.10.01-dual.iso
* **Artemis Version**: v2.0.0-archlinux
* **New**: EC2 AMIs are now provided in `eu-west-1` and `eu-west-2` regions. - [Rich Lees]
* **New**: EC2 with [Artemis](https://github.com/travisperkins/artemis) AMIs are now provided in `eu-west-1` and `eu-west-2` regions with the following security modes: `standard`, `balanced` and `enhanced`. - [Rich Lees]
* **New**: For all AMIs the primary hard disk is now `2GB` by default. - [Rich Lees]
* **New**: `cloud-init` is now included. See note below. - [Rich Lees]
* **New**: The Vagrant box now includes a 10MB NoCloud configuration disk. This may break existing scripts that expect to see any user added disks on `/dev/sdb`. - [Rich Lees]
* **New**: Inclusion of customised `growfs` mkinitcpio hook and supporting files to resize partitions (not filesystems) on boot. - [Rich Lees]
* **Change**: The default SSH username is now: `archlinux`. - [Rich Lees]
* **Change**: Default user (`archlinux`) configuration is now done entirely by `cloud-init`. - [Rich Lees]
* **Change**: Network interfaces now use old kernel names such as `eth0`. - [Rich Lees]
* **Change**: Network MAC address policy is now `none` which uses kernel defaults. - [Rich Lees]
* **Change**: Netctl profile for default network interface (`eth0`) is now called `Default NAT`. - [Rich Lees]
* **Change**: SSHD password authentication is now disabled. - [Rich Lees]
* **Change**: The SATA controller now has a total of `6` ports. - [Rich Lees]
* **Change**: Update pacman mirrorlist (version: 2017-09-07). - [Rich Lees]

**Note**: `cloud-init` that is now included has the Archlinux default configuration with the following changes:
* **Disable Root**: Enabled
* **Preserve Hostname**: Enabled
* **Resize Root Filesystem**: Enabled
* **SSH Password Auth**: Disabled
* **Generated SSH Host Key Types**: ed25519, rsa, ecdsa, dsa
* **Distribution**: arch
* **Default User**: archlinux
    * **Friendly Name**: Archlinux
    * **Groups**: wheel, users
    * **Sudo**: ALL=(ALL) NOPASSWD:ALL
    * **Shell**: /bin/bash
* **Modules**:
    * **Init**: resizefs
    * **Init**: bootcmd
    * **Init**: write-files
    * **Init**: set_hostname
    * **Init**: users-groups
    * **Init**: ssh
    * **Config**: set_passwords
    * **Config**: runcmd
    * **Final**: rightscale_userdata
    * **Final**: scripts-per-once
    * **Final**: scripts-per-boot
    * **Final**: scripts-per-instance
    * **Final**: scripts-user
    * **Final**: ssh-authkey-fingerprints
    * **Final**: keys-to-console
    * **Final**: final-message
* **Networking**: Management by cloud-init disabled
* **Datasources**: NoCloud, Ec2, None
* **Logging**: To file `/var/log/cloud-init.log`, level `INFO`
* **Output**: To file `/var/log/cloud-init-output.log`, level `INFO`

<!----------------------------------------------------------------------------->

### **0.1.8**
* **Archlinux Package Level**: 01 September 2017
* **Archlinux Boot ISO Used**: archlinux-2017.09.01-dual.iso
* **Change**: Update pacman mirrorlist (version: 2017-07-29). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **0.1.7**
* **Archlinux Package Level**: 01 August 2017
* **Archlinux Boot ISO Used**: archlinux-2017.08.01-dual.iso
* **Change**: Update pacman mirrorlist (version: 2017-07-14). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **0.1.6**
* **Archlinux Package Level**: 01 July 2017
* **Archlinux Boot ISO Used**: archlinux-2017.07.01-dual.iso

<!----------------------------------------------------------------------------->

### **0.1.5**
* **Archlinux Package Level**: 01 June 2017
* **Archlinux Boot ISO Used**: archlinux-2017.06.01-dual.iso
* **Change**: Update pacman mirrorlist (version: 2017-04-27). - [Rich Lees]

<!----------------------------------------------------------------------------->

### **0.1.4**
* **Archlinux Package Level**: 06 May 2017
* **Archlinux Boot ISO Used**: archlinux-2017.05.01-dual.iso

<!----------------------------------------------------------------------------->

### **0.1.3**
* **Archlinux Package Level**: 03 April 2017
* **Archlinux Boot ISO Used**: archlinux-2017.04.01-dual.iso
* **New**: The installer scripts can now be configured to choose the root filesystem type. Supported options for now are `BTRFS` and `EXT4`. - [Rich Lees]
* **Change**: The default root filesystem type for the Vagrant box is now `BTRFS` with root `@` and home `@home` subvolumes. - [Rich Lees]
* **Change**: Include `f2fs-tools` package in the Vagrant box. - [Rich Lees]
* **Change**: Packer script uses `SHA1` instead of `SHA256` to verify checksums due to the `SHA1` sum being available on the Archlinux downloads page. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **0.1.2**
* **Archlinux Package Level**: 01 March 2017
* **Archlinux Boot ISO Used**: archlinux-2017.03.01-dual.iso

<!----------------------------------------------------------------------------->

### **0.1.1**
* **Archlinux Package Level**: 02 February 2017
* **Archlinux Boot ISO Used**: archlinux-2017.02.01-dual.iso

<!----------------------------------------------------------------------------->

### **0.1.0**
* **Archlinux Package Level**: 01 January 2017
* **Archlinux Boot ISO Used**: archlinux-2017.01.01-dual.iso
* **New**: Use of **Packer** https://www.packer.io/ to automate creation of this Vagrant box. This will cause subtle changes to previous releases such as the file name of the included primary hard disk VMDK image. - [Rich Lees]
* **New**: Ensure the cable is marked as connected to the NAT virtual NIC. - [arivarton]
* **Change**: The firmware type is now explicitly set to `BIOS` whereas before the VirtualBox default was used. - [Rich Lees]
* **Change**: Chipset is now explicitly set to `PIIX3`. - [Rich Lees]
* **Change**: ACPI is now explicitly `enabled`. - [Rich Lees]
* **Change**: I/O APIC is now explicitly `enabled`. - [Rich Lees]
* **Change**: CPU Hotplugging is now explicitly `disabled`. This allows easier automatic customisation by users of this Vagrant box by using a `Vagrantfile`. - [Rich Lees]
* **Change**: RTC (clock) use UTC is now explicitly `enabled`. - [Rich Lees]
* **Change**: Video Capture is now explicitly `disabled`. - [Rich Lees]
* **Change**: Video Remote Display is now explicitly `disabled`. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **0.0.3**
* **Archlinux Package Level**: 02 December 2016
* **Archlinux Boot ISO Used**: archlinux-2016.12.01-dual.iso

<!----------------------------------------------------------------------------->

### **0.0.2**
* **Archlinux Package Level**: 18 November 2016
* **Archlinux Boot ISO Used**: archlinux-2016.11.01-dual.iso
* **New**: Box comes with cleared pacman cache to reduce box size. - [Rich Lees]
* **Change**: Change name of floppy disk controller to: `FDD Controller`. - [Rich Lees]
* **Change**: Change name of optical disk IDE controller to: `ODD Controller`. - [Rich Lees]

<!----------------------------------------------------------------------------->

### **0.0.1**
* **Archlinux Package Level**: 17 November 2016
* **Archlinux Boot ISO Used**: archlinux-2016.11.01-dual.iso
* **New**: rlees85/archlinux64 Vagrant box initial release. - [Rich Lees]

<!----------------------------------------------------------------------------->

[Rich Lees]: https://gitlab.com/rlees85
[arivarton]: https://gitlab.com/arivarton
