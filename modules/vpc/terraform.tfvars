region                     = "ap-south-1"
vpc_name                   = "my-vpc"
vpc_cidr                   = "192.168.0.0/16"
public_pub_subnet1_cidrs   = ["192.168.0.0/20"]
public_pub_subnet2_cidrs   = ["192.168.16.0/20"]
private_subnet1_cidrs      = ["192.168.32.0/20"]
private_subnet2_cidrs      = ["192.168.64.0/20"]
private_subnet3_cidrs      = ["192.168.96.0/20"]
private_subnet4_cidrs      = ["192.168.112.0/20"]
azs                        = ["ap-south-1a", "ap-south-1b"]
allowed_cidrs              = ["0.0.0.0/0"]  # Modify as needed for security
aws_pub_subnet1_name       =  "Public_Pub_Sub1"
aws_pub_subnet2_name       =  "Public_Pub_Sub2"
aws_internet_gateway_name  =  "Public_IGW"
aws_pub_route1_table_name  =  "Public_pub_route1"
Private_Subnet1_Name       = "Private_Subnet1"
Private_Subnet2_Name       = "Private_Subnet2"
Private_Subnet3_Name       = "Private_Subnet3"
Private_Subnet4_Name       = "Private_Subnet4"
NAT_GW_EIP_Name            = "NAT_GW_EIP"
NAT_GW_Name                = "EKS_NAT"
aws_priv_route1_table_name = "Private_pub_route1"
security_group_name        = "eks-security-group"
