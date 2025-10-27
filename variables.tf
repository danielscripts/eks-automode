variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"  # Ohio
}

variable "eks_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eks-automode"
}

variable "eks_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.32"
}

variable "cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}