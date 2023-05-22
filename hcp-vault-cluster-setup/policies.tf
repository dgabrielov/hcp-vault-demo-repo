resource "vault_policy" "dev" {
  name = "dev"

  policy = <<EOT
path "kvv2/aws_root_keys/key_A" {
  capabilities = ["read"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "acct_manager" ]
        approvals = 1
      }
    }
  }
}
EOT
}

resource "vault_policy" "manager" {
  name = "manager"

  policy = <<EOT
# To approve the request
path "sys/control-group/authorize" {
    capabilities = ["create", "update"]
}

# To check control group request status
path "sys/control-group/request" {
    capabilities = ["create", "update"]
}
EOT

}