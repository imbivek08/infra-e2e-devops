# RDS Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.env}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.env}-rds-subnet-group"
    Environment = var.env
  }
}

# KMS Key for RDS encryption
resource "aws_kms_key" "rds" {
  description             = "${var.env} RDS encryption key"
  deletion_window_in_days = 7

  tags = {
    Name        = "${var.env}-rds-kms"
    Environment = var.env
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  identifier        = "${var.env}-blog-db"
  engine            = "postgres"
  engine_version    = "16"
  instance_class    = var.db_instance_class
  allocated_storage = var.db_storage

  db_name  = "appdb"
  username = "appuser"
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]

  # Security
  storage_encrypted       = true
  kms_key_id             = aws_kms_key.rds.arn
  deletion_protection     = var.env == "prod" ? true : false
  skip_final_snapshot     = var.env == "prod" ? false : true
  final_snapshot_identifier = var.env == "prod" ? "${var.env}-blog-db-final-snapshot" : null

  # Backups
  backup_retention_period = var.env == "prod" ? 7 : 1
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  # Monitoring
  performance_insights_enabled = true
  monitoring_interval          = 60

  tags = {
    Name        = "${var.env}-blog-db"
    Environment = var.env
  }
}

# Store DB password in Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name                    = "${var.env}/blog/db-password"
  recovery_window_in_days = 7

  tags = {
    Environment = var.env
  }
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = "appuser"
    password = var.db_password
    host     = aws_db_instance.main.address
    port     = 5432
    dbname   = "appdb"
  })
}
