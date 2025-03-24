################################################################################

variable "source_ami_name"   { default = "alpine-*-uefi-cloudinit-*" }
variable "source_ami_owner"  { default = "538276064493"              }
variable "source_ami_latest" { default = true                        }

################################################################################

variable "source_instance_type" { default = "m7a.medium" }

################################################################################

variable "source_ssh_timeout"   { default = "3m"         }
variable "source_ssh_username"  { default = "alpine"     }
variable "source_ssh_interface" { default = "public_dns" }

################################################################################

variable "source_storage_name"    { default = "/dev/xvda" }
variable "source_storage_keep"    { default = false       }
variable "source_storage_tier"    { default = "gp3"       }
variable "source_storage_size_gb" { default = 2           }

################################################################################

source "amazon-ebssurrogate" "object" {
  region                  = var.region_build
  ami_name                = local.name
  boot_mode               = var.bios
  ami_groups              = var.groups
  ami_regions             = var.region_copies
  ena_support             = var.ena
  ssh_timeout             = var.source_ssh_timeout
  ssh_username            = var.source_ssh_username
  instance_type           = var.source_instance_type
  sriov_support           = var.sriov
  ssh_interface           = var.source_ssh_interface
  ami_description         = var.description
  force_deregister        = var.overwrite
  force_delete_snapshot   = var.overwrite
  ami_virtualization_type = var.virtualisation

  ami_root_device {
    device_name           = var.storage_name
    volume_size           = var.storage_size_gb
    volume_type           = var.storage_tier
    source_device_name    = var.storage_mount
    delete_on_termination = ! var.storage_keep
  }

  assume_role {
    role_arn     = var.role
    session_name = local.session
  }

  launch_block_device_mappings {
    device_name           = var.source_storage_name
    volume_size           = var.source_storage_size_gb
    volume_type           = var.source_storage_tier
    omit_from_artifact    = true
    delete_on_termination = ! var.source_storage_keep
  }

  launch_block_device_mappings {
    device_name           = var.storage_mount
    volume_size           = var.storage_size_gb
    volume_type           = var.storage_tier
    delete_on_termination = ! var.source_storage_keep
  }

  source_ami_filter {
    owners      = [ var.source_ami_owner ]
    most_recent = var.source_ami_latest

    filters = {
      "name"                = var.source_ami_name
      "architecture"        = var.architecture
      "root-device-type"    = var.storage_type
      "virtualization-type" = var.virtualisation
    }
  }
}

################################################################################
