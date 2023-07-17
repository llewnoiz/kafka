module "security_group" {
  source  = "./modules/terraform-aws-security-group"
  # version = "~> 5.0"

  name        = local.name
  description = "Security group for ${local.name}"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.public_subnets_cidr_blocks
  ingress_rules = [
    "kafka-broker-sasl-scram-tcp",
    "kafka-broker-sasl-scram-public-tcp",
    "kafka-jmx-exporter-tcp",
    "kafka-node-exporter-tcp"
  ]  
  egress_rules = [ "all-all" ]
  tags = local.tags
}
