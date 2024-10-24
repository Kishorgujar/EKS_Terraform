region              = "ap-south-1"
cluster_name        = "my-eks-cluster"
kubernetes_version  = "1.29"
cluster_role_arn    = "arn:aws:iam::${local.account_id}:role/EKSRole"
cluster_role_name   = "EKSRole"  # IAM role name for the EKS cluster
node_role_arn       = "arn:aws:iam::${local.account_id}:role/EKSNodeRole"
iam_role_node       = "arn:aws:iam::${local.account_id}:role/EKSNodeRole"  # Role for the node group
eks_role_arn = "arn:aws:iam::${local.account_id}:role/EKSRole"

