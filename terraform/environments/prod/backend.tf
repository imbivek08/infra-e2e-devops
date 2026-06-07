terraform {
  backend "s3" {
    bucket         = "blog-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile = "blog-terraform-locks"
    encrypt        = true
  }
}
