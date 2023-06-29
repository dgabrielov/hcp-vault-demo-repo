variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "hcpv_name" {
  type    = string
  default = "hcpv-plus-controlGroupDemo"
}

variable "cloud_provider" {
  type    = string
  default = "aws"
}

variable "tier" {
  type    = string
  default = "plus_small"
}
