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
  project_id = "c96b78cf-a493-41ab-b708-96e89253c1b4"
}
