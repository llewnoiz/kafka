data "aws_availability_zones" "available" {}

locals {
  name   = "${var.kafa_cluster_prefix}-${basename(path.cwd)}"
  region = var.region
  profile = var.profile
  vpc_cidr = var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  secrets = ["producer", "consumer"]
  public_access = var.public_access #"SERVICE_PROVIDED_EIPS" #DISABLED
  tfstate_bucket = var.tfstate_bucket
  terraform_state_lock = var.terraform_state_lock
  tfstate_key = var.tfstate_key
  connector_external_url = var.connector_external_url
  connector = var.connector
  tags = {
    Name: "송현민-msk",
    resource: "msk",
    purpose : "amano korea proj test",
    team : "SK MFG서비스",
    enddate: "23/07/21"
  }
}