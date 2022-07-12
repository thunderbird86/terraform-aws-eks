resource "aws_iam_role" "load_balancer_controller" {
  name_prefix = format("%s-%s", var.cluster_name, "lb-controller")
  assume_role_policy = data.aws_iam_policy_document.load_balancer_controller.json
}

resource "aws_iam_role_policy_attachment" "load_balancer_controller" {
  policy_arn = data.aws_iam_policy.aws_eks_lb_controller_policy.arn
  role = aws_iam_role.load_balancer_controller.name
}

resource "kubernetes_service_account" "load_balancer_controller" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.load_balancer_controller.arn
      "eks.amazonaws.com/sts-regional-endpoints" = true
    }
  }
}


#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Principal": {
#                "Federated": "arn:aws:iam::111122223333:oidc-provider/oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE"
#            },
#            "Action": "sts:AssumeRoleWithWebIdentity",
#            "Condition": {
#                "StringEquals": {
#                    "oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE:aud": "sts.amazonaws.com",
#                    "oidc.eks.region-code.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
#                }
#            }
#        }
#    ]
#}
