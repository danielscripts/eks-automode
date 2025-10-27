################################################################################
# Locals
################################################################################

locals {
  # AZs dinâmicas - pega as 2 primeiras disponíveis na região
  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  # Tags padrão para todos os recursos
  tags = {
    Cluster = var.eks_name
  }
}

################################################################################
# Data
################################################################################

data "aws_availability_zones" "available" {}

# This data source can only be used in the us-east-1 region.
# aws.virginia is an alias at provider.tf
data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.virginia
}

# Data sources para autenticação no cluster
# Estes data sources só funcionam após o cluster ser criado
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}
