locals {
  resource_name   = format("%.64s", format("%s-%s", var.cluster_name, var.role_name))
  resource_prefix = format("%.31s-", format("%s-%s", var.cluster_name, var.role_name))
  secret_name     = "${var.role_name}-token-secret"
}

resource "aws_iam_role" "this" {
  name               = var.iam_role_use_name_prefix ? local.resource_name : null
  name_prefix        = var.iam_role_use_name_prefix ? null : local.resource_prefix
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_policy" "this" {
  count = length(var.aws_iam_policy_json) > 0 ? 1 : 0

  name_prefix = local.resource_prefix
  path        = format("/%s-%s/", "eks", var.cluster_name)
  policy      = var.aws_iam_policy_json
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = length(var.aws_iam_policy_json) > 0 ? aws_iam_policy.this[0].arn : var.policy_arn
  role       = aws_iam_role.this.name
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.namespace
  }
  lifecycle {
    ignore_changes = [metadata["labels"]]
  }
}

resource "kubernetes_service_account" "this" {
  count = var.create_service_account ? 1 : 0

  metadata {
    name      = var.role_name
    namespace = var.namespace
    labels = {
      "app.kubernetes.io/name" = var.role_name
    }
    annotations = {
      "eks.amazonaws.com/role-arn"               = aws_iam_role.this.arn
      "eks.amazonaws.com/sts-regional-endpoints" = true
    }
  }
  lifecycle {
    ignore_changes = [metadata["labels"]]
  }
}

resource "kubernetes_secret" "this" {
  count = var.create_service_account && var.create_secret ? 1 : 0 # FIXME? drop var.create_secret
  metadata {
    annotations = {
      "kubernetes.io/service-account.name"      = kubernetes_service_account.this[count.index].metadata.0.name
      "kubernetes.io/service-account.namespace" = var.namespace
    }
    namespace     = var.namespace
    generate_name = "${var.role_name}-token-"
  }
  type                           = "kubernetes.io/service-account-token"
  wait_for_service_account_token = true
}
