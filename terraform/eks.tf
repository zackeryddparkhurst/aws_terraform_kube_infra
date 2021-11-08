resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster"

  # Role that Amazon EKS will use to create AWS resources for Kubernetes clusters
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {

  # The ARN of the policy you want to apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # The role the policy should be applied to
  role = aws_iam_role.eks_cluster.name

}

resource "aws_eks_cluster" "eks" {
  name = "eks"

  # The Amazon Resource Name (ARN) of the IAM role that providdes perms for the Kubernetes control plan to make calls to AWS API
  role_arn = aws_iam_role.eks_cluster.arn

  # Kubernetes master version
  version = "1.18"

  vpc_config {
    # Indicates whether or not the Amazon EKS private API server endpiont is enabled
    endpoint_private_access = false

    # Indicates whether or not the Amazon EKS public API server endpiont is enabled
    endpoint_public_access = true

    # Must be in at least two diff avialibility zones
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]

}