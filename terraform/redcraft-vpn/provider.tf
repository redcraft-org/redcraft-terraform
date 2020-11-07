provider "scaleway" {
  access_key = var.scw_access_key
  secret_key = var.scw_secret_key
  organization_id = var.scw_default_organization_id
  region = var.scw_default_region
  zone = var.scw_default_zone
}

terraform {
  backend "s3" {
    bucket = "redcraft-terraform"
    key = "vpn.tfstate"

    region = "fr-par"

    endpoint = "https://s3.fr-par.scw.cloud"

    skip_credentials_validation = true
    skip_region_validation = true
  }
}
