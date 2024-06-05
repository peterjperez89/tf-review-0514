// IAM Cluster Role
resource "aws_iam_role" "tfeksclusterrole" {
  name = "tfeksclusterrole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "eks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "tfpolicyattach1" {
  role       = aws_iam_role.tfeksclusterrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

// IAM Node Group Role
resource "aws_iam_role" "tfnodegrouprole" {
  name = "tfnodegrouprole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "tfpolicyattach2" {
  role       = aws_iam_role.tfnodegrouprole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "tfpolicyattach3" {
  role       = aws_iam_role.tfnodegrouprole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "tfpolicyattach4" {
  role       = aws_iam_role.tfnodegrouprole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

// EKS Cluster
resource "aws_eks_cluster" "tfcluster" {
  name     = "tfcluster"
  role_arn = aws_iam_role.tfeksclusterrole.arn
  vpc_config {
    subnet_ids = [
      var.sub1id,
      var.sub2id
    ]
    endpoint_public_access = true
    security_group_ids     = [var.sgid] #note: this does not give our nodes a security group! you need to assign a launch template to the nodegroup
  }
  depends_on = [aws_iam_role_policy_attachment.tfpolicyattach1]
}

resource "aws_eks_node_group" "tfnodegroup" {
  cluster_name    = aws_eks_cluster.tfcluster.name
  node_role_arn   = aws_iam_role.tfnodegrouprole.arn
  subnet_ids      = [var.sub1id, var.sub2id]
  ami_type        = "AL2_x86_64"
  instance_types  = ["t2.micro"]
  node_group_name = "tfnodegroup"
  launch_template {
    id = var.ltid
    version = var.ltver
  }
  scaling_config {
    desired_size = 4
    max_size     = 4
    min_size     = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.tfpolicyattach2,
    aws_iam_role_policy_attachment.tfpolicyattach3,
    aws_iam_role_policy_attachment.tfpolicyattach4, 
    #aws_launch_template.cluster_lt (called out in the root main.tf)
  ]
}