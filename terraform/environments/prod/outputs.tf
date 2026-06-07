output "cluster_name" {
  value = module.eks.cluster_name
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "backend_repo_url" {
  value = module.ecr.backend_repo_url
}

output "frontend_repo_url" {
  value = module.ecr.frontend_repo_url
}
