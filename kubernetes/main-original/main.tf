//vpc
resource "aws_vpc" "tfvpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tfvpc"
  }
}

resource "aws_subnet" "tfsub1" {
  vpc_id                  = aws_vpc.tfvpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tfsub1"
  }
}

resource "aws_subnet" "tfsub2" {
  vpc_id                  = aws_vpc.tfvpc.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "us-west-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "tfsub1"
  }
}

resource "aws_internet_gateway" "tfig" {
  vpc_id = aws_vpc.tfvpc.id

  tags = {
    Name = "tfig"
  }
}

//route tables
resource "aws_route_table" "tfrt" {
  vpc_id = aws_vpc.tfvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tfig.id
  }

  tags = {
    Name = "tfrt"
  }
}

resource "aws_route_table_association" "tfrta1" {
  route_table_id = aws_route_table.tfrt.id
  subnet_id      = aws_subnet.tfsub1.id
}

resource "aws_route_table_association" "tfrta2" {
  route_table_id = aws_route_table.tfrt.id
  subnet_id      = aws_subnet.tfsub2.id
}

// Security Group
resource "aws_security_group" "tfsg" {
  name        = "tfsg"
  description = "security group for EKS"
  vpc_id      = aws_vpc.tfvpc.id

  ingress {
    description = "ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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
      aws_subnet.tfsub1.id,
      aws_subnet.tfsub2.id
    ]
    endpoint_public_access = true
    security_group_ids     = [aws_security_group.tfsg.id] #note: this does not give our nodes a security group! you need to assign a launch template to the nodegroup
  }
  depends_on = [aws_iam_role_policy_attachment.tfpolicyattach1]
}

resource "aws_launch_template" "cluster_lt" {
  name = "cluster_lt"
  vpc_security_group_ids = [ aws_security_group.tfsg.id ]
  
  depends_on = [ aws_security_group.tfsg ]
}

resource "aws_eks_node_group" "tfnodegroup" {
  cluster_name    = aws_eks_cluster.tfcluster.name
  node_role_arn   = aws_iam_role.tfnodegrouprole.arn
  subnet_ids      = [aws_subnet.tfsub1.id, aws_subnet.tfsub2.id]
  ami_type        = "AL2_x86_64"
  instance_types  = ["t2.micro"]
  node_group_name = "tfnodegroup"
  launch_template {
    id = aws_launch_template.cluster_lt.id
    version = aws_launch_template.cluster_lt.latest_version
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
    aws_launch_template.cluster_lt
  ]
}