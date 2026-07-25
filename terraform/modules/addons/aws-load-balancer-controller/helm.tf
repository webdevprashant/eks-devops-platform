#resource "kubernetes_service_account_v1" "alb_controller" {
#  metadata {
#    name      = local.service_account_name
#    namespace = local.namespace
#    annotations = {
#      "eks.amazonaws.com/role-arn" = aws_iam_role.alb_controller.arn
#    }
#  }
# }