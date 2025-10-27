################################################################################
# Cert Manager - Helm Chart
################################################################################

resource "helm_release" "cert-manager" {
  namespace        = "cert-manager"
  name             = "cert-manager"
  create_namespace = true
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.14.5"
  wait             = false

  set = [
    {
      name  = "installCRDs"
      value = "true"
    }
  ]
}

################################################################################
# Metrics Server - Helm Chart
################################################################################

resource "helm_release" "metrics_server" {
  namespace        = "metrics-server"
  name             = "metrics-server"
  create_namespace = true
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  chart            = "metrics-server"
  version          = "3.12.1"
  wait             = false
}