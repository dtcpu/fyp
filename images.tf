resource "proxmox_virtual_environment_download_file" "debian" {
  for_each     = toset(var.nodes)
  content_type = "iso"
  datastore_id = "local"
  file_name    = "debian.img"
  node_name    = each.key
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
}

resource "proxmox_virtual_environment_download_file" "alma" {
  for_each     = toset(var.nodes)
  content_type = "iso"
  datastore_id = "local"
  file_name    = "alma.img"
  node_name    = each.key
  url          = "https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2"
}
