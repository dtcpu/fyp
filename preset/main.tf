resource "random_integer" "index" {
  min = 0
  max = 2
}

resource "random_id" "vm" {
  byte_length = 3
}

locals {
  node = "n${random_integer.index}"
}

resource "proxmox_virtual_environment_vm" "instance" {
  name        = format("%s-%s", var.flavor, random_id.vm.hex)
  tags        = [var.team, var.cohort]

  node_name = local.node

  agent {
    enabled = true
  }

  cpu {
    architecture = "x86_64"
    cores        = var.vcpus
    sockets      = 1
    type         = "host"
  }

  memory {
    dedicated = local.memory
  }

  scsi_hardware = "virtio-scsi-single"

  stop_on_destroy = true

  disk {
    datastore_id = var.datastore_id
    file_id      = local.template
    interface    = "scsi0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      keys     = [trimspace(tls_private_key.ubuntu_vm_key.public_key_openssh)]
      password = random_password.ubuntu_vm_password.result
      username = "ubuntu"
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}
