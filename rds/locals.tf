data "aws_availability_zones" "available" {}

locals {
  name   = "${var.rds_cluster_prefix}-${basename(path.cwd)}"
  region = var.region
  profile = var.profile
  vpc_cidr = var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tfstate_bucket = var.tfstate_bucket
  terraform_state_lock = var.terraform_state_lock
  tfstate_key = var.tfstate_key
  rds_subnet_ids= var.rds_subnet_ids
  database_subnet_group = var.database_subnet_group
  vpc_id = var.vpc_id
  password = var.rds_password
  manage_master_user_password = var.manage_master_user_password

  tags = {
    Name: "송현민-msk-2",
    resource: "msk-2",
    purpose : "amano korea proj test",
    team : "SK MFG서비스",
    enddate: "23/07/28"
  }
}