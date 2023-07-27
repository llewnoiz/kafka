module "security_group" {
  source  = "./modules/terraform-aws-security-group"

  name        = local.name
  description = "MSK MySQL security group"
  vpc_id      = local.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = local.tags
}