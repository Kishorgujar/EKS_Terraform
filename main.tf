module "vpc" {
  source              = "./modules/vpc"
  region              = var.region
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_pub_subnet1_cidrs = var.public_pub_subnet1_cidrs
  public_pub_subnet2_cidrs = var.public_pub_subnet2_cidrs
  private_subnet1_cidrs = var.private_subnet1_cidrs
  private_subnet2_cidrs = var.private_subnet2_cidrs
  private_subnet3_cidrs = var.private_subnet3_cidrs
  private_subnet4_cidrs = var.private_subnet4_cidrs
  vpc_id = module.vpc.vpc_id
  allowed_cidrs = var.allowed_cidrs
  aws_pub_subnet1_name = var.aws_pub_subnet1_name
  aws_pub_subnet2_name = var.aws_pub_subnet2_name
  aws_internet_gateway_name = var.aws_internet_gateway_name
  aws_pub_route1_table_name = var.aws_pub_route1_table_name
  Private_Subnet1_Name = var.Private_Subnet1_Name
  Private_Subnet2_Name = var.Private_Subnet2_Name
  Private_Subnet3_Name = var.Private_Subnet3_Name
  Private_Subnet4_Name = var.Private_Subnet4_Name
  NAT_GW_EIP_Name = var.NAT_GW_EIP_Name
  NAT_GW_Name = var.NAT_GW_Name
  aws_priv_route1_table_name = var.aws_priv_route1_table_name
  security_group_name = var.security_group_name
}


module "iam_role" {
  source = "./modules/iam_role"
  account_id  = var.account_id          # Pass the AWS account ID
  environment = terraform.workspace      # Pass the current workspace
  eks_role_name  = var.eks_role_name
  eks_role_tag   = var.eks_role_tag
  node_role_name = var.node_role_name
  node_role_tag  = var.node_role_tag
}

module "eks" {
  source              = "./modules/eks"
  region              = var.region
  cluster_name        = var.cluster_name
  cluster_role_arn    = module.iam_role.eks_role_arn
  node_role_arn       = module.iam_role.node_role_arn
  kubernetes_version  = var.kubernetes_version
  cluster_role_name    = var.cluster_role_name
  node_group_name      = var.node_group_name
  iam_role_node        = var.iam_role_node
  account_id           = var.account_id     # Pass the account ID variable
  environment          = terraform.workspace # Pass the current workspace as environment
  # Pass subnet IDs from the VPC module
  subnet_ids = concat(
    module.vpc.public_pub_subnet1_ids,
    module.vpc.public_pub_subnet2_ids,
    module.vpc.private_sub1_ids,
    module.vpc.private_sub2_ids,
    module.vpc.private_sub3_ids,
    module.vpc.private_sub4_ids
  )
 private_subnet_ids = concat(
    module.vpc.private_sub1_ids,
    module.vpc.private_sub2_ids
  )
  security_group_ids  = [module.vpc.security_group_id]
  endpoint_public_access = true
  endpoint_private_access = true
  cluster_tag         = var.cluster_tag

}
