locals {
  service_account_name = "aws-load-balancer-controller"
  namespace = "kube-system"
  role_name = "${var.project_name}-${var.environment}-alb-controller"
}