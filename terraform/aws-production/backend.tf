terraform {
  backend "s3" {
    bucket       = "production-devops-platform-tfstate-94ee29d774e955e67b90fbf1c5"
    key          = "aws-production/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
