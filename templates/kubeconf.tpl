apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster_this_endpoint}
    certificate-authority-data: ${aws_eks_cluster_this_certificate_authority_data}
  name: ${cluster_name}
contexts:
- context:
    cluster: kubernetes
    user: terraform
  name: terraform
current-context: terraform
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${cluster_name}"
