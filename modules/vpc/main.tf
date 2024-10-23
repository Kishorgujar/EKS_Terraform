# Public VPC
resource "aws_vpc" "public_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Public Subnets
resource "aws_subnet" "public_pub_sub1" {
  count = length(var.public_pub_subnet1_cidrs)
  vpc_id = aws_vpc.public_vpc.id
  cidr_block = element(var.public_pub_subnet1_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.aws_pub_subnet1_name}-${count.index}"
  }
}

resource "aws_subnet" "public_pub_sub2" {
  count = length(var.public_pub_subnet2_cidrs)
  vpc_id = aws_vpc.public_vpc.id 
  cidr_block = element(var.public_pub_subnet2_cidrs, count.index)
  availability_zone = element(var.azs, count.index + length(var.public_pub_subnet1_cidrs))
  tags = {
    Name = "${var.aws_pub_subnet2_name}-${count.index}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.public_vpc.id
  tags = {
    Name = var.aws_internet_gateway_name
  }
}

# Public Route Tables
resource "aws_route_table" "public_pub_route1" {
  vpc_id = aws_vpc.public_vpc.id
  tags = {
    Name = var.aws_pub_route1_table_name
  }
}

resource "aws_route" "public_route1" {
  route_table_id         = aws_route_table.public_pub_route1.id
  destination_cidr_block = var.allowed_cidrs[0]
  gateway_id             = aws_internet_gateway.public_igw.id
}

resource "aws_route_table_association" "public_pub_sub_association1" {
  count          = length(aws_subnet.public_pub_sub1)
  subnet_id      = aws_subnet.public_pub_sub1[count.index].id
  route_table_id = aws_route_table.public_pub_route1.id
}

# Private Subnets
resource "aws_subnet" "private_sub1" {
  count = length(var.private_subnet1_cidrs)
  vpc_id = aws_vpc.public_vpc.id
  cidr_block = element(var.private_subnet1_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.Private_Subnet1_Name}-${count.index}"
  }
}

resource "aws_subnet" "private_sub2" {
  count = length(var.private_subnet2_cidrs)
  vpc_id = aws_vpc.public_vpc.id
  cidr_block = element(var.private_subnet2_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.Private_Subnet2_Name}-${count.index}"
  }
}

resource "aws_subnet" "private_sub3" {
  count = length(var.private_subnet3_cidrs)
  vpc_id = aws_vpc.public_vpc.id
  cidr_block = element(var.private_subnet3_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.Private_Subnet3_Name}-${count.index}"
  }
}

resource "aws_subnet" "private_sub4" {
  count = length(var.private_subnet4_cidrs)
  vpc_id = aws_vpc.public_vpc.id
  cidr_block = element(var.private_subnet4_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.Private_Subnet4_Name}-${count.index}"
  }
}

# NAT Gateway
resource "aws_eip" "NAT_GW_EIP" {
  tags = {
    Name = var.NAT_GW_EIP_Name
  }
}

resource "aws_nat_gateway" "EKS_NAT" {
  allocation_id = aws_eip.NAT_GW_EIP.id
  subnet_id = aws_subnet.public_pub_sub1[0].id  # Select a valid public subnet
  tags = {
    Name = var.NAT_GW_Name
  }
}

# Private Route Tables
resource "aws_route_table" "private_route1" {
  vpc_id = aws_vpc.public_vpc.id
  tags = {
    Name = var.aws_priv_route1_table_name
  }
}

resource "aws_route" "private_route1_nat" {
  route_table_id         = aws_route_table.private_route1.id
  destination_cidr_block = var.allowed_cidrs[0]
  nat_gateway_id         = aws_nat_gateway.EKS_NAT.id
}

resource "aws_route_table_association" "private_sub1_association" {
  count          = length(aws_subnet.private_sub1)
  subnet_id      = aws_subnet.private_sub1[count.index].id
  route_table_id = aws_route_table.private_route1.id
}

resource "aws_route_table_association" "private_sub2_association" {
  count          = length(aws_subnet.private_sub2)
  subnet_id      = aws_subnet.private_sub2[count.index].id
  route_table_id = aws_route_table.private_route1.id
}

resource "aws_route_table_association" "private_sub3_association" {
  count          = length(aws_subnet.private_sub3)
  subnet_id      = aws_subnet.private_sub3[count.index].id
  route_table_id = aws_route_table.private_route1.id
}

resource "aws_route_table_association" "private_sub4_association" {
  count          = length(aws_subnet.private_sub4)
  subnet_id      = aws_subnet.private_sub4[count.index].id
  route_table_id = aws_route_table.private_route1.id
}

resource "aws_security_group" "eks_security_group" {
  name        = "eks-security-group"  # Use a static name
  description = "Security group for EKS cluster and nodes"
  vpc_id      = var.vpc_id

  // Ingress rules
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs  // Allowed CIDR blocks to access the cluster
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  // Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  // All traffic
    cidr_blocks = ["0.0.0.0/0"]  // Allow all outbound traffic
  }

  tags = {
    Name = var.security_group_name
  }
}


