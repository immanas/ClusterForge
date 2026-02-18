module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = data.aws_vpc.selected.id
  subnet_ids = var.private_subnets

  enable_irsa = true

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}
