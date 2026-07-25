###########################################
# TLS Certificate
###########################################

data "tls_certificate" "eks" {
  # url = data.aws_eks_cluster.main.identity[0].oidc[0].issuer
  url = var.cluster_oidc_issuer
}


###########################################
# IAM OIDC Provider
###########################################

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.eks.certificates[0].sha1_fingerprint
  ]
  #url = data.aws_eks_cluster.main.identity[0].oidc[0].issuer
  url = var.cluster_oidc_issuer
}