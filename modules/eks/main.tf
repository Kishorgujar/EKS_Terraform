resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

locals {
  account_id  = var.account_id
  environment = terraform.workspace
}

resource "aws_cloudwatch_log_group" "EKS_CLUSTER_LOGS" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7

  lifecycle {
  #  prevent_destroy = true
  }
}

resource "aws_eks_cluster" "this" {
  name                     = var.cluster_name
  role_arn                 = var.eks_role_arn  # Use the variable here
  version                  = var.kubernetes_version
  enabled_cluster_log_types = var.cluster_log_types

  tags = {
    Name = var.cluster_tag
  }

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
  }

  depends_on = [
    aws_cloudwatch_log_group.EKS_CLUSTER_LOGS
  ]
}

resource "aws_eks_node_group" "ec2_worker_nodes" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn  # Use the variable here
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  depends_on = [
    aws_eks_cluster.this
  ]
}

resource "aws_eks_addon" "Fargate_EKS_VPC_CNI" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "vpc-cni"

  depends_on = [
    aws_eks_cluster.this
  ]
}

resource "aws_eks_addon" "EKS_Coredns_cni" {
  cluster_name               = aws_eks_cluster.this.name
  addon_name                 = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_eks_node_group.ec2_worker_nodes
  ]
}

resource "aws_eks_addon" "EKS_kube_proxy_cni" {
  cluster_name               = aws_eks_cluster.this.name
  addon_name                 = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_eks_cluster.this
  ]
}

data "tls_certificate" "Cluster_TLS" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "EKS_IAM_Provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.Cluster_TLS.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "EKS_Cluster_CNI_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.EKS_IAM_Provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.EKS_IAM_Provider.arn]
      type        = "Federated"
    }
  }
}

data "aws_iam_policy_document" "EKS_Cluster_CNI_assume_role_policy_LB" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.EKS_IAM_Provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.EKS_IAM_Provider.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "EKS_VPC_CNI_Role" {
  assume_role_policy = data.aws_iam_policy_document.EKS_Cluster_CNI_assume_role_policy.json
  name               = "${local.environment}-vpc-cni-role-${random_string.suffix.result}"
}

resource "aws_iam_role" "EKS_LB_CNI_Role" {
  assume_role_policy = data.aws_iam_policy_document.EKS_Cluster_CNI_assume_role_policy_LB.json
  name               = "${local.environment}-lb-cni-role-${random_string.suffix.result}"
}

resource "aws_iam_role_policy_attachment" "EKS_VPC_CNI_Role_Attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.EKS_VPC_CNI_Role.name
}

resource "aws_iam_role_policy_attachment" "EKS_LB_CNI_Role_Attachment" {
  policy_arn = var.load_balancer_policy_arn  # Use the variable here
  role       = aws_iam_role.EKS_LB_CNI_Role.name
}

