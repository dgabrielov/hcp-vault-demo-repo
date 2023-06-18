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
        approvals = 1
      }
    }
  }
}
EOT

}

resource "vault_rgp_policy" "control-group-self-auth" {
  name              = "control-group-self-auth"
  enforcement_level = "soft-mandatory"

  policy = <<EOT
import "controlgroup"

control_group = func() {
    controlgroup.authorizations as authz
    if authz.entity == identity.entity.id {
        return false
    }
    return true
}

main = rule {
    control_group()
}
EOT
}
