data "aws_iam_policy_document" "cert_manager" {
  statement {
    sid = "RoleForEksLBController"
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.oidc_provider[0].arn]
    }

    condition {
      test     = "StringEquals"
      variable = format("%s:%s", aws_iam_openid_connect_provider.oidc_provider[0].url, "aud")
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = format("%s:%s", aws_iam_openid_connect_provider.oidc_provider[0].url, "sub")
      values   = ["system:serviceaccount:kube-system:cert-manager"]
    }
  }
}

