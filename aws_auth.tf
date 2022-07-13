resource "local_file" "aws_auth" {
  content  = local.aws_auth
  filename = "${path.cwd}/aws-auth.yaml"
}

resource "local_file" "kubeconfig" {
  content  = local.kubeconfig
  filename = "${path.cwd}/kubeconfig"
}
