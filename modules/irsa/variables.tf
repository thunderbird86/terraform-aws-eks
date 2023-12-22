variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "role_name" {
  description = "IAM Role name"
  type        = string
}

variable "namespace" {
  description = "K8s namespace where to create service account "
  type        = string
}

variable "create_namespace" {
  description = "Set to zero if namespace was created before"
  default     = false
  type        = bool
}

variable "create_service_account" {
  description = "Whether create Kubernetes service account or not"
  type        = bool
  default     = true
}

variable "create_secret" {
  description = "Required for migration to wrappers with empty plan, probably should be removed later"
  type        = bool
  default     = true
}

variable "policy_arn" {
  description = "IAM Policy ARN"
  type        = string
  default     = ""
}

variable "aws_iam_policy_json" {
  description = "JSON file contains AWS IAM Policy"
  type        = string
  default     = ""
}

variable "aws_iam_openid_connect_provider_arn" {
  description = "EKS OpenID provider arn"
  type        = string
}

variable "aws_iam_openid_connect_provider_url" {
  description = "EKS OpenID provider url"
  type        = string
}

variable "policy_sid" {
  description = "IAM Policy SID"
  type        = string
  default     = ""
}

variable "iam_role_use_name_prefix" {
  description = "Whether use prefix or not in IAM Role name"
  type        = bool
  default     = false
}
