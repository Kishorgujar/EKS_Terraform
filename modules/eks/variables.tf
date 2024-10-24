variable "endpoint_private_access" {
  description = "Whether to enable private access to the EKS cluster API server."
  type        = bool
  default     = true
}

variable "cluster_log_types" {
  type        = list(string)
  description = "Types of logs to enable for the EKS cluster. Options include: api, audit, authenticator, controllerManager, scheduler."
  default     = ["api", "audit"]  # Set default log types
}

variable "cluster_tag" {
  description = "Tag for the EKS cluster."
  type        = string
  default     = "Cluster1"
}

variable "eks_role_name" {
  description = "The name of the EKS role."
  type        = string
  default     = "EKSRole"
}

variable "cluster_role_name" {
  description = "The name of the IAM role for the EKS cluster."
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group."
  type        = string
  default     = "MyNodeGroup"
}

variable "node_desired_size" {
  type        = number
  description = "The desired number of worker nodes in the EKS node group."
  default     = 3
}

variable "node_min_size" {
  type        = number
  description = "The minimum number of worker nodes in the EKS node group."
  default     = 3
}

variable "node_max_size" {
  type        = number
  description = "The maximum number of worker nodes in the EKS node group."
  default     = 3
}


variable "node_role_arn" {
  description = "The ARN of the IAM role for the EKS node group."
  type        = string
}

variable "iam_role_node" {
  description = "The ARN of the IAM role for the EKS node group."
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "ap-south-1"  # Default region
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "my-eks-cluster"
}

variable "kubernetes_version" {
  description = "The desired Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.29"
}

variable "cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster."
  type        = string
  default     = "arn:aws:iam::975050350815:role/EKSRole"
}
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EKS cluster."
  type        = list(string)
}

variable "endpoint_public_access" {
  description = "Whether to enable public access to the EKS cluster API server."
  type        = bool
  default     = true
}

variable "load_balancer_policy_arn" {
  description = "ARN of the Load Balancer Controller IAM Policy"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
}

variable "eks_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster."
  type        = string
  # You can remove this if it's not being used
}

