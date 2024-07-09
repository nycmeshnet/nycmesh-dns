output "authoritative_instance_id" {
    value = proxmox_vm_qemu.authoritative_dns_vm.instance_id
}

output "recursive_instance_id" {
    value = proxmox_vm_qemu.recursive_dns_vm.instance_id
}
