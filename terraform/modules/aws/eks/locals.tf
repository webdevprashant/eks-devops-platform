locals {
  cluster_name = "${var.project_name}-${var.environment}-eks"
  node_group_name = "${var.project_name}-${var.environment}-nodes"
}

# Extract the OIDC provider domain (stripping the "https://" prefix)
locals {
  oidc_issuer_url = aws_eks_cluster.main.identity[0].oidc[0].issuer
  #oidc_provider_id = replace(local.oidc_issuer_url, "https://", "")
}