terraform {
  cloud {
    organization = "samuellee-dev"
    workspaces {
      name = "hcpv-cluster"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "hcp" {
  client_id = "5ibO8BXZOJgR0pRzOUk4jw5x433oQyud"
  client_secret = "n_7uWx5ShNAf0PQvAsLO4DA091o5_7ibc8W96jzonxt5wSTYsbYlA3dCq9Wu4KOp"
  project_id = "c96b78cf-a493-41ab-b708-96e89253c1b4"
}

provider "tfe" {}

provider "vault" {
  address = hcp_vault_cluster.hcpv-cluster.vault_public_endpoint_url
}
