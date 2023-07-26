data "aws_availability_zones" "available" {}

locals {
  name   = "${var.kafa_cluster_prefix}-${basename(path.cwd)}"
  region = var.region
  profile = var.profile
  vpc_cidr = var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  secrets = ["producer", "consumer"]
  public_access = var.public_access #"SERVICE_PROVIDED_EIPS" #DISABLED
  instance_type = var.instance_type
  tfstate_bucket = var.tfstate_bucket
  terraform_state_lock = var.terraform_state_lock
  tfstate_key = var.tfstate_key
  source_connector = var.source_connector
  sink_connector = var.sink_connector
  bastion_instance_type = var.bastion_instance_type
  key_pair_name = var.key_pair_name
  tags = {
    Name: "송현민-msk-2",
    resource: "msk-2",
    purpose : "amano korea proj test",
    team : "SK MFG서비스",
    enddate: "23/07/28"
  }
}