data "aws_availability_zones" "available" {}

locals {

  region = var.region
  profile = var.profile
  tfstate_bucket = var.tfstate_bucket
  terraform_state_lock = var.terraform_state_lock

  tags = {
    Name: "송현민-msk",
    resource: "msk",
    purpose : "amano korea proj test",
    team : "SK MFG서비스",
    enddate: "23/07/21"
  }
}