resource "vault_mount" "kvv2" {
  path        = "kvv2"
  type        = "kv-v2"
  description = "KV Version 2 secret engine mount"
}

resource "vault_mount" "aws" {
    path = "aws"
    type = "aws"
    description = "AWS secret engine mount"
    default_lease_ttl_seconds = 3600
    max_lease_ttl_seconds     = 86400
}