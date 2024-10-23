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

variable "public_pub_subnet1_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}

variable "public_pub_subnet2_cidrs" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}

variable "az_count" {
  description = "Number of Availability Zones."
  type        = number
  default     = 2  # Adjust if you want to hard-code or handle dynamically
}

variable "azs" {
  description = "List of Availability Zones."
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

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to access the EKS cluster."
  type        = list(string)
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


