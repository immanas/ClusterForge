terraform {
  backend "s3" {
    bucket         = "clusterforge-terraform-state"
    key            = "infra/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "clusterforge-terraform-lock"
    encrypt        = true
  }
}
