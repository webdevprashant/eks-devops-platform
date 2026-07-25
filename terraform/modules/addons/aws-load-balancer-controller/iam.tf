#############################################
# AWS Load Balancer Controller IAM Policy
#############################################

resource "aws_iam_policy" "alb_controller" {
  # name        = "AWSLoadBalancerControllerIAMPolicy"
  name        = "${local.role_name}-policy"
  description = "IAM Policy for AWS Load Balancer Controller"
  policy      = file("${path.module}/aws-load-balancer-controller.json")
}

#############################################
# ALB Controller Assume Role Policy
#############################################

data "aws_iam_policy_document" "alb_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      type = "Federated"
      identifiers = [
        # aws_iam_openid_connect_provider.eks.arn
        var.oidc_provider_arn
      ]
    }

    condition {
      test     = "StringEquals"
      # variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      variable = "${replace(var.oidc_provider_url, "https://", "")}:sub"
      values = [
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
      ]
    }
  }
}

#############################################
# AWS Load Balancer Controller IAM Role
#############################################

resource "aws_iam_role" "alb_controller" {
  #name               = "AmazonEKSLoadBalancerControllerRole"
  name                =  local.role_name
  assume_role_policy = data.aws_iam_policy_document.alb_assume_role.json
}

#############################################
# Attach IAM Policy
#############################################
resource "aws_iam_role_policy_attachment" "alb_controller" {
  role       = aws_iam_role.alb_controller.name
  policy_arn = aws_iam_policy.alb_controller.arn
}

###########################################
# EKS Cluster Authentication
###########################################

#data "aws_eks_cluster_auth" "main" {
#  name = data.aws_eks_cluster.main.name
#}