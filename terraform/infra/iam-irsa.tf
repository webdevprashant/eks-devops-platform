###########################################
# EKS Cluster Authentication
###########################################

data "aws_eks_cluster" "main" {
  name = aws_eks_cluster.main.name
}

data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name
}

###########################################
# TLS Certificate
###########################################

data "tls_certificate" "eks" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
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
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}