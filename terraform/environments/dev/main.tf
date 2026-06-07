module "vpc" {
  source = "../../modules/vpc"

  env                  = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                  = ["ap-northeast-1a", "ap-northeast-1b"]
}

module "security" {
  source = "../../modules/security"

  env    = "dev"
  vpc_id = module.vpc.vpc_id
}

module "eks" {
  source = "../../modules/eks"

  env                = "dev"
  private_subnet_ids = module.vpc.private_subnet_ids
  eks_nodes_sg_id    = module.security.eks_nodes_sg_id
  node_instance_type = "t3.medium"
  node_desired       = 2
  node_min           = 1
  node_max           = 3
}

module "rds" {
  source = "../../modules/rds"

  env                = "dev"
  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.security.rds_sg_id
  db_instance_class  = "db.t3.micro"
  db_storage         = 20
  db_password        = var.db_password
}


module "ecr" {
  source = "../../modules/ecr"
  env    = "dev"
}
