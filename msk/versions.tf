terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket         = "amano-dev-tfstate"
    key            = "terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "amano-dev-state-lock"
    encrypt        = true
  }
}
