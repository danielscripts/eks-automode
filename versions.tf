################################################################################
# Terraform Versions
################################################################################

terraform {
  required_version = ">= 1.5.7"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.18.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }

    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }

  }
}
