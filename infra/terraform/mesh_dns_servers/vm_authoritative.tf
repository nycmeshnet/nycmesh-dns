resource "proxmox_vm_qemu" "authoritative_dns_vm" {
  count       = 1
  name        = "gordian-knot-auth-${count.index}"
  desc        = "authoritative knot on jon ${count.index}"
  target_node = var.proxmox_node

  clone = var.proxmox_template_image

  cores                   = 2
  sockets                 = 1
  memory                  = 2560
  os_type                 = "cloud-init"
  agent                   = 1
  cloudinit_cdrom_storage = var.proxmox_storage_location
  ciuser                  = var.dns_local_user
  cipassword              = var.MESH_DNS_LOCAL_PASSWORD

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
    bridge = "vmbr0"
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

  tags = "dns"

  lifecycle {
    ignore_changes = [
      qemu_os,
    ]
  }
}
