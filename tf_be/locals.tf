data "aws_availability_zones" "available" {}

locals {

  region = var.region
  profile = var.profile
  tfstate_bucket = var.tfstate_bucket
  terraform_state_lock = var.terraform_state_lock

  tags = var.tags 
}