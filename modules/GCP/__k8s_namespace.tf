resource "kubernetes_namespace" "k8s__namespaces" {
  for_each = toset(["services", "monitoring"])
  metadata {
    name = each.value
  }
}
