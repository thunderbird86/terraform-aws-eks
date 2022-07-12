terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 2.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
  }
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.this[0].id
}
#
#provider "kubernetes" {
##  host                   = aws_eks_cluster.this[0].endpoint
#  host                   = "https://BBCA0C9E507F18D0AE9A97FF8B287FEF.gr7.us-east-1.eks.amazonaws.com"
#  cluster_ca_certificate = base64decode(aws_eks_cluster.this[0].certificate_authority[0].data)
##  token                  = data.aws_eks_cluster_auth.eks.token
#  exec {
#    api_version = "client.authentication.k8s.io/v1alpha1"
#    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
#    command     = "aws"
#  }
#}

provider "kubernetes" {
#  host                   = aws_eks_cluster.this[0].endpoint
    host                   = "https://BBCA0C9E507F18D0AE9A97FF8B287FEF.gr7.us-east-1.eks.amazonaws.com"
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJeU1ETXpNREV3TkRneE9Wb1hEVE15TURNeU56RXdORGd4T1Zvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTHNaCmVyTnIxQmdoWEh0U2Q2a1A5YXg0V0ZMMEhjUG5GQzRUQUVXUDZkSVMwTC9BODRSNk5jVks4ZW9IUWRxTTRadG0KclRPeVBaQmVzUjNUNGZRUTNMSVB4TW9nZGRJOTVGSE0vNTlXWmJCdEl5VlI2SmtkUzZOQnlETXVaQ1RwR3hrRApxSVpSSmNtbkR3bjNUd0tRNW8zZGM0TTFnbGlFN0pLbUpVUDQ0aEpUQytINDFibTg0ZGpPdW9rQ2VhalkxdkV6Cll0Qy85MVEzcXVMaXp5MXZsd2JhQnV2OEpZVlJETVQ2dXBFUTRnbS9MRE12WHkrUTFFQlpqeUhGS2N2di95ckEKbldGOHM5NWwyNkFrT0JtOTJRRE02TVNqbm1UWEFZUlBySTdCUm8xOVg3WTdvYzRUdzhRUERLV1JTNGFCcmFsMApNZDg2bFhjRzJWRHh6L0JzVWs4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZOb3B3Z2w5MlA0SlhCZXZILy9KZ1pxUkhnRzNNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFDQmdobFZ6Y1A3WEYzdm5BN1g3N3BaYUdZeGV0MW9SeXA0dzdCNjdITG5kOG9iM2JNcQpVZktqdnJpeWluME1aSlBlYVpLQWh3OFNFRGhiUTA4UHVYMG92THZFM2FxVUc4N0pqRXVyUjMyNDdVT2NDeTZqClB6d0tiLzluTVFOU3NQTnFDRTB4M0x3V0tpMGNNTG4wMVYrd2NGOGtMckxqYjhsR1VXSTk3YUdtbEh1UXQ0R28KcTlvT0xMekhnNnJyM3ZKNmtIbG9RSkpRSTk2Z0NRMnhtYVRMenpQQitjUHl1cWwyZXhzMXMrQWcwdEx5YXZ6dwpXSzZMZUlBbFZqWHEycXZPUThGZGNTQU9QaHZSS3p3UVRQKzNmMTV1aGhKNG5DaWlnTEVqQlJIU2RBUU1IMzc1CnR6SFVPc0pFdjZnSlZjdFdhSHQwU2R3OGFCYm43SjRJWGQwQwotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==")
#  token                  = data.aws_eks_cluster_auth.eks.token

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.this[0].name]
  }
}
