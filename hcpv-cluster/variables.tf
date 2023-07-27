variable "region" {
  type    = string
  default = "us-west-1"
}

variable "hcpv_name" {
  type    = string
  default = "hcpv-cluster"
}

variable "cloud_provider" {
  type    = string
  default = "aws"
}

variable "tier" {
  type    = string
  default = "plus_small"
}
