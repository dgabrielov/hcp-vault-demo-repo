resource "vault_mount" "aws-root-keys" {
  path        = "aws_root_keys"
  type        = "kv-v2"
  description = "KV Version 2 secret engine mount"
}

resource "vault_kv_secret_v2" "prod" {
  mount = vault_mount.aws-root-keys.path
  name  = "prod"
  cas   = 1
  data_json = jsonencode(
    {
      username = "user",
      password = "pass"
    }
  )
}

resource "vault_kv_secret_v2" "dev" {
  mount = vault_mount.aws-root-keys.path
  name  = "dev"
  cas   = 1
  data_json = jsonencode(
    {
      username = "user",
      password = "pass"
    }
  )
}

resource "vault_kv_secret_v2" "test" {
  mount = vault_mount.aws-root-keys.path
  name  = "test"
  cas   = 1
  data_json = jsonencode(
    {
      username = "user",
      password = "pass"
    }
  )
}

resource "vault_mount" "aws" {
  path                      = "aws"
  type                      = "aws"
  description               = "AWS secret engine mount"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}
