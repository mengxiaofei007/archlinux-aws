################################################################################

variable "role" {}

################################################################################

variable "name"           { default = "archlinux64" }
variable "kernel"         { default = "linux"       }
variable "architecture"   { default = "x86_64"      }
variable "virtualisation" { default = "hvm"         }

################################################################################

variable "description" { default = "An Archlinux x86-64 box with a focus on being as simple and automation-friendly as possible." }

################################################################################

variable "ena"       { default =   true    }
variable "bios"      { default =   "uefi"  }
variable "sriov"     { default =   true    }
variable "groups"    { default = [ "all" ] }
variable "overwrite" { default =   true    }

################################################################################

variable "provision_files_path"  { default = "/tmp/packer_files"  }
variable "provision_shared_path" { default = "/tmp/packer_shared" }

################################################################################

variable "region_build"  { default =   "eu-west-1"   }
variable "region_copies" { default = [ "eu-west-2" ] }

################################################################################

variable "storage_name"    { default = "/dev/xvda" }
variable "storage_keep"    { default = false       }
variable "storage_tier"    { default = "standard"  }
variable "storage_type"    { default = "ebs"       }
variable "storage_mount"   { default = "/dev/xvdb" }
variable "storage_format"  { default = "btrfs"     }
variable "storage_size_gb" { default = 3           }

################################################################################

variable "storage_partition_boot" { default = "p1" }
variable "storage_partition_root" { default = "p2" }

################################################################################

locals {
  name    = format("%s/%s/%s/%s/%s", var.name, var.kernel, var.architecture, var.virtualisation, var.storage_type)
  session = format("%s-aws", var.name)
}

################################################################################

build {
  sources = [
    "source.amazon-ebssurrogate.object"
  ]

  provisioner "shell" {
    script = format("%s/scripts/init.sh", path.root)
  }

  provisioner "shell" {
    inline = [
      format("mkdir \"%s\"", var.provision_files_path),
      format("mkdir \"%s\"", var.provision_shared_path)
    ]
  }

  provisioner "file"{
    source      = format("%s/files/", path.root)
    destination = var.provision_files_path
  }

  provisioner "shell" {
    script          = format("%s/scripts/dependencies.sh", path.root)
    execute_command = format("doas '{{ .Path }}'")
  }

  provisioner "shell" {
    script          = format("%s/scripts/partition.sh", path.root)
    execute_command = format("doas '{{ .Path }}' -d '%s' -s '%s'", var.storage_mount, var.provision_shared_path)
  }

  provisioner "shell" {
    script          = format("%s/scripts/filesystem.sh", path.root)
    execute_command = format("doas '{{ .Path }}' -a '%s' -f '%s' -q '%s' -s '%s'", var.storage_partition_boot, var.storage_format, var.storage_partition_root, var.provision_shared_path)
  }

  provisioner "shell" {
    script          = format("%s/scripts/install.sh", path.root)
    execute_command = format("doas '{{ .Path }}' -f '%s'", var.provision_files_path)
  }

  provisioner "shell" {
    script          = format("%s/scripts/configure.sh", path.root)
    execute_command = format("doas '{{ .Path }}' -f '%s' -s '%s'", var.provision_files_path, var.provision_shared_path)
  }

  provisioner "shell" {
    script          = format("%s/scripts/cleanup.sh", path.root)
    execute_command = format("doas '{{ .Path }}' -s '%s'", var.provision_shared_path)
  }
}

################################################################################
