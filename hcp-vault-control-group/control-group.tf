##### HCP VAULT CONTROL GROUP #####

### VAULT SECRETS CONFIG ###
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

### VAULT AUTH CONFIG ###
resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_generic_endpoint" "christy" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/christy"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["dev"],
  "password": "Demo1234"
}
EOT
}

resource "vault_generic_endpoint" "christy_token" {
  depends_on     = [vault_generic_endpoint.christy]
  path           = "auth/userpass/login/christy"
  disable_read   = true
  disable_delete = true

  data_json = <<EOT
{
  "password": "Demo1234"
}
EOT
}
#test
resource "vault_generic_endpoint" "christy_entity" {
  depends_on           = [vault_generic_endpoint.christy_token]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/lookup/entity"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "alias_name" : "christy",
    "alias_mount_accessor" : vault_auth_backend.userpass.accessor
  })
}

resource "vault_generic_endpoint" "christy_entity_name" {
  depends_on           = [vault_generic_endpoint.christy_entity]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/entity/id/${vault_generic_endpoint.christy_entity.write_data["id"]}"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "name" : "christy",
    "policies" : "dev",
    "metadata" : {
      "team" : "dev"
    }
  })
}

resource "vault_generic_endpoint" "sunil" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/sunil"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["manager"],
  "password": "Demo1234"
}
EOT
}

resource "vault_generic_endpoint" "sunil_token" {
  depends_on     = [vault_generic_endpoint.sunil]
  path           = "auth/userpass/login/sunil"
  disable_read   = true
  disable_delete = true

  data_json = <<EOT
{
  "password": "Demo1234"
}
EOT
}

resource "vault_generic_endpoint" "sunil_entity" {
  depends_on           = [vault_generic_endpoint.sunil_token]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/lookup/entity"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "alias_name" : "sunil",
    "alias_mount_accessor" : vault_auth_backend.userpass.accessor
  })

}

resource "vault_generic_endpoint" "sunil_entity_name" {
  depends_on           = [vault_generic_endpoint.sunil_entity]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/entity/id/${vault_generic_endpoint.sunil_entity.write_data["id"]}"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "name" : "sunil",
    "policies" : "manager",
    "metadata" : {
      "team" : "manager"
    }
  })
}

resource "vault_generic_endpoint" "sam" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/sam"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["manager"],
  "password": "Demo1234"
}
EOT
}

resource "vault_generic_endpoint" "sam_token" {
  depends_on     = [vault_generic_endpoint.sam]
  path           = "auth/userpass/login/sam"
  disable_read   = true
  disable_delete = true

  data_json = <<EOT
{
  "password": "Demo1234"
}
EOT
}

resource "vault_generic_endpoint" "sam_entity" {
  depends_on           = [vault_generic_endpoint.sam_token]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/lookup/entity"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "alias_name" : "sam",
    "alias_mount_accessor" : vault_auth_backend.userpass.accessor
  })

}

resource "vault_generic_endpoint" "sam_entity_name" {
  depends_on           = [vault_generic_endpoint.sam_entity]
  disable_read         = true
  disable_delete       = true
  path                 = "identity/entity/id/${vault_generic_endpoint.sam_entity.write_data["id"]}"
  ignore_absent_fields = true
  write_fields         = ["id"]

  data_json = jsonencode({
    "name" : "sam",
    "policies" : "manager",
    "metadata" : {
      "team" : "manager"
    }
  })
}

resource "vault_identity_group" "manager" {
  name                       = "manager"
  type                       = "internal"
  external_member_entity_ids = true

}

resource "vault_identity_group_member_entity_ids" "manager-members" {
  exclusive         = true
  member_entity_ids = [vault_generic_endpoint.sunil_entity.write_data["id"], vault_generic_endpoint.sam_entity.write_data["id"]]
  group_id          = vault_identity_group.manager.id
}

### VAULT POLICY CONFIG ###
resource "vault_policy" "dev" {
  name = "dev"

  policy = <<EOT

path "aws_root_keys/*" {
  capabilities = ["list"]
}

path "aws_root_keys/data/prod" {
  capabilities = ["read"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "manager" ]
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

path "aws_root_keys/*" {
  capabilities = ["list"]
}

path "aws_root_keys/data/prod" {
  capabilities = ["read"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "manager" ]
        approvals = 2
      }
    }
  }
}
EOT

}

### VAULT ENTITY OUTPUTS ###
output "bob_id" {
  value = vault_generic_endpoint.christy_entity.write_data["id"]
}

output "ellen_id" {
  value = vault_generic_endpoint.sunil_entity.write_data["id"]
}

output "sam_id" {
  value = vault_generic_endpoint.sam_entity.write_data["id"]
}

output "manager_group_id" {
  value = vault_identity_group.manager.id
}
