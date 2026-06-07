module "vpc" {
  source = "../../modules/vpc"

  env                  = "prod"
  vpc_cidr             = "10.1.0.0/16"
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
}

module "security" {
  source = "../../modules/security"

  env    = "prod"
  vpc_id = module.vpc.vpc_id
}

module "eks" {
  source = "../../modules/eks"

  env                = "prod"
  private_subnet_ids = module.vpc.private_subnet_ids
  eks_nodes_sg_id    = module.security.eks_nodes_sg_id
  node_instance_type = "t3.large"
  node_desired       = 3
  node_min           = 2
  node_max           = 6
}

module "rds" {
  source = "../../modules/rds"

  env                = "prod"
  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.security.rds_sg_id
  db_instance_class  = "db.t3.small"
  db_storage         = 50
  db_password        = var.db_password
}

module "ecr" {
  source = "../../modules/ecr"
  env    = "prod"
}
