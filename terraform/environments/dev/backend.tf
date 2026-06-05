terraform {
  backend "s3" {
    bucket         = "blog-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "ap-northeast-1"
    use_lockfile = "blog-terraform-locks"
    encrypt        = true
  }
}
