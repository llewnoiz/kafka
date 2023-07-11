data "aws_availability_zones" "available" {}

locals {
  name   = "amano-${basename(path.cwd)}"
  region = var.region
  profile = var.profile
  vpc_cidr = var.vpc_cidr
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    Name: "송현민-msk",
    resource: "msk",
    purpose : "amano korea proj test",
    team : "SK&MFG서비스",
    enddate: "23/07/21"
  }
}