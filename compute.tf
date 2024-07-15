module "des6" {
  source    = "./preset"
  team      = "des6"
  cohort    = "2024"
  vcpus     = 4
  memory    = 16
  disk_size = 48
  ssh_authorized_keys = [

  ]
  flavor = local.images.debian
}
