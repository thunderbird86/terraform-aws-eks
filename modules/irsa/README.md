# EKS Servise account map to IAM Role

Configuration in this directory creates K8s Service account and IAM Role 

## Usage

```hcl
module "irsa" {
  source = "git@github.com:workato-devops/tf-infra-eks.git//modules/irsa?ref=v0.9.1"

  policy_sid                          = "TestEksLBController"
  cluster_name                        = "test-eks"
  role_name                           = "lb-contorller"
  namespace                           = "kube-system"
  policy_arn                          = data.aws_iam_policy.aws_eks_lb_controller_policy.arn
  aws_iam_openid_connect_provider_arn = module.eks.oidc_provider_arn
  aws_iam_openid_connect_provider_url = module.eks.oidc_provider
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service_account.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_iam_openid_connect_provider_arn"></a> [aws\_iam\_openid\_connect\_provider\_arn](#input\_aws\_iam\_openid\_connect\_provider\_arn) | EKS OpenID provider arn | `string` | n/a | yes |
| <a name="input_aws_iam_openid_connect_provider_url"></a> [aws\_iam\_openid\_connect\_provider\_url](#input\_aws\_iam\_openid\_connect\_provider\_url) | EKS OpenID provider url | `string` | n/a | yes |
| <a name="input_aws_iam_policy_json"></a> [aws\_iam\_policy\_json](#input\_aws\_iam\_policy\_json) | JSON file contains AWS IAM Policy | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Set to zero if namespace was created before | `bool` | `false` | no |
| <a name="input_create_secret"></a> [create\_secret](#input\_create\_secret) | Required for migration to wrappers with empty plan, probably should be removed later | `bool` | `true` | no |
| <a name="input_create_service_account"></a> [create\_service\_account](#input\_create\_service\_account) | Whether create Kubernetes service account or not | `bool` | `true` | no |
| <a name="input_iam_role_use_name_prefix"></a> [iam\_role\_use\_name\_prefix](#input\_iam\_role\_use\_name\_prefix) | Whether use prefix or not in IAM Role name | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | K8s namespace where to create service account | `string` | n/a | yes |
| <a name="input_policy_arn"></a> [policy\_arn](#input\_policy\_arn) | IAM Policy ARN | `string` | `""` | no |
| <a name="input_policy_sid"></a> [policy\_sid](#input\_policy\_sid) | IAM Policy SID | `string` | `""` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | IAM Role name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
