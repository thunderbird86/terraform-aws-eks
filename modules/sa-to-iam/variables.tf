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

variable "policy_arn" {
  description = "IAM Policy ARN"
  type        = string
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
