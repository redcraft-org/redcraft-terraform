terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}
