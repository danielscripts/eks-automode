################################################################################
# Terraform Providers
################################################################################



# Configure the AWS Provider para recursos principais
provider "aws" {
  region = var.region
  profile = "tf_lar"
}

# Configure o AWS Provider para o ECR Public na região us-east-1 (Virginia)
provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
  profile = "tf_lar"
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
  load_config_file       = false
}

##primeira execução comentado
# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   token                  = data.aws_eks_cluster_auth.this.token
# }
