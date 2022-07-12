################################################################################
# Cluster Security Group
# Defaults follow https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html
################################################################################

locals {
  cluster_sg_name   = coalesce(var.cluster_security_group_name, "${var.cluster_name}-cluster")
  create_cluster_sg = var.create && var.create_cluster_security_group

  cluster_security_group_id = local.create_cluster_sg ? aws_security_group.cluster[0].id : var.cluster_security_group_id

  cluster_security_group_rules = {
    ingress_nodes_443 = {
      description                = "Node groups to cluster API"
      protocol                   = "tcp"
      from_port                  = 443
      to_port                    = 443
      type                       = "ingress"
      source_node_security_group = true
    }
    egress_nodes_443 = {
      description                = "Cluster API to node groups"
      protocol                   = "tcp"
      from_port                  = 443
      to_port                    = 443
      type                       = "egress"
      source_node_security_group = true
    }
    egress_nodes_kubelet = {
      description                = "Cluster API to node kubelets"
      protocol                   = "tcp"
      from_port                  = 10250
      to_port                    = 10250
      type                       = "egress"
      source_node_security_group = true
    }
  }
}

################################################################################
# IAM Role
################################################################################

locals {
  create_iam_role   = var.create && var.create_iam_role
  iam_role_name     = coalesce(var.iam_role_name, "${var.cluster_name}-cluster")
  policy_arn_prefix = "arn:${data.aws_partition.current.partition}:iam::aws:policy"

  cluster_encryption_policy_name = coalesce(var.cluster_encryption_policy_name, "${local.iam_role_name}-ClusterEncryption")

  # TODO - hopefully this can be removed once the AWS endpoint is named properly in China
  # https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1904
  dns_suffix = coalesce(var.cluster_iam_role_dns_suffix, data.aws_partition.current.dns_suffix)
}

################################################################################
# Cluster Encryption
################################################################################

locals {
  cluster_encryption_config = [{
    provider_key_arn = var.create_kms_key ? aws_kms_key.this[0].arn : var.provider_key_arn
    resources        = ["secrets"]
  }]
}

################################################################################
# AWS Auth ConfigMap
################################################################################

locals {
  aws_auth = templatefile("${path.module}/templates/aws_auth_cm.tpl",
    {
      eks_managed_role_arns                   = [for group in module.eks_managed_node_group : group.iam_role_arn]
      self_managed_role_arns                  = [for group in module.self_managed_node_group : group.iam_role_arn if group.platform != "windows"]
      win32_self_managed_role_arns            = [for group in module.self_managed_node_group : group.iam_role_arn if group.platform == "windows"]
      fargate_profile_pod_execution_role_arns = [for group in module.fargate_profile : group.fargate_profile_pod_execution_role_arn]
      additional_admin_aws_role_arns          = var.additional_admin_aws_role_arns
    }
  )
}
