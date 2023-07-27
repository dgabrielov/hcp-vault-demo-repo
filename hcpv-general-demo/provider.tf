terraform {
  cloud {
    organization = "dgtest1"
    workspaces {
      name = "hcpv-demo"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "tfe" {}

provider "vault" {
  address = data.tfe_outputs.tfc-outputs.values.hcp-vault-address
  token   = data.tfe_outputs.tfc-outputs.values.vault-token
}

provider "hcp" {
  client_id = "5ibO8BXZOJgR0pRzOUk4jw5x433oQyud"
  client_secret = "n_7uWx5ShNAf0PQvAsLO4DA091o5_7ibc8W96jzonxt5wSTYsbYlA3dCq9Wu4KOp"
  project_id = "c96b78cf-a493-41ab-b708-96e89253c1b4"
}
