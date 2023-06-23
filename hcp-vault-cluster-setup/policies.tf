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

resource "vault_rgp_policy" "control-group-self-auth" {
  name              = "control-group-self-auth"
  enforcement_level = "hard-mandatory"

  policy = <<EOT
  import "time"
import "controlgroup"

control_group = func() {
    numAuthzs = 0
    for controlgroup.authorizations as authz {
        if "managers" in authz.groups.by_name {
            if time.load(authz.time).unix > time.now.unix - 3600 {
                numAuthzs = numAuthzs + 1
            }
        }
    }
    if numAuthzs >= 1 {
      print(controlgroup.authorizations.entity.id)
      print(identity.entity.id)
        return true
    }
    return false
}

main = rule {
    control_group()
}
EOT


  #   policy = <<EOT
  # import "controlgroup"

  # control_group = func() {
  #   if controlgroup.authorizations.entity.id == identity.entity.id {
  #     print("Entity Id for Authorisation and Access is the same")
  #     print(controlgroup.authorizations.entity.id)
  #     print(identity.entity.id)
  #     return false
  #   }
  #   print("Entity Ids are different")
  #   print(controlgroup.authorizations.entity.id)
  #   print(identity.entity.id)
  #   return true
  # }


  # main = rule {
  #     control_group()
  # }
  # EOT
}
