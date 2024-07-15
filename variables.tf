variable "nodes" {
  type    = string
  default = [for i in range(3) : "n${i}"]
}

variable "network" {
  type = string
}
