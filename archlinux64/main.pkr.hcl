###############################################################################

variable "role"   {}
variable "bucket" {}

###############################################################################

variable "name"           { default = "archlinux64" }
variable "kernel"         { default = "linux"       }
variable "release"        { default = "2.0.12"      }
variable "architecture"   { default = "x86_64"      }
variable "virtualisation" { default = "hvm"         }

###############################################################################

variable "description" { default = "An Archlinux x86-64 box with a focus on being as simple and automation-friendly as possible." }

###############################################################################

variable "ena"       { default =   true    }
variable "sriov"     { default =   true    }
variable "groups"    { default = [ "all" ] }
variable "overwrite" { default =   true    }

###############################################################################

variable "region_build"  { default =   "eu-west-1"   }
variable "region_copies" { default = [ "eu-west-2" ] }

###############################################################################

variable "s3_file" { default = "ec2.qcow2" }

###############################################################################

variable "storage_name"         { default = "/dev/xvda" }
variable "storage_keep"         { default = false       }
variable "storage_tier"         { default = "gp2"       }
variable "storage_type"         { default = "ebs"       }
variable "storage_size_gb"      { default = 3           }
variable "storage_intermediate" { default = "/int.vol"  }

###############################################################################

locals {
  name                          = format("%s/%s/%s/%s/%s", var.name, var.kernel, var.architecture, var.virtualisation, var.storage_type)
  s3_url                        = format("s3://%s/%s/%s/%s", var.bucket, var.name, var.release, var.s3_file)
  session                       = format("%s-aws", var.name)
  storage_delete_on_termination = var.storage_keep ? false : true
}

###############################################################################

build {
  sources = [
    "source.amazon-ebssurrogate.object"
  ]

  provisioner "shell" {
    script = format("%s/scripts/init.sh", path.root)
  }

  provisioner "shell" {
    script          = format("%s/scripts/sparse_image_s3.sh", path.root)
    execute_command = format("{{ .Path }} -i '%s' -f '%s' -s '%s'", var.storage_intermediate, var.source_storage_image_mount, local.s3_url)
  }
}

###############################################################################
