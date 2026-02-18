output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}
output "eks_cluster_role_arn" {
  value = module.iam.cluster_role_arn
}

output "eks_node_role_arn" {
  value = module.iam.node_role_arn
}
