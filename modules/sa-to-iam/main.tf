resource "aws_iam_role" "this" {
  name_prefix        = format("%s-%s-", var.cluster_name, var.role_name)
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = var.policy_arn
  role       = aws_iam_role.this.name
}

resource "kubernetes_service_account" "this" {
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
}
