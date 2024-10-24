variable "region" {
  description = "The AWS region to create the VPC in."
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC."
  type        = string
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "allowed_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}


variable "public_pub_subnet1_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}

variable "public_pub_subnet2_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}

variable "private_subnet1_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}

variable "private_subnet2_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}

variable "private_subnet3_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}

variable "private_subnet4_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}


variable "az_count" {
  description = "Number of Availability Zones."
  type        = number
}

variable "azs" {
  description = "List of Availability Zones."
  type        = list(string)
}

variable "eks_role_name" {
  description = "The AWS region to create the VPC in."
  type        = string
}

variable "eks_role_tag" {
  description = "The AWS region to create the VPC in."
  type        = string
}

variable "node_role_name" {
  description = "The AWS region to create the VPC in."
  type        = string
}

variable "node_role_tag" {
  description = "The name of node Tag."
  type        = string
}

variable "cluster_role_name" {
  description = "Specify the name of iam role which is assign to cluster."
  type        = string
}

variable "node_group_name" {
  description = "The name of node group."
  type        = string
}

variable "iam_role_node" {
  description = "Specify the iam role which is assing to nodegroup."
  type        = string
}

variable "cluster_tag" {
  description = "The name of Cluster Tag."
  type        = string
}

variable "kubernetes_version" {
  description = "The desired Kubernetes version."
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "aws_pub_subnet1_name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "aws_pub_subnet2_name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "aws_internet_gateway_name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "aws_pub_route1_table_name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}
variable "Private_Subnet1_Name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "Private_Subnet2_Name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "Private_Subnet3_Name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "Private_Subnet4_Name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "NAT_GW_EIP_Name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "NAT_GW_Name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "aws_priv_route1_table_name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "security_group_name" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "eks_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster."
  type        = string
}
