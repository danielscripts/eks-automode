################################################################################
# Kubernetes Resource
################################################################################

resource "kubectl_manifest" "ebs_csi_storage_class" {
  yaml_body = <<-YAML
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: ebs-csi
      annotations:
        storageclass.kubernetes.io/is-default-class: "true"
    provisioner: ebs.csi.eks.amazonaws.com
    volumeBindingMode: WaitForFirstConsumer
    reclaimPolicy: Retain
  YAML
}
