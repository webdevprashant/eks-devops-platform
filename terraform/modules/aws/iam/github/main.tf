##############################################
# GitHub OIDC Provider
##############################################

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com"
  ]
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
  tags = {
    Name        = "GitHub-OIDC"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}

##############################################
# GitHub Trust Policy
##############################################

data "aws_iam_policy_document" "github_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        # "repo:webdevprashant/eks-devops-platform:*"
        "repo:${var.github_repository}:ref:refs/heads/${var.github_branch}"
      ]
    }
  }
}

##############################################
# GitHub Actions IAM Role
##############################################

resource "aws_iam_role" "github_actions" {
  name               = "github-actions-role"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
  tags = {
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_policy" "github_actions" {
  name   = "GitHubActionsPolicy"
  policy = file("${path.module}/github-actions-policy.json")
}