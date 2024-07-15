variable "datastore_id" {
  type    = string
  default = "local-lvm"
}

variable "disk_size" {
  type        = number
  default     = 32
  description = "Disk size in GB"
}

variable "flavor" {
  type    = string
  validation {
    condition     = can(regex("^(debian|alma)$", var.flavor))
    error_message = "Invalid flavor"
  }
}

variable "memory" {
  type        = number
  default     = 8
  description = "Memory in GB"
}

variable "vcpus" {
  type        = number
  default     = 2
  description = "Number of vCPUs"
}

variable "ssh_authorized_keys" {
  type    = list(string)
  default = []
}

variable "team" {
  type        = string
  description = "Team name"
}

variable "cohort" {
  type = string
  description = "Cohort in unit of year"
}


locals {
  memory = var.memory * 1024
  template = format("local:iso/%s.img", var.flavor)
}
