# access.tf

data "aws_caller_identity" "current" {}

locals {
  # Lista de usuários que terão acesso ao cluster
  users = [
    "daniel.correa"
  ]

  # Cria o mapa de access_entries no formato esperado pelo módulo EKS
  access_entries = {
    for user in local.users : user => {
      principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${user}"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

          access_scope = {
            namespaces = []
            type       = "cluster"
          }
        }
      }
    }
  }
}
