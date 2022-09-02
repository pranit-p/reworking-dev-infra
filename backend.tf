terraform {
  backend "s3" {
    bucket  = "reworking-dev-tfstate-bucket"
    key     = "global/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
  }
}