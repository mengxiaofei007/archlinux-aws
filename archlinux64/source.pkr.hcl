###############################################################################

variable "source_ami_name"   { default = "amzn2-ami-hvm-2.0.*-x86_64-gp2" }
variable "source_ami_owner"  { default = "137112412989"                   }
variable "source_ami_latest" { default = true                             }

###############################################################################

variable "source_iam_role" { default = "packer-bitservices-eu-west-1-packer-instance" }

###############################################################################

variable "source_instance_type" { default = "t3a.micro" }

###############################################################################

variable "source_ssh_timeout"   { default = "3m"         }
variable "source_ssh_username"  { default = "ec2-user"   }
variable "source_ssh_interface" { default = "public_dns" }

###############################################################################

variable "source_storage_image_keep"  { default = false       }
variable "source_storage_image_mount" { default = "/dev/xvdb" }

###############################################################################

locals {
  source_storage_image_delete_on_termination = var.source_storage_image_keep ? false : true
}

###############################################################################

source "amazon-ebssurrogate" "object" {
  region                  = var.region_build
  ami_name                = local.name
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
  iam_instance_profile    = var.source_iam_role
  force_delete_snapshot   = var.overwrite
  ami_virtualization_type = var.virtualisation

  ami_root_device {
    device_name           = var.storage_name
    volume_size           = var.storage_size_gb
    volume_type           = var.storage_tier
    source_device_name    = var.source_storage_image_mount
    delete_on_termination = local.storage_delete_on_termination
  }

  assume_role {
    role_arn     = var.role
    session_name = local.session
  }

  launch_block_device_mappings {
    device_name           = var.source_storage_image_mount
    volume_size           = var.storage_size_gb
    volume_type           = var.storage_tier
    delete_on_termination = local.source_storage_image_delete_on_termination
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

###############################################################################
