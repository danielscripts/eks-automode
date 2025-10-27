# Módulo EKS
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # Nomes atualizados para v21.x (removido prefixo cluster_)
  name                      = var.eks_name
  kubernetes_version        = var.eks_version
  endpoint_public_access    = true
  enable_cluster_creator_admin_permissions = true
  enabled_log_types         = []

  # setup vpc for eks
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets


  # profile and selectors
  # fargate_profiles = {

  #   cnpg-system = {
  #     selectors = [
  #       { namespace = "cnpg-system" }
  #     ]
  #   }

  #   aws-application-networking-system = {
  #     selectors = [
  #       { namespace = "aws-application-networking-system" }
  #     ]
  #   }

  # }

  # bootstrap_self_managed_addons removido na v21.x (agora é hardcoded false)

  # EKS Auto Mode: compute_config
  compute_config = {
    enabled       = true
    node_pools    = ["general-purpose"]
  }

  # Criar as roles IAM automaticamente
  create_iam_role = true

  tags = local.tags

  # Definir usuários que terão acesso ao cluster
  access_entries = local.access_entries

}


