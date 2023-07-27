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
  address = 'https://vault-cluster-2-public-vault-ac568036.1e42f22e.z1.hashicorp.cloud:8200'
  token   = 'hvs.CAESIG0lFSEm-nC4V6qSCwnmXHfMRKExU5iEsnhUCyJX1wqmGigKImh2cy5nOVpsb0dqMzE0WFUwTkZSbXhTRkgwQ3AudGNTTXEQvZBJ'
}

provider "hcp" {
  project_id = "5594ca7c-efd8-4ba6-bdbb-007bcf95cd84"
}
