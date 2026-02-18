module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}
module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}
module "eks_control" {
  source          = "./modules/eks"
  cluster_name    = "clusterforge-control"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "eks_dev" {
  source          = "./modules/eks"
  cluster_name    = "clusterforge-dev"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "eks_prod" {
  source          = "./modules/eks"
  cluster_name    = "clusterforge-prod"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}
