#resource "kubernetes_config_map" "aws_auth" {
#  depends_on = [aws_eks_cluster.this]
#
#  metadata {
#    name      = "aws-auth"
#    namespace = "kube-system"
#  }
#
#  data = {
#    mapRoles = local.aws_auth
#  }
#}
