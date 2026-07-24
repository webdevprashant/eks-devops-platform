locals {
  cluster_name = "${var.project_name}-${var.environment}-eks"
  node_group_name = "${var.project_name}-${var.environment}-nodes"
}