terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket         = local.tfstate_bucket
    key            = local.tfstate_key
    region         = local.region
    dynamodb_table = local.terraform_state_lock
    encrypt        = true
  }
}
