data "aws_iam_policy_document" "this" {
  statement {
    sid    = var.policy_sid
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = [var.aws_iam_openid_connect_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = format("%s:%s", var.aws_iam_openid_connect_provider_url, "aud")
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = format("%s:%s", var.aws_iam_openid_connect_provider_url, "sub")
      values   = [format("%s:%s:%s", "system:serviceaccount", var.namespace, var.role_name)]
    }
  }
}
