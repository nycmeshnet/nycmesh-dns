resource "proxmox_vm_qemu" "authoritative_dns_vm" {
  count       = length(var.dns_auth_mgt_ip)
  name        = "${var.hostname_prefix}-dns-auth-${sum([1, count.index, var.hostname_count_offset])}"
  desc        = "Authoritative knot ${count.index}"
  target_node = var.proxmox_node

  clone = var.proxmox_template_image

  cores                   = var.authoritative_cores
  sockets                 = var.authoritative_sockets
  memory                  = var.authoritative_memory
  os_type                 = "cloud-init"
  agent                   = 1
  #cloudinit_cdrom_storage = var.proxmox_storage_location
  ciuser                  = var.dns_local_user
  cipassword              = var.mesh_dns_local_password

  scsihw = "virtio-scsi-pci"

  disks {
    scsi {
      scsi0 {
        disk {
          backup  = false
          size    = 15
          storage = var.proxmox_storage_location
        }
      }
    }
  }

  network {
    id = 0
    bridge = var.vm_nic
    model  = "virtio"
  }

  ipconfig0 = "ip=${var.dns_auth_mgt_ip[count.index]}/${var.dns_mgt_network_host_identifier},gw=${var.dns_mgt_gateway}"

  ssh_user        = "root"
  ssh_private_key = file("${path.module}/../${var.dns_ssh_key_name}")

  sshkeys = file("${path.module}/../${var.dns_ssh_key_name}.pub")

  serial {
    id   = 0
    type = "socket"
  }

  tags = "dns,managed_by_iac"

  lifecycle {
    ignore_changes = [
      qemu_os,
    ]
  }
}
