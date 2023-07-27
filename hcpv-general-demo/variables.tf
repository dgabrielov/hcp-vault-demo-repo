variable "org_name" {
  type    = string
  default = "dgtest1"
}
variable "vault_workspace_name" {
  type    = string
  default = "hcpv-cluster"
}

variable "workspace_name" {
  type    = string
  default = "hcpv-control-group"
}

variable "db_username" {
  type = string
  default = "dgabr"
}

variable "db_password" {
  type = string
  default = "Demo1234"
}

variable "region" {
  type = string
  default = "us-west-1"
}

variable "db_name" {
  description = "Unique name to assign to RDS instance"
}
