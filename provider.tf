provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      env               = "test"
      provisioner       = "terraform"
      github-repository = "infra-structure"
      project           = "reworking-dev"
    }
  }
}